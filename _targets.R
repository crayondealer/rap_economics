library(targets)
library(dplyr)
library(ggplot2)

source("functions.R")

countries<- c("USA", "CHN", "DEU", "NGA", "IND", "LUX")
ind<- c("SP.POP.TOTL", "NY.GDP.PCAP.CD", "SP.DYN.LE00.IN")

list(
  tar_target(
    econ_data, 
    fetch_country_data(countries, ind, start_year = 1960),
  ),
  
  tar_target(cleaned_data, calculate_development_score(econ_data)), 
  
  tar_target(econ_plot, make_plot(cleaned_data)),
  
  tar_target(
    create_output_dir,
    {
      if (!dir.exists("fig")) dir.create("fig", recursive = TRUE)
      "fig"  # Return the directory path for downstream targets
    }
  ),
  
  tar_target(econ_saved_plot, save_plot("fig/econ_plot.png", econ_plot), format = "file")
)
