# Immunisation information
library(tidyverse)

# Read in the vaccination data
vacc = read_csv("data/vaccinations.csv")

# Compute the proportion immunised
immunity = mutate(vacc, Proportion = Eligible / Immunised)

# Pick out just 8 month year olds
immunity8months = filter(immunity, Age == "8 months")

# Pick out a single DHB
immunityDHB = filter(immunity, DHB == "Auckland") # change to another one if you like!
