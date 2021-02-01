# Data transformation with dplyr

# Load our libraries
library(tidyverse)

# read in the data
roll = read_csv("data/school_roll/roll_nomacrons.csv")

# take a nosy at what is in it
glimpse(roll)

# try filtering out Queen Elizabeth College from Year 9
