# Modelling Donkey bodyweights in R

# Load our libraries
library(tidyverse)

# read in the data
donkeys <- read_csv("data/donkeys/donkeys.csv")

# fit a model
model1 <- lm(Bodywt ~ Heartgirth + Umbgirth + Length + Height, data=donkeys)

# assess it
summary(model1)

# Try dropping Height from the model, as it wasn't really important after
# the other stuff was in there.
model2 <- lm(Bodywt ~ Heartgirth + Umbgirth + Length, data=donkeys)
summary(model2)
# What changes is the multiple R^2 drops a tiny little bit, suggesting
# that model2 is pretty much the same as model1 at explaining the variation
# in body weight (so Height isn't important). Also, coefficients changed
# because everything is related to everything else.


# Try adding sex
model3 <- lm(Bodywt ~ Heartgirth + Umbgirth + Length + Sex, data=donkeys)
summary(model3)

# Tidying up the output and getting confidence intervals:
library(broom)

# The tidy function gives the coefficients, standard errors
# etc as a data frame we can use with dplyr, ggplot etc.
tidy(model3)

# So we can use it to compute other things:
tidy(model3) %>%
  mutate(
    low_ci = estimate - 2*std.error,
    high_ci = estimate + 2*std.error
  )

# And can then do plots too:
tidy(model3) %>%
  mutate(
    low_ci = estimate - 2*std.error,
    high_ci = estimate + 2*std.error
  ) %>%
  filter(term != "(Intercept)") %>%
  ggplot() +
  geom_pointrange(mapping = aes(
    x = term,
    y = estimate,
    ymin = low_ci,
    ymax = high_ci
    )
  )

# diagnostic plot for model3:
plot(model3)

# visualising a simple model:
hgmod = lm(Bodywt ~ Heartgirth, data=donkeys)
summary(hgmod)

# Plotting models
ggplot(donkeys,
       mapping = aes(
         x=Heartgirth,
         y=Bodywt
         )
       ) +
  geom_point() +
  geom_smooth(method = 'gam') +
  annotate("text", x=80,y=200, label="Hello!")

# Plotting a straight line model
ggplot(donkeys,
       mapping = aes(
         x=Heartgirth,
         y=Bodywt
       )
  ) +
  geom_point() +
  geom_smooth(method = 'lm')
