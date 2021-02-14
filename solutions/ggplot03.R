# Horizons Regional Council E.coli counts
library(tidyverse)

# read in the data
hrc = read_csv("data/horizons_river_quality/horizons_river_ecoli.csv")

# subset to just sites 1 through 5 (don't worry about this code - we'll explain later!)
hrc_sub = filter(hrc, SiteID < "00006")

# And plot
ggplot(data = hrc_sub) +
  geom_boxplot(
    mapping = aes(
      x = SiteID,
      y = Value
    )
  ) +
  scale_y_log10()

# to change the breaks and formatting of labels on the axis:
ggplot(data = hrc_sub) +
  geom_boxplot(
    mapping = aes(
      x = SiteID,
      y = Value
    )
  ) +
  scale_y_log10(breaks=c(1,100,10000),
                labels = c("1", "100", "10 000"))

# trying out a violin plot
ggplot(data = hrc_sub) +
  geom_violin(
    mapping = aes(
      x = SiteID,
      y = Value
    )
  ) +
  scale_y_log10()

# Trying to change colours of the boxplots
# We need to map the colour aesthetic so that
# scale_colour_*() has something to change!
# Note the colour brewer palettes can be found
# by looking in the help for scale_colour_brewer:
?scale_colour_brewer

ggplot(data = hrc_sub) +
  geom_boxplot(
    mapping = aes(
      x = Value,
      y = Site,
      colour = Site
    )
  ) +
  scale_x_log10(breaks=c(1,100,10000),
                labels = c("1", "100", "10 000")) +
  scale_colour_brewer(
    palette = "BrBG"
  ) +
  labs(x = "E. coli count (per 100mL)")

# What if we want to turn off the colour scale
# (which isn't useful, as we have the y axis anyway)
# add: guides(colour = 'none')
ggplot(data = hrc_sub) +
  geom_boxplot(
    mapping = aes(
      x = Value,
      y = Site,
      colour = Site
    )
  ) +
  scale_x_log10(breaks=c(1,100,10000),
                labels = c("1", "100", "10 000")) +
  scale_colour_brewer(
    palette = "BrBG",
    guide = "none"
  ) +
  labs(x = "E. coli count (per 100mL)")

# What about filling the inside of the boxplots
# instead of colouring the outside?
# switch from 'colour' to 'fill'
ggplot(data = hrc_sub) +
  geom_boxplot(
    mapping = aes(
      x = Value,
      y = Site,
      fill = Site
    )
  ) +
  scale_x_log10(breaks=c(1,100,10000),
                labels = c("1", "100", "10 000")) +
  scale_fill_brewer(
    palette = "BrBG",
    guide = "none"
  ) +
  labs(x = "E. coli count (per 100mL)")

# Using manual colours:
ggplot(data = hrc_sub) +
  geom_boxplot(
    mapping = aes(
      x = Value,
      y = Site,
      fill = Site
    )
  ) +
  scale_x_log10(breaks=c(1,100,10000),
                labels = c("1", "100", "10 000")) +
  scale_fill_manual(
    values = c("red", "green", "maroon", "yellow", "pink")
  ) +
  labs(x = "E. coli count (per 100mL)")

# Another option is a density plot with some transparency,
# though it gets a bit busy!
ggplot(data = hrc_sub) +
  geom_density(
    mapping = aes(
      x = Value,
      fill = SiteID
    ),
    alpha=0.3
  ) +
  scale_x_log10()

