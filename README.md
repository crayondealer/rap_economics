# Dockerized Pipeline with R

This repository replicates a data processing pipeline using Docker and {renv}. It includes the following files:
- Dockerfile: Defines the Docker image and configures the pipeline.
- functions.R: R functions needed to process the data.
- _targets.R: Runs the pipeline and calls the necessary functions.
- fig/econ_plot.png: The final plot output visualizing the data.
- README.md: This file.

##Dataset:
The dataset is from the World Bank and compares the GDP and life expectancy of various countries with Luxembourg, including the USA, China, Germany, Nigeria, and India. The final result is a plot that visualizes their relationship.

##Prerequisites
1. **Docker**: Ensure that you have Docker installed. You can download Docker from here.
  Installation Instructions:
  - Windows/Mac: Follow the Docker Desktop instructions.
  - Linux: Follow the Docker Engine installation guide.
2. **R and {renv}**: Docker will automatically install these within the container.

##To execute the pipeline:
1. Clone the repository:
```bash
git clone git@github.com:crayondealer/rap_economics.git
```
2. Build the Docker image. Run the following command inside the cloned repository folder:
```bash
docker build --no-cache -t my_r_project .
```
3. Run the pipeline. Use the following command to execute the pipeline:
```bash
docker run --no-cache -t my_r_project .
```
This will execute the code and produce a plot (fig/econ_plot.png) visualizing the data.

##Expected Output:
After running the pipeline, check the fig/ directory for the output plot, econ_plot.png, which visualizes the GDP and life expectancy comparisons of the countries with Luxembourg.