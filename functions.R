# Libraries to load
library(wbstats)
library(tidyverse)
library(scales)


# Data Collection Function
fetch_country_data <- function(countries, indicators, start_year = 1960) {
  wb_data(
    country = countries,
    indicator = indicators,
    start_date = start_year,
    end_date = 2022
  ) 
}

# Analysis Function
calculate_development_score <- function(data) {
  data |>
    group_by(country) |>
    mutate(
      gdp = NY.GDP.PCAP.CD, 
      lexp = SP.DYN.LE00.IN, 
      pop = SP.POP.TOTL,
      gdp_score = scale(NY.GDP.PCAP.CD),
      life_exp_score = scale(SP.DYN.LE00.IN),
      dev_score = (gdp_score + life_exp_score) / 2
    ) |>
    ungroup() |> 
    select(country, date, gdp, lexp, pop, gdp_score, life_exp_score, dev_score) 
}



# Visualization Function
make_plot <- function(data) {
  ggplot(data, 
         aes(x = gdp, 
             y = lexp, 
             color = country, 
             size = pop)) +
    geom_point(alpha = 0.5) +
    scale_x_log10(labels = scales::dollar_format()) +
    theme_minimal() +
    labs(title = "Development Indicators Relationship",
         subtitle = paste0("across countries ", paste(unique(data$country), collapse = ", ")),
         x = "GDP per capita (log scale)",
         y = "Life Expectancy"
    )
}



save_plot <- function(save_path, plot){
  ggsave(save_path, plot)
  save_path
}