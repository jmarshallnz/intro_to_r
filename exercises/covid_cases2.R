# COVID-19 cases in NZ
library(tidyverse)
library(readxl)     # for reading from excel
library(janitor)    # for some tidying up
library(lubridate)  # for dates

# Read in the case data in and tidy up
covid = read_excel("data/covid19/covid-cases-30july20.xlsx", skip=3) %>%
  clean_names()

# Take a look at the type of data we have. Notice that the dates are of type dttm (Date time)
glimpse(covid)

# Grab just the overseas cases, and find how long after arrival they were a case. Differences
# in datetimes will be in seconds; the time_length() command converts to different units.
overseas = covid %>%
  filter(overseas_travel == "Yes") %>%
  mutate(difference = date_notified_of_potential_case - arrival_date,
         length = time_length(difference, unit="day"))
overseas
