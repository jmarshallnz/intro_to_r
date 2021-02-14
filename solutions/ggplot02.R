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

# The mistake here is putting the *setting* of shape inside the mapping/aes()
# section. If we want to set the shape to square, we need it inside the geom_point()
# but outside the aes():
ggplot(data = penguins) +
  geom_point(
    mapping = aes(
      x = flipper_length_mm,
      y = body_mass_g
    ),
    shape = 'square'
  )


# Experiment with a few more. Notice how if there is two aesthetics mapped
# to the same thing, ggplot will combine the guides into one (e.g. the species
# mapping here)
ggplot(data = penguins) +
  geom_point(
    mapping = aes(
      x = flipper_length_mm,
      y = body_mass_g,
      col = species,
      shape = species,
      size = bill_length_mm
    ),
    alpha=0.5
  )

# trying out more than one layer:
ggplot(data = penguins) +
  geom_point(
    mapping = aes(
      x = flipper_length_mm,
      y = body_mass_g
    ),
    shape = 'square'
  ) +
  geom_smooth(
    mapping = aes(
      x = flipper_length_mm,
      y = body_mass_g
    )
  )

# combining aesthetics into the ggplot() part to save a bit of typing:
ggplot(data = penguins,
       mapping = aes(
         x = flipper_length_mm,
         y = body_mass_g
         )
       ) +
  geom_point() +
  geom_smooth()

# trying out some other geometries
ggplot(data = penguins,
       mapping = aes(
         x = flipper_length_mm,
         y = body_mass_g
       )
) +
  geom_point() +
  geom_bin2d(
    mapping = aes(fill = species),
    alpha = 0.2
    )

# Doing some labelling:
ggplot(data = penguins,
       mapping = aes(
         x = flipper_length_mm,
         y = body_mass_g
       )
) +
  geom_point() +
  geom_bin2d(
    mapping = aes(fill = species),
    alpha = 0.2
  ) +
  labs(x = "Flipper length (mm)",
       y = "Body mass (g)",
       title = "Gentoo penguins are chonky",
       subtitle = "They're heavier and have bigger flippers",
       caption = "Data from the palmerpenguins package in R",
       col = "Species",
       fill = "Species")

