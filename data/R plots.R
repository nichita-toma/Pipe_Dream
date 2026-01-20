data <- read.csv("nationalities.csv")

names(data)

countries <- data$nationality


>countries_comma <- data$nationality |>
 unique() |>
 na.omit() |>
   sort() |>
  paste(collapse = ", ")


writeLines(countries_comma, "countries_comma_separated.txt")

writeLines(countries_comma, "countries_comma_separated.txt")
