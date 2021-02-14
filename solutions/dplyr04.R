# Joining datasets with dplyr

# Load our libraries
library(tidyverse)

# read in the data
characters = read_csv("data/starwars/sw_characters.csv")
films = read_csv("data/starwars/sw_films.csv")

# code along below

# Try a left join: All rows from 'characters' will be included, and any rows from
# 'films' that match those rows will be included as well (duplicating info as needed)
# Anything in 'characters' that doesn't have a match in 'films' will be filled with NA
characters %>% left_join(films)

# A right join is basically the opposite: All rows from 'films' will be included,
# and any rows from 'characters' that match those rows will be included as well
# (duplicating info as needed). Anything in 'films' that doesn't have a match in
# 'characters' will be filled with NA
characters %>% right_join(films)
# This is the same as a left_join with the two datasets swapped
films %>% left_join(characters)

# Inner join returns only rows that exist in both datasets. So you shouldn't get
# new values of NA due to the join. Any data only in one of the datasets will be
# dropped.
characters %>% inner_join(films)

# Full join returns all rows in both datasets, so you'll get NAs where you don't
# have matches across both datasets, but all data will be present.
characters %>% full_join(films)

