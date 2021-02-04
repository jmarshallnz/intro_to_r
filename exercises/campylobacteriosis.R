# Modelling Campylobacteriosis rates in NZ

# Load our libraries
library(tidyverse)
library(lubridate)

# read in the data
campy_dat <- read_csv("data/campy/campy.csv")

# add month information
campy <- campy_dat %>% mutate(Month = month(Date, label=TRUE, abbr=FALSE))

# plot the data
ggplot(campy) +
  geom_line(aes(x=Date, y=Cases)) +
  facet_wrap(vars(DHB), ncol=5)

# check seasonality
ggplot(campy) +
  geom_col(aes(x=Month, y=Cases/Population)) +
  facet_wrap(vars(DHB), ncol=5)

# model the data below. We probably want a seasonal effect of month, plus a trend
# (maybe just a linear trend with Date?). We'll need to include an offset for Population
# as obviously the cases would scale with DHB population.
