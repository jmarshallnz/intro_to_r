# Tidying data

library(tidyverse)

# read in the data
cycle_counts <- read_csv("data/cycle_counts/he_ara_kotahi.csv")

# convert to long format, so that Direction and Count are columns
long_cycles = cycle_counts %>%
  pivot_longer(c(`From City`, `To City`),
               names_to = "Direction",
               values_to = "Count")

# summarise the mean count by hour for each direction
long_cycles %>%
  group_by(Hour, Direction) %>%
  summarise(Mean = mean(Count))

# and plot the hourly counts for each direction
long_cycles %>%
  group_by(Hour, Direction) %>%
  summarise(Mean = mean(Count)) %>%
  ggplot() +
  geom_col(
    mapping = aes(x = Hour,
                  y = Mean,
                  fill = Direction),
    position = 'dodge'
  )

# Try a line chart?
long_cycles %>%
  group_by(Hour, Direction) %>%
  summarise(Mean = mean(Count)) %>%
  ggplot() +
  geom_line(
    mapping = aes(x = Hour,
                  y = Mean,
                  colour = Direction)
  )

# Try pivoting the summarised cycle count data back into wide format to give a table.
# save the summarised counts
summarised_counts = long_cycles %>%
  group_by(Hour, Direction) %>%
  summarise(Mean = mean(Count))

# pivot wider into a table
summarised_counts %>%
  pivot_wider(names_from = Direction,
              values_from = Mean) %>%
  View()

# Let's round the values first!
summarised_counts %>%
  mutate(Mean = round(Mean)) %>% ##< Rounding first means we don't have to round the two columns separately
  pivot_wider(names_from = Direction,
              values_from = Mean) %>%
  View()
