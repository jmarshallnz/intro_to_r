# Implicit missing values with tidyr

# Load our libraries
library(tidyverse)

# read in the data
roll = read_csv("data/school_roll/roll_nomacrons.csv")

roll %>% filter(Students == 0)

# let's look at new entrants at Freyberg School
freyberg_new_entrants <- roll %>%
  filter(School == "Freyberg Community School") %>%
  filter(Level %in% c("Year 1"))

freyberg_new_entrants

# What happens when we pivot wider to a table
# of ethnicity vs gender:
freyberg_new_entrants %>%
  pivot_wider(names_from=Gender,
              values_from=Students)

# Filling the NA with a 0
freyberg_new_entrants %>%
  pivot_wider(names_from=Gender,
              values_from=Students,
              values_fill=0) %>%
  pivot_longer(Female:Male,
               names_to="Gender",
               values_to="Students")

# Completing a dataset:
freyberg_new_entrants %>%
  complete(EthnicGroup,Gender,School,Level)

# Fill the NA's in with a specific value:
freyberg_new_entrants %>%
  complete(EthnicGroup,Gender,School,Level,
           fill=list(Students = 0))

# Other ways to fill in NA
freyberg_new_entrants %>%
  complete(EthnicGroup,Gender,School,Level) %>%
  replace_na(list(Students = 0))
