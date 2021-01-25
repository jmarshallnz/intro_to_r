# Our first R script

# Lines starting with a # are comments. You can write anything you like there and
# it will be ignored when 'run' in R/RStudio. These are useful for adding notes
# to yourself for later.

# This first command loads up the `tidyverse` library/package which includes
# `ggplot2` for creating pretty charts.
library(tidyverse)

# Now we'll load some data on earthquakes from around Fiji
data(quakes)

# Double clicking on the quakes dataset in the Environment pane allows us
# to see the data.

# Let's plot where the earthquakes are
ggplot(data=quakes) +
  geom_point(mapping=aes(x=long, y=lat))

# You can add more code or comments below here.

ggplot(data=quakes)
# This gives a blank plot. And assigns the quakes dataset to the plot.

aes(x=long, y=lat)

# The aes bit defines a mapping from the features of the plot (`x` and `y`) to
# features (or columns) of the data (x -> long, y -> lat)
ggplot(data=quakes) +
  geom_point(mapping=aes(x=long, y=lat))
# The whole lot follows a Recipe:
# 1. Ask for a plot with `ggplot()`
# 2. Tell it what data we want, `data = quakes`
# 3. Tell it what type of chart we want. In this case points, `geom_point()`
# 4. Tell it how to get the details for each point. i.e. how to map each feature
#     of the plot to features of the data. `mapping = aes(x=long, y=lat)`

ggplot(data=quakes) +
  geom_point(mapping=aes(x=long, y=lat), colour='maroon', size=2)

# this is colouring each point maroon and changing the size to a bit larger.

ggplot(data=quakes) +
  geom_point(mapping=aes(x=long, y=lat), colour='maroon', size=2,
             alpha = 0.5, shape="triangle square")

# We can set other aesthetics such as transparency with alpha, and shape.

# to find out about different shapes etc, the vignette on aesthetic specification is useful:
vignette("ggplot2-specs")

# to find all the colours:
colors()

# to find the different shape names I copied this from the vignette.
shape_names <- c(
  "circle", paste("circle", c("open", "filled", "cross", "plus", "small")), "bullet",
  "square", paste("square", c("open", "filled", "cross", "plus", "triangle")),
  "diamond", paste("diamond", c("open", "filled", "plus")),
  "triangle", paste("triangle", c("open", "filled", "square")),
  paste("triangle down", c("open", "filled")),
  "plus", "cross", "asterisk"
)
shape_names

# let's try having the colour change with data by mapping colour to the magnitude
# inside the `aes()`
ggplot(data=quakes) +
  geom_point(mapping=aes(x=long, y=lat, colour=mag), size=2,
             alpha = 0.5)

# We notice that the map coloured by station looks really similar to that of magnitude.
# This makes sense, as larger earthquakes are more likely to be detected by more
# stations.
ggplot(data=quakes) +
  geom_point(mapping=aes(x=long, y=lat, colour=stations), size=2,
             alpha = 0.5)
