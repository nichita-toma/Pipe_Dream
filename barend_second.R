#Read data
library(tidyverse)

activists_df_rough <-  read_csv("output.csv")|>
  mutate(Age_int = as.numeric(Age))|>
  mutate(Death_year_int = as.numeric(Death_year))|>
  select(Name, Country, Death_year_int, Age_int, Death_cause)|>
  filter(Death_year_int > 1950)



#ADDITION OF LIFE EXPECTANCY DATA INTO ACTIVIST DATA
life_expectancy_data <- read_csv("life-expectancy.csv")|>
  rename(life_expectancy = `Life expectancy (years)`, country_col = Entity)
  

activist_w_life_expect <- activists_df_rough |>
  left_join(life_expectancy_data, by = c("Country" = "country_col", "Death_year_int" = "Year"))

#BAR CHART CODE (RATIO VALUE AND PERCENTAGE OF DEATH CATEGORY)
#Calculate ratio value
activist_w_ratio <- activist_w_life_expect |>
  mutate(lifespan_ratio = (Age_int/life_expectancy) * 100) |>
  mutate(lifespan_label = ifelse(lifespan_ratio >= 100, "Late death", "Early death")) |>
  filter(!is.na(lifespan_label)) 

#Calculate ratio percentage
category_counts <- activist_w_ratio |>
  count(lifespan_label, name = "n_activists") |>
  mutate(
    percentage = n_activists/sum(n_activists) * 100
  ) 
 

#Make bar chart with ratio early death vs late death
barchart_percentage_of_life_expectancy <- ggplot(category_counts) +
  aes(x = lifespan_label, y = percentage) +
  geom_col(fill = "tomato") +
  labs(x = "Death Category",
      y = "Lifespan as percentage of life expectancy (%)",
      title = "Activist lifespan compared to national life expectancy",
      caption = "Note: Expected lifespan based on country-specific life expectancy in the year of passing of the activist") +
  theme_minimal() 

#OBTAIN AND CLEAN DEMOCRATIC INDEX DATA
democratic_index_data <- read_csv("Human-Progress-Liberal-Democracy-Index.csv")

for (column in names(democratic_index_data)){
  if (column != "country_name"){
    democratic_index_data[[column]] <- as.numeric(democratic_index_data[[column]])}
  }


democratic_index_data_long <- pivot_longer(democratic_index_data, c(`1789`:`2024`), names_to = "Year", values_to = "Index")|>
  mutate(Year_int = as.numeric(Year))|>
  select(country_name, Year_int, Index)

 # print(democratic_index_data_long)

 activist_df_complete <- activist_w_life_expect |>
   left_join(democratic_index_data_long, by = c("Country" = "country_name", "Death_year_int" = "Year_int")) |>
   print()


#OBTAIN DIFFERENCE VALUE FOR MAIN SCATTERPLOT
activist_w_diff <- activist_df_complete |>
   mutate(age_diff = abs(Age_int - life_expectancy)) |>
   group_by(Country) |>
   summarise(mean_difference = mean(age_diff),
   n_entries = n()) |>
  filter(n_entries >= 5) 
 

#OBTAIN MEAN DEMOCRATIC INDEX PER COUNTRY
country_di_summary <- democratic_index_data_long |>
  group_by(country_name) |>
  summarise(
  mean_DI = mean(Index, na.rm = TRUE),
  sd_DI = sd(Index, na.rm = TRUE)) |>
  print()

activist_df_meanDI <- activist_w_diff |>
  left_join(
    country_di_summary,
    by = c("Country" = "country_name")
  ) |>
  drop_na() |>
  print()

#COMPUTE SCATTERPLOT
scatterplot_relative_life_expectancy_vs_democracy <- ggplot(activist_df_meanDI) +
  aes(x = mean_difference, y = mean_DI) +
  labs(
    x = "Mean relative life expectancy per country (years)",
    y = "Mean democratic index (1950-2024)",
    title = "Relative life expectancy of activists vs mean country democracy level",
    caption = "Note: Relative life expectancy = |Actual age - National life expectancy at time of death|"
) +
  geom_point(size = 2, color = "red") +
  geom_text(aes(label = Country), 
            size = 3, 
            vjust = -1,  # Adjust vertical position
            hjust = 0.1) +
  theme_minimal()

print(scatterplot_main)

#CALCULATE REGIONAL DATA
#Sorting into regions:
activist_w_region <- activist_w_ratio |>
  mutate(
    region = case_when(
      #North America
      Country %in% c("United States", "USA", "US", "Canada", "Mexico", "Barbados", "Haiti") ~ "North America",

      #Europe
      Country %in% c("Bosnia & Herzegovina", "United Kingdom", "UK", "England", "Scotland", "Wales",
                           "Germany", "France", "Italy", "Spain", "Portugal",
                           "Netherlands", "Belgium", "Switzerland", "Austria",
                           "Sweden", "Norway", "Denmark", "Finland", "Ireland", "Russia",
                            "Ukraine", "Poland", "Czech Republic",
                           "Hungary", "Romania", "Bulgaria", "Serbia", "Croatia", "Lithuania", "Czechia", "Moldova", "Greece", "Cyprus", "Slovenia", "Albania") ~ "Europe",
      
      #Latin America
      Country %in% c("Brazil", "Argentina", "Chile", "Colombia", "Peru",
                           "Venezuela", "Uruguay", "Paraguay", "Bolivia",
                           "Ecuador", "Costa Rica", "Panama", "Belize", "Honduras", "Dominica", "El Salvador", "Cuba") ~ "Latin America",   
      
      #Middle East
      Country %in% c("Israel", "Palestine", "Saudi Arabia", "Iran", "Iraq",
                           "Turkey", "Lebanon", "Jordan", "Syria", "Yemen") ~ "Middle East",
      
      #Africa
      Country %in% c("South Africa", "Nigeria", "Egypt", "Kenya", "Ethiopia",
                           "Ghana", "Morocco", "Tanzania", "Uganda", "Zimbabwe", "Eritrea", "Cameroon", "Zambia", "Mozambique", "Namibia", "Algeria", "Congo (Congo-Brazzaville)", "Libya", "Somalia", "Malawi" ) ~ "Africa",
      
      #Asia
      Country %in% c("China", "Japan", "India", "South Korea", "North Korea",
                           "Pakistan", "Bangladesh", "Sri Lanka", "Nepal",
                           "Philippines", "Indonesia", "Vietnam", "Thailand",
                           "Malaysia", "Singapore", "Armenia", "Kazakhstan", "Bahrain", "Azerbaijan", "Cambodia", "Afghanistan") ~ "Asia",
      
      #Oceania
      Country %in% c("Australia", "New Zealand", "Fiji", "Marshall Islands", "Vanuatu", "Papua New Guinea") ~ "Oceania",

      #Other, such as misspelling etc
      TRUE ~ "Other"
    )
  ) 

#Count how many in each region
  region_counts <- activist_w_region |>
  count(region, name = "n_region") |>
    mutate(
    percentage = n_region/sum(n_region) * 100
  ) 
  

#Count how many per country
country_counts <- activist_w_region |>
  count(Country, name = "n_country") |>
    mutate(
    percentage = n_country/sum(n_country) * 100
  ) |>
  arrange(desc(percentage)) |>
  print()

ggsave("barchart_percentage.png", 
       plot = barchart_percentage_of_life_expectancy,
       width = 8, height = 6, dpi = 300)

# Save the scatterplot
ggsave("scatterplot_relative_life_expectancy.png", 
       plot = scatterplot_relative_life_expectancy_vs_democracy,
       width = 10, height = 6, dpi = 300)
