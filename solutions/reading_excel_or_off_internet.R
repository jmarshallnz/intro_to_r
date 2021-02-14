# Reading from Excel, or reading off the internet
library(tidyverse)
library(readxl)

# Try reading an excel sheet
covid19 = read_excel("data/covid19/covid-cases-30july20.xlsx")
covid19
# You'll notice there is some junk at the top.

# We need to skip the first 3 lines in the sheet before reading
covid19 = read_excel("data/covid19/covid-cases-30july20.xlsx",
                     skip=3)
covid19
# That looks better!

# Try reading off the inteenet:
donkeys <- read_csv("https://www.massey.ac.nz/~jcmarsha/227215/data/donkey.csv")
