# COVID-19 cases in NZ
library(tidyverse)
library(readxl)     # for reading from excel
library(janitor)    # for some tidying up

# Read in the case data in
covid_excel = read_excel("data/covid19/covid-cases-30july20.xlsx")

# We see it contains junk at the top. You could load the Excel sheet into Excel to see this too if you want!
covid_excel

# We can get rid of the junk by skipping the first 3 rows
covid_excel = read_excel("data/covid19/covid-cases-30july20.xlsx", skip=3)

# We tidy up the column names (e.g. get rid of spaces, make uniform capitalisation)
covid = covid_excel %>% clean_names()

# And do a plot
ggplot(covid) +
  geom_bar(mapping=aes(x=date_notified_of_potential_case))
