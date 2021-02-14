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

# We can alter it using `position`. dodge puts things
# side by side
ggplot(data = covid) +
  geom_col(
    mapping = aes(
      x = Confirmed,
      y = Count,
      fill = Test
    ),
    position = 'dodge'
  )

# We can alter it using `position`. fill stacks, but switches
# to proportions instead of counts
ggplot(data = covid) +
  geom_col(
    mapping = aes(
      x = Confirmed,
      y = Count,
      fill = Test
    ),
    position = 'fill'
  )
# here we can see that those that have COVID-19 only get
# detected in the test around 70% of the time. 30% of the
# time the test returns negative, even though they have it.
# (false negatives)

# If they don't have COVID-19, then the test almost always returns
# a negative (i.e. false positives are rare).

# Switching the plot around:
ggplot(data = covid) +
  geom_col(
    mapping = aes(
      x = Test,
      y = Count,
      fill = Confirmed
    ),
    position = 'fill'
  )
# This shows what our conclusion might be after the test result
# If the test is positive, then we can be pretty sure the
# person has COVID-19. If the test is negative, then it suggests
# the person doesn't have COVID-19.

# BUT: We need to be careful here - the proportions are masking
# the extent (count of people).
ggplot(data = covid) +
  geom_col(
    mapping = aes(
      x = Test,
      y = Count,
      fill = Confirmed
    ),
    position = 'dodge'
  )
# There are LOTS of people who test negative, and a small proportion
# of them is actually quite a few people!

# If we are testing lots of people, then the false negative rate
# is super important - even if it is low, it will still mean
# a lot of positive cases are missed. This is one reason we
# test 3 times in MIQ.
