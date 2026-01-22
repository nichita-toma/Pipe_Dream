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

democratic_index_data <- read_csv("Human-Progress-Liberal-Democracy-Index.csv")|>

  pivot_longer(c(`1789`:`2024`), names_to = "Year", values_to = "Index")|>
  print()


#Pivot life expectancy data

activist_w_life_expect <- activists_df_rough |>
  left_join(life_expectancy_data, by = c("Country" = "country_col", "Death_year_int" = "Year"))
#print()

activist_df_complete <- activist_w_life_expect |>
  left_join()