# Horizons Regional Council E.coli counts
library(tidyverse)

# read in the data
hrc = read_csv(here::here("data/horizons_river_quality/horizons_river_ecoli.csv"))

# subset to just sites 1 through 5 (don't worry about this code - we'll explain later!)
hrc_sub = filter(hrc, SiteID < "00006")

# And plot
ggplot(data = hrc_sub) +
  geom_boxplot(
    mapping = aes(
      x = SiteID,
      y = Value
    )
  )
