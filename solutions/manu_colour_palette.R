
library(tidyverse)
library(palmerpenguins)
library(Manu) # from: https://g-thomson.github.io/Manu/

# install the Manu package using:
# remotes::install_github("G-Thomson/Manu")

my_colours = c(Adelie = "darkgreen",
               Chinstrap = "#7f2b3c",
               Gentoo = "orange")
my_colours

ggplot(data = penguins) +
  geom_point(
    mapping = aes(
      x = flipper_length_mm,
      y = body_mass_g,
      col = species
    )
  ) +
  scale_colour_manual(values = get_pal("Kaka"))
