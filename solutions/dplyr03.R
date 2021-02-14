# Data transformation with dplyr

# Load our libraries
library(tidyverse)

# read in the data
hrc = read_csv("data/horizons_river_quality/horizons_river_ecoli.csv")

# code along below

hrc %>% 
  select(Symbol, Value, everything())


hrc %>% 
  relocate(Symbol, Value)


# 1. Which are the best or worst sites 
# on average (e.g. by Median)?
hrc %>% 
  group_by(Site) %>% 
  summarise(Median = median(Value)) %>% 
  arrange(Median)

hrc %>% 
  group_by(Site) %>% 
  summarise(Median = median(Value)) %>% 
  arrange(desc(Median))


# 2. Which sites do we not have much data on? 
# Hint: How many observations per site?
hrc %>% 
  group_by(Site) %>% 
  summarise(Nb_observations = n()) %>% 
  arrange(Nb_observations)

hrc %>% 
  count(Site) %>% 
  arrange(n)

# 3. Which sites are new? 
# Hint: Find the first date for each site, then order by the first date.
hrc %>% 
  group_by(Site) %>% 
  summarise(first_date = min(Date)) %>% 
  arrange(desc(first_date))


# 4. Which sites are tested infrequently? 
# Hint: Find the first and last date for each site, 
# then the difference between them to get the time 
# each site has been tested over. The number of observations
# then helps get the frequency.

hrc %>% 
  group_by(Site) %>% 
  summarise(nb_observations = n(),
            earliest_date = min(Date),
            latest_date = max(Date)) %>% 
  mutate(range_date = latest_date - earliest_date,
         time_between_tests = range_date / nb_observations) %>% 
  arrange(desc(time_between_tests))




