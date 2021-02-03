# Modelling Titanic survival in R

# Load our libraries
library(tidyverse)

# read in the data
titanic <- read_csv("data/titanic/titanic.csv")

# fit a model
titanicmod1 <- glm(Survived ~ Class + Sex + Age, family=binomial, data=titanic)

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
