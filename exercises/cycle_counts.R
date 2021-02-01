# Reproducing a graph

library(tidyverse)
library(lubridate) # for dates

# read in the data
cycle_counts = read_csv("data/cycle_counts/he_ara_kotahi.csv")

# Your first step should be to get the data in the form for plotting, where you have mean counts
# per hour per weekday per direction per lockdown period.

# Your goal is to add to the pipe below to get the data in the right form.

# 1. Extract weekday from date. Look up the help for `wday` to get non-abbreviated labels
# 2. Pivot to get Direction and Count columns.
# 3. Join to the lockdown data.
# 4. Summarise counts by Day, Lockdown period, Hour, and Direction.

final_data = cycle_counts %>% mutate(WeekDay = wday(Date))

# You can check you've got it right by comparing to this:
goal_data = read_csv("data/cycle_counts/cycle_counts_plot.csv")

# Once you have your final data, do the plot. Some hints:
# - The variable on the x-axis should be `Hour`.
# - The lines use `size=1`.
# - The colours used are `#984ea3` and `#1f78b4`.
