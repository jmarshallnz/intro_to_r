# Pivoting with tidyr

# Load our libraries
library(tidyverse)

# read in the data
roll = read_csv("data/school_roll/roll_nomacrons.csv")

# convert to a 'clean' version which fixes up the level to be numeric
clean = roll %>% mutate(Level = as.numeric(substring(Level, 6)))

# 1. Create a table with total number of male and female students in each
#    year level.
#    Hint: group_by sex and year level then summarise.
#          Once done, pivot_wider to a table.
clean %>% 
  group_by(Level, Gender) %>% 
  summarise(Total = sum(Students)) %>%
  pivot_wider(names_from = Gender,
              values_from = Total)

# 2. Create a table with the number of students in
#    each ethnic group in each year level.
clean %>% 
  group_by(EthnicGroup, Level) %>% 
  summarise(Total = sum(Students)) %>%
  pivot_wider(names_from = EthnicGroup,
              values_from = Total)

# 3. Try adding a "Total" column to the ethnic group by gender table.
#    Hint: You could do this before the pivot_wider by using a mutate with
#    sum(Students).
clean %>% 
  group_by(EthnicGroup, Gender) %>% 
  summarise(Total = sum(Students)) %>%
  pivot_wider(names_from = Gender,
              values_from = Total) %>%
  mutate(Total = Female + Male)

# Alternate: Total up the Totals before we pivot:
clean %>% 
  group_by(EthnicGroup, Gender) %>% 
  summarise(Total = sum(Students)) %>%
  mutate(OverallTotal = sum(Total)) %>%
  pivot_wider(names_from = Gender,
              values_from = Total) %>%
  select(EthnicGroup, Female, Male,
         Total = OverallTotal)

# relocate also works:
clean %>% 
  group_by(EthnicGroup, Gender) %>% 
  summarise(Total = sum(Students)) %>%
  mutate(OverallTotal = sum(Total)) %>%
  pivot_wider(names_from = Gender,
              values_from = Total) %>%
  relocate(Total=OverallTotal, .after=Male)

# 4. Try creating a table with the percentage of female and male students
#    within each ethnic group.
#    Hint: You can add a new column with mutate() and get the percentage
#          by using Students/sum(Students) within each ethnic group.
clean %>% 
  group_by(EthnicGroup, Gender) %>% 
  summarise(Total = sum(Students)) %>%
  mutate(OverallTotal = sum(Total),
         Percent = Total/OverallTotal * 100) %>%
  select(-Total, -OverallTotal) %>%
  pivot_wider(names_from = Gender,
              values_from = Percent)

# What happens if we don't remove the Total column before we pivot wider?
# As the Total column is unique across our EthnicGroup+Gender combination,
# the rows won't be compressed into a single row - the data will be wider,
# but filled with NA:
clean %>% 
  group_by(EthnicGroup, Gender) %>% 
  summarise(Total = sum(Students)) %>%
  mutate(OverallTotal = sum(Total),
         Percent = Total/OverallTotal * 100) %>%
  pivot_wider(names_from = Gender,
              values_from = Percent)

# Get rid of the Total column first, then all rows will no longer
# be unique once pivoted, so they'll compress down:
clean %>% 
  group_by(EthnicGroup, Gender) %>% 
  summarise(Total = sum(Students)) %>%
  mutate(OverallTotal = sum(Total),
         Percent = Total/OverallTotal * 100) %>%
  select(-Total) %>%
  pivot_wider(names_from = Gender,
              values_from = Percent)

# Combining columns, and separating using separate:
combined = clean %>% mutate(EthnicityGender = paste(EthnicGroup, Gender)) %>%
  select(-EthnicGroup, -Gender)
combined

# use separate to split out the new EthnicityGender column. Notice this gets a warning message
combined %>% separate(EthnicityGender, into=c("EthnicGroup", "Gender"))
# the warning is about row 134 (among others) - let's see what that is:
combined %>% slice(134)
# Ahh - we have an entry with lots of spaces, so it splits up into 4 items there, though we
# only gave it 2 column names. Hmm, this is tricky to deal with - using extract() would be
# the way to go I think. For now, let's re-combine with a different separating character
# so we can see how it is *Supposed* to work:
combined = clean %>% mutate(EthnicityGender = paste(EthnicGroup, Gender, sep="_")) %>%
  select(-EthnicGroup, -Gender)
combined
# now we can give sep="_" to the separate()
combined %>% separate(EthnicityGender, into=c("EthnicGroup", "Gender"), sep="_")

# using unite() to do the combination is easier:
clean %>% unite(EthnicityGender, EthnicGroup, Gender)
