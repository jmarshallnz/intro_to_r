library(tidyverse)

# yay, this looks like everything, saved the values with zero in it. Let's do some checking though
all = read_csv('/home/jcmarsha/OneDrive/teaching/161122/resources/_6-Pivot-Roll-by-Year-Level-and-Ethnicity-2010-2019.csv') %>%
  filter(`Year: As at 1 July` == 2019)

#all = read_excel('Roll-by-FYL-and-Ethnic-Group-2007-2017_fullsheet.xlsx', sheet="all_data") %>%


# grab the schools
schools = all %>% select(`School: ID`, `School: Name`:`Region: MOE Local office`) %>% unique
schools = schools %>% rename_at(vars(starts_with("School: "), starts_with("Region: ")), function(x) { substring(x, 9)} ) %>%
  select(-ID, -`Education Region`, -`MOE Local office`) %>% 
  rename(School = Name, SchoolGender = Gender) %>%
  rename_all(funs(stringr::str_replace_all(., ' ', ''))) %>%
  arrange(School) %>%
  mutate(RegionalCouncil = stringr::str_replace(RegionalCouncil, " Region", ""),
         TerritorialAuthority = stringr::str_replace(TerritorialAuthority, " City", ""),
         TerritorialAuthority = stringr::str_replace(TerritorialAuthority, " District", ""),
         TerritorialAuthority = stringr::str_replace(TerritorialAuthority, "Auckland- ", "Auckland: "),
         KuraType = stringr::str_replace(KuraType, " \\(Section 15[5-6]\\)", ""),
         Decile = readr::parse_number(Decile))

# and now the student rolls
roll = all %>% select(starts_with('Student'), `School: ID`, `School: Name`) %>%
  rename_at(vars(starts_with("Student: ")), function(x) { substring(x, 10) } ) %>%
  rename(SchoolID = `School: ID`, School = `School: Name`,
         EthnicGroup = `Ethnic Group`, Students = `Students (∑ Values)`,
         Level = `Year level`) %>%
  select(-`Year level group`) %>%
  select(School, Gender, EthnicGroup, Level, Students) %>%
  arrange(School, Level) %>%
  mutate(EthnicGroup = case_when(EthnicGroup == "European\\Pākehā" ~ "European",
                                 TRUE ~ EthnicGroup))

write_csv(roll, "/home/jcmarsha/OneDrive/teaching/161122/resources/roll.csv")
write_csv(schools, "/home/jcmarsha/OneDrive/teaching/161122/resources/schools.csv")
