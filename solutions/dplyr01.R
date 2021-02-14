# Data transformation with dplyr

# Load our libraries
library(tidyverse)

# read in the data
roll = read_csv("data/school_roll/roll_nomacrons.csv")

# take a nosy at what is in it
glimpse(roll)

# try filtering out Queen Elizabeth College that are Year 9
filter(roll, 
       School == "Queen Elizabeth College",
       Level == "Year 9")

# try filtering out Queen Elizabeth College that are NOT Year 9
filter(roll, 
       School == "Queen Elizabeth College",
       Level != "Year 9")

# try filtering out Queen Elizabeth College that are Year 9, 10 or 11
filter(roll, 
       School == "Queen Elizabeth College",
       Level %in% c("Year 9", "Year 10", "Year 11"))
   
# try filtering out Queen Elizabeth College that are NOT Year 9, 10 or 11
filter(roll, 
       School == "Queen Elizabeth College",
       !(Level %in% c("Year 9", "Year 10", "Year 11")))


# Find all rows where there are more than 100 Year 9 Asian students
filter(roll,
       Level == "Year 9",
       EthnicGroup == "Asian",
       Students > 100)

# the school name starts with the letter 'G'
filter(roll, 
       str_starts(School, "G"))

filter(roll, is.na(Students))

# Check that there are no 0 counts for Students
filter(roll,
       Students == 0)

# Arrange the roll rows by number of students, ascending
arrange(roll, Students)

# then descending
arrange(roll, desc(Students))

# looking at data - how do we do it?
# print it out just by typing the name
roll

# or use glimpse to just get an overview
glimpse(roll)

# View() is also useful (you get this when you
# double click on the data in the Environment)
View(roll)

# Find all rows where the ethnicity is Pacific
pacific_students = filter(roll, EthnicGroup == "Pacific")

# arranging them by decreasing number of students
arrange(pacific_students, desc(Students))

# Which school has the highest number of 
# International fee paying students at Year 13?
iy13 = filter(roll, 
              EthnicGroup == "International fee paying",
              Level == "Year 13")

arrange(iy13, desc(Students))


# Find all rows where the ethnicity is Pacific
# arranging them by decreasing number of students
pacific_students = filter(roll, EthnicGroup == "Pacific")
arrange(pacific_students, desc(Students))

# Using the pipe instead, we could do this:
roll %>% 
  filter(EthnicGroup == "Pacific") %>% 
  arrange(desc(Students))

roll %>% 
  filter(EthnicGroup == "International fee paying",
         Level == "Year 13") %>% 
  arrange(desc(Students))

# Rearrange the roll data set so that Students and Level are first.
roll %>% 
  select(Students, Level, everything())

# Another way to do this is with relocate()
roll %>% 
  relocate(Students, Level)

# Rename the School column to Name keeping all other columns.
roll %>% 
  select(Name = School, everything())

# Do the last bit with rename instead of select
roll %>% 
  rename(Name = School)
