# Tidying data

library(tidyverse)

# read in the data
cycle_counts <- read_csv("data/cycle_counts/he_ara_kotahi.csv")

# convert to long format, so that Direction and Count are columns

# use the mean by direction and hour to summarise, and plot the hourly counts for each direction
