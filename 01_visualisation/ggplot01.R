# Our first R script

# Lines starting with a # are comments. You can write anything you like there and
# it will be ignored when 'run' in R/RStudio. These are useful for adding notes
# to yourself for later.

# These first commands loads up the `tidyverse` library/package which includes
# `ggplot2` for creating pretty charts, and the `palmerpenguins` data package
library(tidyverse)
library(palmerpenguins)

# Let's do a plot!
ggplot(data = penguins) +
  geom_point(
    mapping = aes(
      x = flipper_length_mm,
      y = body_mass_g,
    )
  )
