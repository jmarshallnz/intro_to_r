# Joining datasets with dplyr

# Load our libraries
library(tidyverse)

# read in the data
roll = read_csv("data/school_roll/roll_nomacrons.csv")
schools = read_csv("data/school_roll/schools.csv")

# convert to a 'clean' version which fixes up the level to be numeric
clean = roll %>% mutate(Level = as.numeric(substring(Level, 6)))

# create a new data frame `all_data` joining the clean roll to the schools data
all_data = clean %>% 
  left_join(schools)

# Same way of doing the join
all_data = left_join(clean, schools)

# How many students are there in each Regional Council?
all_data %>% 
  group_by(RegionalCouncil) %>% 
  summarise(Total = sum(Students))

# How many girls and boys are in schools with a religious affiliation?

# Two different ways to get the labels in affiliation type
unique(all_data$AffiliationType)
all_data %>% 
  count(AffiliationType)

all_data %>% 
  filter(AffiliationType == "Religious Affiliation") %>% 
  group_by(Gender) %>% 
  summarise(Total = sum(Students))

# Produce a chart to compare the ethnic makeup of secondary schools
# in Decile 10 versus those in Decile 1, excluding international 
# fee paying students.

all_data %>% 
  count(EthnicGroup)

all_data %>% 
  filter(EthnicGroup != "International fee paying",
         Decile %in% c(1, 10),
         Sector == "Secondary") %>% 
  group_by(EthnicGroup, Decile) %>% 
  summarise(Total = sum(Students)) %>% 
  ggplot() +
  geom_col(mapping = aes(x = EthnicGroup, 
                         y = Total,
                         fill = as.factor(Decile)),
           position = "dodge") + 
  labs(fill = "Decile")
