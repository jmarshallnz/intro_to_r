# Data transformation with dplyr

# Load our libraries
library(tidyverse)

# read in the data
roll = read_csv("data/school_roll/roll_nomacrons.csv")

# convert to a 'clean' version which fixes up the level to be numeric
clean = roll %>% mutate(Level = as.numeric(substring(Level, 6)))

# create a new column combining ethnicgroup and gender with paste
clean %>% 
  mutate(EthnicGender = paste(EthnicGroup, Gender)) %>% 
  select(-EthnicGroup, -Gender)

clean %>% 
  mutate(EthnicGender = paste(EthnicGroup, Gender, "year", Level)) %>% 
  select(-EthnicGroup, -Gender)

# Find the largest number of students in any row

clean %>% 
  summarise(Maximum = max(Students))
  
# Find the median number of students across the rows
clean %>% 
  summarise(Median = median(Students))


# What is the lowest and highest year levels in the data?
clean %>% 
  summarise(Lowest = min(Level),
            Highest = max(Level))

# Find the number of Maori students in year 9
clean %>% 
  filter(EthnicGroup == "Maori",
         Level == 9) %>% 
  summarise(Total = sum(Students))


# How many students of each ethnicity are there?
clean %>% 
  group_by(EthnicGroup) %>% 
  summarise(Total = sum(Students))

# number of students in total
clean %>% 
  summarise(Total = sum(Students))


# How many students are there of each gender?
clean %>% 
  group_by(Gender) %>% 
  summarise(Total = sum(Students))


# Which school has the most female students in year 13?
clean %>% 
  filter(Gender == "Female",
         Level == 13) %>% 
  group_by(School) %>% 
  summarise(Total = sum(Students)) %>% 
  arrange(desc(Total))


# Produce a graph of the total number of
# students by year level
clean %>% 
  group_by(Level) %>% 
  summarise(Total = sum(Students)) %>% 
  ggplot() +
  geom_col(mapping = aes(x = Level, y = Total))

# same way but using an intermediate dataset
toplot = clean %>% 
  group_by(Level) %>% 
  summarise(Total = sum(Students))

ggplot(toplot) +
  geom_col(mapping = aes(x = Level, y = Total))


# Produce a graph of the total number of
# students by year level AND gender
clean %>% 
  group_by(Level, Gender) %>% 
  summarise(Total = sum(Students)) %>% 
  ggplot() +
  geom_col(mapping = aes(x = Level,
                         y = Total,
                         fill = Gender),
           position = "dodge")

clean %>% 
  group_by(Level, Gender) %>% 
  summarise(Total = sum(Students)) %>% 
  ggplot() +
  geom_col(mapping = aes(x = Level,
                         y = Total,
                         fill = Gender),
           position = "fill")
