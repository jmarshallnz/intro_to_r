# COVID-19 test performance
library(tidyverse)

# A study of 4653 close contacts of cases in Guangzhou, China who were quarantined and tested every 48 hours. The results of the first
# test, and whether they were later confirmed to be a case were given in table S3 here: https://www.medrxiv.org/content/10.1101/2020.03.24.20042606v1

covid <- tibble::tribble(~Confirmed, ~Test, ~Count,
                         "Yes", "Negative",36,
                         "Yes", "Positive", 92,
                         "No", "Negative",4523,
                         "No", "Positive",2)

# We can plot this in a couple of ways. First let's ignore the test results:
ggplot(data = covid) +
  geom_col(
    mapping = aes(
      x = Confirmed,
      y = Count
    )
  )

# We can then fill in by the test result. By default, we have a stacked bar chart
ggplot(data = covid) +
  geom_col(
    mapping = aes(
      x = Confirmed,
      y = Count,
      fill = Test
    )
  )

# We can alter it using `position`
ggplot(data = covid) +
  geom_col(
    mapping = aes(
      x = Confirmed,
      y = Count,
      fill = Test
    ),
    position = 'dodge'
  )
