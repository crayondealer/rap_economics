# Multiple indicators example
indicators <- c(
  "SP.POP.TOTL",    # Total population
  "NY.GDP.PCAP.CD", # GDP per capita
  "SP.DYN.LE00.IN"  # Life expectancy
)

# Fetch multiple indicators
lux_data <- wb_data(
  indicator = indicators,
  country = "LUX",
  start_date = 1960,
  end_date = 2023
)

# Clean and format
lux_data_clean <- lux_data |>
  mutate(gdp = NY.GDP.PCAP.CD,
         lexp = SP.DYN.LE00.IN,
         pop = SP.POP.TOTL) |> 
  select(country, date, gdp, lexp, pop) 

# Plot one of the indicator
library(tidyverse)
library(scales)  # For better axis formatting


# Let's also create individual plots with actual values
# GDP plot
gdp_plot <- ggplot(lux_data_clean, aes(x = date, y = gdp)) +
  geom_line(color = "#2C3E50", linewidth = 1) +
  geom_point(color = "#2C3E50", size = 2) +
  theme_minimal() +
  scale_y_continuous(labels = scales::dollar_format()) +
  labs(title = "GDP per Capita Over Time",
       x = "",
       y = "") +
  theme(plot.title = element_text(face = "bold"))

# Life expectancy plot
lexp_plot <- ggplot(lux_data_clean, aes(x = date, y = lexp)) +
  geom_line(color = "#E74C3C", linewidth = 1) +
  geom_point(color = "#E74C3C", size = 2) +
  theme_minimal() +
  labs(title = "Life Expectancy Over Time",
       x = "",
       y = "") +
  theme(plot.title = element_text(face = "bold"))

# Population plot
pop_plot <- ggplot(lux_data_clean, aes(x = date, y = pop)) +
  geom_line(color = "#27AE60", linewidth = 1) +
  geom_point(color = "#27AE60", size = 2) +
  theme_minimal() +
  scale_y_continuous(labels = scales::comma_format()) +
  labs(title = "Population Growth Over Time",
       x = "",
       y = "") +
  theme(plot.title = element_text(face = "bold"))

# Optional: Combine all plots using patchwork
library(patchwork)

combined_plot <- gdp_plot + lexp_plot + pop_plot +
  plot_layout(ncol = 1) +
  plot_annotation(
    title = "Luxembourg Development Indicators",
    theme = theme(plot.title = element_text(size = 16, face = "bold"))
  )

print(combined_plot)
