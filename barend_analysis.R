#Read data
library(tidyverse)

activists_df_rough <-  read_csv("data_activists")

life_expectancy_data <- read_csv("data_life_expectancy")

democratic_index_data <- read_csv("data_democratic_index")

#Calculate the mean value of the lifespan
life_expectancy_df_mean <-  life_expectancy_data |>
  mutate(
    life_expectancy_average = (
      `1950-1955` + `1955-1960` + `1960-1965` + `1965-1970` 
       + `1970-1975` + `1975-1980`)/6) |>
  select(country, life_expectancy_mean)

#Find regional data
activists_df_withregion <- life_expectancy_df_mean |>
  mutate(
    region = case_when(
      #North America
      country_origin %in% c("United States", "USA", "US", "Canada", "Mexico") ~ "North America",

      #Europe
      country_origin %in% c("United Kingdom", "UK", "England", "Scotland", "Wales",
                           "Germany", "France", "Italy", "Spain", "Portugal",
                           "Netherlands", "Belgium", "Switzerland", "Austria",
                           "Sweden", "Norway", "Denmark", "Finland", "Ireland", "Russia",
                            "Ukraine", "Poland", "Czech Republic",
                           "Hungary", "Romania", "Bulgaria", "Serbia", "Croatia") ~ "Europe",
      
      #Latin America
      country_origin %in% c("Brazil", "Argentina", "Chile", "Colombia", "Peru",
                           "Venezuela", "Uruguay", "Paraguay", "Bolivia",
                           "Ecuador", "Costa Rica", "Panama") ~ "Latin America",   
      
      #Middle East
      country_origin %in% c("Israel", "Palestine", "Saudi Arabia", "Iran", "Iraq",
                           "Turkey", "Lebanon", "Jordan", "Syria", "Yemen") ~ "Middle East",
      
      #Africa
      country_origin %in% c("South Africa", "Nigeria", "Egypt", "Kenya", "Ethiopia",
                           "Ghana", "Morocco", "Tanzania", "Uganda", "Zimbabwe") ~ "Africa",
      
      #Asia
      country_origin %in% c("China", "Japan", "India", "South Korea", "North Korea",
                           "Pakistan", "Bangladesh", "Sri Lanka", "Nepal",
                           "Philippines", "Indonesia", "Vietnam", "Thailand",
                           "Malaysia", "Singapore") ~ "Asia"
      
      #Oceania
      country_origin %in% c("Australia", "New Zealand", "Fiji") ~ "Oceania",

      #Other, such as misspelling etc
      TRUE ~ "Other"
    )
  ) 
  
#Add average life expectancy to activist data
activists_with_LE <- activists_df_withregion |>
  left_join(life_expectancy_df_mean, 
  by = c("country_origin" = "country")) #Here, "country_origin" is the countries as listed in activist data, "country" is from the life expectancy data

#Add democratic index in country of origin at year of death
activist_df_complete <- activists_with_LE |>
  left_join(democratic_index_data, 
  by = c("country_origin" = "country", "death_year" = "year")) #Here, "country_origin" is the countries as listed in activist data, "country" is from the democratic index data

#Give a label of democratic-non-democratic for each country
df_with_label <- activist_df_complete |>
  mutate(democracy_status = ifelse(democratic_index >= 0.6, democratic, non-democratic)) |>
  group_by('democracy_status')



#Make scatterplot
ggplot(lifespan_df) +
  aes(x = lifespan, y = democratic_index)