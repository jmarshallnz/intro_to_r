# Data transformation with dplyr

# Load our libraries
library(tidyverse)

# read in the data
roll = read_csv("data/school_roll/roll_nomacrons.csv")

# convert to a 'clean' version which fixes up the level to be numeric
clean = roll %>% mutate(Level = as.numeric(substring(Level, 6)))

