# Small multiple plots of Penguin data
library(tidyverse)
library(palmerpenguins)

data(penguins)
penguins

# Try facetting by species to compare bodymass across species
ggplot(penguins) + 
  geom_density(aes(x=body_mass_g),
               fill='light blue') +
  facet_wrap(vars(species))

# Having them stack vertically might be better. we can use ncol or nrow to
# specify column number or row number:
ggplot(penguins) + 
  geom_density(aes(x=body_mass_g),
               fill='light blue') +
  facet_wrap(vars(species), ncol=1)

# What about sex? First, we notice we have an "NA" group..
ggplot(penguins) + 
  geom_density(aes(x=body_mass_g),
               fill='light blue') +
  facet_wrap(vars(sex), ncol=1)

# We could filter this out!
penguins %>%
  filter(!is.na(sex)) %>%
  ggplot() +
  geom_density(aes(x=body_mass_g),
               fill='light blue') +
  facet_wrap(vars(sex), ncol=1)

# The double peak is probably due to species, so let's show
# that as well!
penguins %>%
  filter(!is.na(sex)) %>%
  ggplot() +
  geom_density(aes(x=body_mass_g),
               fill='light blue') +
  facet_wrap(vars(sex, species), ncol=3)

# The other way is to use a grid of small plots
penguins %>%
  filter(!is.na(sex)) %>%
  ggplot() +
  geom_density(aes(x=body_mass_g),
               fill='light blue') +
  facet_grid(rows = vars(sex), 
             cols = vars(species))

# Switching the roles of the rows and columns makes it
# easier to compare species within sex:
penguins %>%
  filter(!is.na(sex)) %>%
  ggplot() +
  geom_density(aes(x=body_mass_g),
               fill='light blue') +
  facet_grid(rows = vars(species), 
             cols = vars(sex))

# How about we colour by sex?
penguins %>%
  filter(!is.na(sex)) %>%
  ggplot() +
  geom_density(aes(x=body_mass_g,
                   fill=sex),
               alpha=0.5) +
  facet_wrap(vars(species), ncol=1)

# How about we colour by sex?
penguins %>%
  filter(!is.na(sex)) %>%
  ggplot() +
  geom_density(aes(x=body_mass_g,
                   fill=species),
               alpha=0.5) +
  facet_wrap(vars(sex), ncol=1)
