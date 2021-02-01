# Joining datasets with dplyr

# Load our libraries
library(tidyverse)

# read in the data
roll = read_csv("data/school_roll/roll_nomacrons.csv")
schools = read_csv("data/school_roll/schools.csv")

# convert to a 'clean' version which fixes up the level to be numeric
clean = roll %>% mutate(Level = as.numeric(substring(Level, 6)))

# create a new data frame `all_data` joining the clean roll to the schools data
