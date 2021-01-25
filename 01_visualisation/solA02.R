# Our second R script

# Load up the libraries we need and data
library(tidyverse)
data(quakes)

# Let's plot where the earthquakes are again
ggplot(data=quakes) +
  geom_point(mapping=aes(x=long, y=lat))

# Let's change the points to something else. In this case binning the data
# and counting the number of points in each bin.
ggplot(data=quakes) +
  geom_bin2d(mapping=aes(x=long, y=lat))

# Another option might be to use a density estimator and produce contour plots:
ggplot(data=quakes) +
  geom_density2d(mapping=aes(x=long, y=lat))
# The density plot is produced by dropping small blobs of 'jelly' on each point. Where
# points are close, the jelly lands on top of each other a bit, causing a big mountain
# of jelly to occur. Where points are sparse, you get a flatter distribution.
# The contours are used to show this 3D surface on a 2D plot. Where contours are tight
# the number of earthquakes is increasing rapidly. Where they are further apart, the
# number of earthquakes isn't changing much.

# We can combine these two layers if we want:
ggplot(data=quakes) +
  geom_point(mapping=aes(x=long, y=lat), alpha=0.3) +
  geom_density2d(mapping=aes(x=long, y=lat), col='darkorange', linetype='solid',
                 size = 0.5)

# We can change line type, colour etc in the same way as before, by adding the parameters
# to the `geom_density2d` function.

# We can find the different types of line by looking in the ggplot2 specification vignette (
# found from `geom_point()` help).
vignette("ggplot2-specs")

# We can also change the amount that we smooth. When we drop the jelly on each point we
# can choose how large the blob is, and how tall it is. We use `adjust` in `geom_smooth`
# for this.
ggplot(data=quakes) +
  geom_point(mapping=aes(x=long, y=lat), alpha=0.3) +
  geom_density2d(mapping=aes(x=long, y=lat), col='darkorange', linetype='solid',
                 size = 0.5, adjust = 0.5)
# Smaller than 1 for adjust will smooth less, while adjust > 1 will smooth more.
ggplot(data=quakes) +
  geom_point(mapping=aes(x=long, y=lat), alpha=0.3) +
  geom_density2d(mapping=aes(x=long, y=lat), col='darkorange', linetype='solid',
                 size = 0.5, adjust = 2)
# adjust = 0.5 is probably undersmoothed - we're adapting to the specific dataset that
# we have a little too much, so maybe aren't capturing the truth in the general population.

# adjust = 2 is probably oversmoothed - we're losing detail or signal.

ggplot(data=quakes) +
  geom_point(mapping=aes(x=long, y=lat, colour = mag), alpha=0.3) +
  geom_density2d(mapping=aes(x=long, y=lat), col='darkorange', linetype='solid',
                 size = 0.5, adjust = 1) +
  labs(x = "Longitude", y= "Latitude",
       colour = "Magnitude",
       title = "Distribution of earthquakes around Fiji",
       subtitle = "Most quakes are to the south east of Fiji, some are to the west",
       caption = "Data from the `quakes` dataset included with R")

## Improving a plot

ggplot(data=quakes) +
  geom_point(mapping=aes(x=mag, y=stations))

# We note that there's vertical stripes of data on the plot as magnitude is rounded to the
# nearest 0.1. We may have **overplotting** where multiple observations are plotted on top
# of each other exactly, so we can't tell how many points there are.

ggplot(data=quakes) +
  geom_jitter(mapping=aes(x=mag, y=stations))

# This adds 'jitter' or random noise to each of the x,y pairs so they're not directly on top
# of each other. It allows the density of points to be seen more clearly. Ink density.

# we can alter the amount of jitter with `width` and `height`
ggplot(data=quakes) +
  geom_jitter(mapping=aes(x=mag, y=stations), width=0.04)

# Another way to solve overplotting is by using transparency
ggplot(data=quakes) +
  geom_point(mapping=aes(x=mag, y=stations), alpha=0.2)

# or maybe a combination
ggplot(data=quakes) +
  geom_jitter(mapping=aes(x=mag, y=stations), alpha=0.2)

# We could try a smoother to estimate the distribution of points or the relationship
# between stations and magnitude
ggplot(data=quakes) +
  geom_jitter(mapping=aes(x=mag, y=stations), alpha=0.2) +
  geom_density2d(mapping=aes(x=mag, y=stations))

# To get the trend, we can use `geom_smooth()`
ggplot(data=quakes) +
  geom_jitter(mapping=aes(x=mag, y=stations), alpha=0.2) +
  geom_smooth(mapping=aes(x=mag, y=stations))

# By default with 1000 observations or more, it uses a generalised additive model which
# fits a smooth trend using splines. We can specify the method as follows:
ggplot(data=quakes) +
  geom_jitter(mapping=aes(x=mag, y=stations), alpha=0.2) +
  geom_smooth(mapping=aes(x=mag, y=stations), method='loess', span=2)
# span defaults to 0.75, lower values smooth less, higher values smooth more (up to 1?)

# We can also fit a straight line:
ggplot(data=quakes) +
  geom_jitter(mapping=aes(x=mag, y=stations), alpha=0.2) +
  geom_smooth(mapping=aes(x=mag, y=stations), method='lm')
# This is a terrible fit. We're underestimating the number of stations for low magnitude
# quakes.

# To alter the smoothing for the gam:
ggplot(data=quakes) +
  geom_jitter(mapping=aes(x=mag, y=stations), alpha=0.2) +
  geom_smooth(mapping=aes(x=mag, y=stations), method='gam',
              method.args = list(gamma = 3))
# gamma greater than 1 will smooth more. Gamma less than 1 will smooth less:
ggplot(data=quakes) +
  geom_jitter(mapping=aes(x=mag, y=stations), alpha=0.2) +
  geom_smooth(mapping=aes(x=mag, y=stations), method='gam',
              method.args = list(gamma = 0.4))

# The original smooth was I think the best:
ggplot(data=quakes) +
  geom_jitter(mapping=aes(x=mag, y=stations), alpha=0.2) +
  geom_smooth(mapping=aes(x=mag, y=stations), method='gam') +
  labs(x = "Magnitude of earthquake",
       y = "Number of stations that detect the earthquake",
       title = "Larger earthquakes are felt more widely")
# Feel free to editorialise a little with your titles, but not too much.
# We don't want a clickbait headline...
