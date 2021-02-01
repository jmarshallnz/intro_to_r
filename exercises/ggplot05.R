# Small multiple plots of Penguin data
library(tidyverse)
library(palmerpenguins)

ggplot(penguins) + 
  geom_density(aes(x=body_mass_g),
               fill='light blue')
