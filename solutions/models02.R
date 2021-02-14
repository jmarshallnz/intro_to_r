# Modelling Titanic survival in R

# Load our libraries
library(tidyverse)
library(broom)

# read in the data
titanic <- read_csv("data/titanic/titanic.csv")

# fix up the Survived variable to be a factor so that glm()
# knows what to do...
titanic2 = titanic %>%
  mutate(Survived = as_factor(Survived))

# fit a model
titanicmod1 <- glm(Survived ~ Class + Sex + Age,
                   family=binomial, data=titanic2)

# assess it
summary(titanicmod1)

# visualise
titanicmod1 %>%
  tidy() %>%
  mutate(
    OR = exp(estimate),
    low_ci = exp(estimate -
                   2*std.error),
    high_ci = exp(estimate +
                    2*std.error)
  ) %>%
  ggplot() +
  geom_pointrange(
    mapping=aes(
      x=OR,
      xmin=low_ci,
      xmax=high_ci,
      y=term
    )
  ) +
  geom_vline(xintercept=1,
             col='blue') +
  scale_x_log10()

# Filter out the intercept term
titanicmod1 %>%
  tidy() %>%
  mutate(
    OR = exp(estimate),
    low_ci = exp(estimate -
                   2*std.error),
    high_ci = exp(estimate +
                    2*std.error)
  ) %>%
  filter(term != "(Intercept)") %>%
  ggplot() +
  geom_pointrange(
    mapping=aes(
      x=OR,
      xmin=low_ci,
      xmax=high_ci,
      y=term
    )
  ) +
  geom_vline(xintercept=1,
             col='blue') +
  scale_x_log10()

# Colour based on risky or protective...
titanicmod1 %>%
  tidy() %>%
  mutate(
    OR = exp(estimate),
    low_ci = exp(estimate -
                   2*std.error),
    high_ci = exp(estimate +
                    2*std.error),
    effect = if_else(OR < 1,
                     "Protective",
                     "Risky")
  ) %>%
  filter(term != "(Intercept)") %>%
  ggplot() +
  geom_pointrange(
    mapping=aes(
      x=OR,
      xmin=low_ci,
      xmax=high_ci,
      y=term,
      col=effect
    )
  ) +
  geom_vline(xintercept=1,
             col='blue') +
  scale_x_log10()

# Second model that includes an interaction:
titanicmod2 <- glm(Survived ~ Class + Sex * Age, family=binomial, data=titanic2)
summary(titanicmod2)

# Grab odds ratios out and do a similar plot as before.
titanicmod2 %>%
  tidy() %>%
  mutate(
    OR = exp(estimate),
    low_ci = exp(estimate -
                   2*std.error),
    high_ci = exp(estimate +
                    2*std.error),
    effect = if_else(OR < 1,
                     "Protective",
                     "Risky")
  ) %>%
  filter(term != "(Intercept)") %>%
  ggplot() +
  geom_pointrange(
    mapping=aes(
      x=OR,
      xmin=low_ci,
      xmax=high_ci,
      y=term,
      col=effect
    )
  ) +
  geom_vline(xintercept=1,
             col='blue') +
  scale_x_log10()

# The sex and age effects are going to be tricky to show, as there is combinations (the AgeChild,
# SexMale and SexMale:AgeChild terms)
