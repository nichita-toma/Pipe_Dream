#Read data
library(tidyverse)

activists_df_rough <-  read_csv("output.csv")|>
  mutate(Age_int = as.numeric(Age))|>
  mutate(Death_year_int = as.numeric(Death_year))|>
  select(Name, Country, Death_year_int, Age_int, Death_cause)|>
  filter(Death_year_int > 1950)


  print(distinct(activists_df_rough, Country), n = 96)


life_expectancy_data <- read_csv("life-expectancy.csv")|>
  rename(life_expectancy = `Life expectancy (years)`, country_col = Entity)
  #print()

# democratic_index_data <- read_csv("Human-Progress-Liberal-Democracy-Index.csv")|>

#   pivot_longer(c(`1789`:`2024`), names_to = "Year", values_to = "Index")|>
#   print()


#Add life expectancy data to activists
activist_w_life_expect <- activists_df_rough |>
  left_join(life_expectancy_data, by = c("Country" = "country_col", "Death_year_int" = "Year")) |>
print()






















# #Read data
# library(tidyverse)

# activists_df_rough <-  read_csv("output.csv")
# activists_young <- activists_df_rough |>
#   filter(Age <= 20 ) 


# life_expectancy_data_long <- read_csv("life-expectancy.csv")
# colnames(life_expectancy_data_long)
# democratic_index_data <- read_csv("Human-Progress-Liberal-Democracy-Index.csv")
# print(democratic_index_data)
# #Rename columns activist data
#   rename(activists_df_rough,
#     country_origin = Country,
#     name = Name,
#     age_activist = Age,
#     death_year = Death_year,
#     death_cause = Death_cause
#   ) 

# print(activists_df_rough)
# #Pivot life expectancy data


# life_expectancy_data <- life_expectancy_data_long |>
#   rename(life_expectancy = `Life expectancy (years)`, country_lifespan = Entity)|>
#   # pivot_wider(
#   # names_from = Year, values_from = life_expectancy) |>
#   # select(-Code)

# print(life_expectancy_data_long)
# #Calculate the mean value of the lifespan
# activist_df_life_expectancy <- activists_df_rough |>
#   left_join(life_expectancy_data_long, 
#   by = c("Country" = "Entity", 'Death_year' = 'Year')) |>

# head(activist_df_life_expectancy)


# life_expectancy_df_mean <-  life_expectancy_data |>
#   mutate(
#     life_expectancy_average = (
#       1950-1955 + 1955-1960 + 1960-1965 + 1965-1970 
#        + 1970-1975 + 1975-1980)/6) |>
#   select(country = country_lifespan, life_expectancy_average)


#Find regional data
activists_df_withregion <- activists_df_rough |>
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
  

  
  
# #Add average life expectancy to activist data
# activists_with_LE <- activists_df_withregion |>
#   left_join(life_expectancy_df_mean, 
#   by = c("country_origin" = "country")) #Here, "country_origin" is the countries as listed in activist data, "country" is from the life expectancy data

# print(activists_with_LE)
# #pivot democratic index data
# democratic_index_long <- democratic_index_data |>
#   pivot_longer(cols()
#         names_to =  year, 
#     values_to = democratic_index)





# #Add democratic index in country of origin at year of death
# activist_df_complete <- activists_with_LE |>
#   left_join(democratic_index_long, 
#   by = c("country_origin" = "country_name", "death_year" = "year")) #Here, "country_origin" is the countries as listed in activist data, "country" is from the democratic index data

# #Give a label of democratic-non-democratic for each country
# df_with_label <- activist_df_complete |>
#   mutate(democracy_status = ifelse(democratic_index >= 0.6, "democratic", "non-democratic")) |>
#   group_by(democracy_status)

# #Analysis
# #Ratio for difference average activist:
# df_ratio <- df_with_label |>
#   mutate(lifespan_ratio = age_int/life_expectancy) #Here, age_activist is the age that the activist died, and we divide by the average life expectancy in their country
