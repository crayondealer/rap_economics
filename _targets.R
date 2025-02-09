# libraries to load
library(targets)
library(dplyr)
library(ggplot2)

# using the functions from functions.R
source("functions.R")

#some variables that can be changed if we want
countries<- c("USA", "CHN", "DEU", "NGA", "IND", "LUX")
ind<- c("SP.POP.TOTL", "NY.GDP.PCAP.CD", "SP.DYN.LE00.IN") #indicators: Population, GDP, Life expectancy

list(
  tar_target(
    econ_data, 
    fetch_country_data(countries, ind, start_year = 1960), #fetches data from World Bank 
  ),
  
  tar_target(cleaned_data, calculate_development_score(econ_data)), #cleans data
  
  tar_target(econ_plot, make_plot(cleaned_data)), #plots a chart of the relationship between countries and different indicators
  
  tar_target(
    create_output_dir,
    {
      if (!dir.exists("fig")) dir.create("fig", recursive = TRUE) #create dir if not present
      "fig"  # Return the directory path for downstream targets
    }
  ),
  
  tar_target(econ_saved_plot, save_plot("fig/econ_plot.png", econ_plot), format = "file") #save file in folder "fig"
)
