#Read data
library(tidyverse)

activists_df_rough <-  read_csv("output.csv")

life_expectancy_data_long <- read_csv("life-expectancy.csv")

democratic_index_data <- read_csv("Human-Progress-Liberal-Democracy-Index.csv")

#Pivot life expectancy data


life_expectancy_data <- life_expectancy_data_long |>
  rename('life_expectancy' = Life Expectancy (years))
  pivot_wider(cols('Entity', 'Years' , 'Life Expectancy (years)'),
  names_to = 'Year', values_to = 'Life expectancy (years)')


#Calculate the mean value of the lifespan
life_expectancy_df_mean <-  life_expectancy_data |>
  mutate(
    life_expectancy_average = (
      1950-1955 + 1955-1960 + 1960-1965 + 1965-1970 
       + 1970-1975 + 1975-1980)/6) |>
  select(country = Location, life_expectancy_average)

#Find regional data
activists_df_withregion <- activists_df_rough |>
  mutate(
    region = case_when(
      #North America
      Country %in% c("United States", "USA", "US", "Canada", "Mexico") ~ "North America",

      #Europe
      Country %in% c("United Kingdom", "UK", "England", "Scotland", "Wales",
                           "Germany", "France", "Italy", "Spain", "Portugal",
                           "Netherlands", "Belgium", "Switzerland", "Austria",
                           "Sweden", "Norway", "Denmark", "Finland", "Ireland", "Russia",
                            "Ukraine", "Poland", "Czech Republic",
                           "Hungary", "Romania", "Bulgaria", "Serbia", "Croatia") ~ "Europe",
      
      #Latin America
      Country %in% c("Brazil", "Argentina", "Chile", "Colombia", "Peru",
                           "Venezuela", "Uruguay", "Paraguay", "Bolivia",
                           "Ecuador", "Costa Rica", "Panama") ~ "Latin America",   
      
      #Middle East
      Country %in% c("Israel", "Palestine", "Saudi Arabia", "Iran", "Iraq",
                           "Turkey", "Lebanon", "Jordan", "Syria", "Yemen") ~ "Middle East",
      
      #Africa
      Country %in% c("South Africa", "Nigeria", "Egypt", "Kenya", "Ethiopia",
                           "Ghana", "Morocco", "Tanzania", "Uganda", "Zimbabwe", "Namibia") ~ "Africa",
      
      #Asia
      Country %in% c("China", "Japan", "India", "South Korea", "North Korea",
                           "Pakistan", "Bangladesh", "Sri Lanka", "Nepal",
                           "Philippines", "Indonesia", "Vietnam", "Thailand",
                           "Malaysia", "Singapore") ~ "Asia",
      
      #Oceania
      Country %in% c("Australia", "New Zealand", "Fiji") ~ "Oceania",

      #Other, such as misspelling etc
      TRUE ~ "Other"
    )
  ) |>
  
  rename(
    country_origin = Country,
    name = Name,
    age_activist = Age,
    death_year = Death_year,
    death_cause = Death_cause
  ) 
  
  
#Add average life expectancy to activist data
activists_with_LE <- activists_df_withregion |>
  left_join(life_expectancy_df_mean, 
  by = c("country_origin" = "country")) #Here, "country_origin" is the countries as listed in activist data, "country" is from the life expectancy data

#pivot democratic index data
democratic_index_long <- democratic_index_data |>
  pivot_longer(
    cols = -country,
    names_to =  "year", 
    values_to = "democratic_index")




#Add democratic index in country of origin at year of death
activist_df_complete <- activists_with_LE |>
  left_join(democratic_index_long, 
  by = c("country_origin" = "country_name", "death_year" = "year")) #Here, "country_origin" is the countries as listed in activist data, "country" is from the democratic index data

#Give a label of democratic-non-democratic for each country
df_with_label <- activist_df_complete |>
  mutate(democracy_status = ifelse(democratic_index >= 0.6, "democratic", "non-democratic")) |>
  group_by(democracy_status)

#Analysis
#Ratio for difference average activist:
df_ratio <- df_with_label |>
  mutate(lifespan_ratio = age_activist/life_expectancy_average) #Here, age_activist is the age that the activist died, and we divide by the average life expectancy in their country
