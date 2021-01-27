# Our second script

library(tidyverse)
library(palmerpenguins)

# Let's do a plot!
ggplot(data = penguins) +
  geom_point(
    mapping = aes(
      x = flipper_length_mm,
      y = body_mass_g,
      shape = 'square'
    )
  )
