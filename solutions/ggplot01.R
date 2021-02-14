# Our first R script

# Lines starting with a # are comments. You can write anything you like there and
# it will be ignored when 'run' in R/RStudio. These are useful for adding notes
# to yourself for later.

# These first commands loads up the `tidyverse` library/package which includes
# `ggplot2` for creating pretty charts, and the `palmerpenguins` data package
library(tidyverse)
library(palmerpenguins)

# load the data up so we can have a look at it:
data(penguins)
penguins

# the "View" command is useful for this:
View(penguins)

# Let's do a plot!
ggplot(data = penguins) +
  geom_point(
    mapping = aes(
      x = flipper_length_mm,
      y = body_mass_g
    )
  )

# Colour by species: We add a new mapping from the 'colour' aesthetic to the column
# we want to colour by. Remember to separate each parameter in the aes() function
# with a comma
ggplot(data = penguins) +
  geom_point(
    mapping = aes(
      x = flipper_length_mm,
      y = body_mass_g,
      colour = species
    )
  )

# We can colour by other things as well. e.g. if we colour by a numeric variable
# it will give us a continuous scale instead of a discrete one. (We'll learn how
# to change colours later!)
ggplot(data = penguins) +
  geom_point(
    mapping = aes(
      x = flipper_length_mm,
      y = body_mass_g,
      colour = bill_depth_mm
    )
  )

# Let's break down how the recipe works:
# ggplot() creates a blank plot, and associates the penguins data with it
ggplot(data = penguins)

# the aes() piece sets up the mapping we're going to use:
# notice we have an *assignment* here - i.e. we're taking the output from the aes() function
# and storing it in the variable 'mapping'. When you run this piece, it'll create a new 'mapping'
# variable in your Environment (top right)
mapping = aes(
  x = flipper_length_mm,
  y = body_mass_g,
  colour = bill_depth_mm
)
# to see the contents of the variable 'mapping' you can just type it's name:
mapping

# The `geom_point` bit then adds a geometric layer, essentially doing the plot
ggplot(data = penguins) +
  geom_point(
    mapping = aes(
      x = flipper_length_mm,
      y = body_mass_g,
      colour = bill_depth_mm
    )
  )

#