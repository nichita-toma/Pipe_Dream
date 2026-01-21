library(tidyverse)

activists_df <-  read_csv("data_activists")

life_expectancy_data <- read_csv("data_life_expectancy")

democratic_index_data <- read_csv("data_democratic_index")

#calculate the mean value of the lifespan
life_expectancy_df_mean <-  life_expectancy_data |>
  mutate(life_expectancy_average = 1950-1955 + 1955-1960 + 1960-1965 + 1965-1970 + 1970-1975 + 1975-1980)
  select(country, life_expectancy_mean)

#give a label of democratic-non-democratic for each country
lifespan_df <- life_expectancy_df_mean |>
  mutate(democracy_status = ifelse(democratic_index >= 0.6, democratic, non-democratic)) |>
  group_by('democracy_status')
  


#Make scatterplot
ggplot(lifespan_df) +
  aes(x = lifespan, y = democratic_index)