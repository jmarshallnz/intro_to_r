# Implicit missing values with tidyr

# Load our libraries
library(tidyverse)

# read in the data
roll = read_csv("data/school_roll/roll_nomacrons.csv")

freyberg_new_entrants <- roll %>% filter(School == "Freyberg Community School") %>%
  filter(Level %in% c("Year 1"))

freyberg_new_entrants