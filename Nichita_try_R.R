#Read data
library(tidyverse)

activists_df_rough <-  read_csv("output.csv")|>
  mutate(Age_int = as.numeric(Age))|>
  mutate(Death_year_int = as.numeric(Death_year))|>
  select(Name, Country, Death_year_int, Age_int, Death_cause)|>
  filter(Death_year_int > 1950)

#print()


life_expectancy_data <- read_csv("life-expectancy.csv")|>
  rename(life_expectancy = `Life expectancy (years)`, country_col = Entity)
  #print()

democratic_index_data <- read_csv("Human-Progress-Liberal-Democracy-Index.csv")

# This works! Everthing is converted to numeric, you can work with the dataset now :) let me know if you want me to explain what this code does! -Radost
for (column in names(democratic_index_data)){
  if (column != "country_name"){
    democratic_index_data[[column]] <- as.numeric(democratic_index_data[[column]])}
  }
print(democratic_index_data)

democratic_index_data_long <- pivot_longer(democratic_index_data, c(`1789`:`2024`), names_to = "Year", values_to = "Index")|>
  mutate(Year_int = as.numeric(Year))|>
  select(country_name, Year_int, Index)

 # print(democratic_index_data_long)


#Pivot life expectancy data

 activist_w_life_expect <- activists_df_rough |>
   left_join(life_expectancy_data, by = c("Country" = "country_col", "Death_year_int" = "Year"))
 #print()

 activist_df_complete <- activist_w_life_expect |>
   left_join(democratic_index_data_long, by = c("Country" = "country_name", "Death_year_int" = "Year_int"))|>
print()