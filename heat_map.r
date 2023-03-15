# Load libraries
library(leaflet)
library(dplyr)
library(mapview)

# Import data
crime_data <- read.csv("MPS Borough Level Crime (most recent 24 months).csv")

# Data preprocessing
crime_data <- crime_data %>%
  filter(!is.na(latitude) & !is.na(longitude))

# Create heatmap
crime_map <- leaflet(crime_data) %>%
  addTiles() %>%
  addHeatmap(
    lng = ~longitude,
    lat = ~latitude,
    radius = 10,
    gradient = colorNumeric(
      palette = "Reds",
      domain = crime_data$major_category
    )
  )

# Display map
mapview(crime_map)
