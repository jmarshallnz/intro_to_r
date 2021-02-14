# Combining plots with patchwork
library(tidyverse)
library(patchwork)
library(palmerpenguins)

# some plots:

# Note we're assigning these plots to a variable, so they won't be printed (i.e.
# the plots won't come up)

g0 = ggplot(penguins) + geom_density(aes(x=flipper_length_mm, fill=species), alpha=0.5)

g1 = ggplot(penguins) +
  geom_density(
    aes(x=body_mass_g,
        fill=species),
    alpha=0.5)

g2 = ggplot(penguins) +
  geom_point(
    aes(x=bill_length_mm,
        y=bill_depth_mm,
        col=species),
    alpha=0.5)

# look at them just by printing them out:
g0
g1
g2

# combine with patchwork
(g0 / g1 | g2) + plot_layout(guides = 'collect') +
  plot_annotation(title = "Gentoo penguins are chonky and have long, narrow beaks")
