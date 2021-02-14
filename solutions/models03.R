# Modelling Titanic survival in R

# Load our libraries
library(tidyverse)
library(broom)

# read in the data
titanic = read_csv("data/titanic/titanic.csv") %>%
  mutate(Survived = as_factor(Survived)) # outcome needs to be a factor for `glm`

# combine sex and age
titanic_comb <- titanic %>% unite(SexAge, Sex, Age, sep=" ") %>%
  mutate(SexAge = fct_relevel(SexAge, "Male Adult"))

# fit model
titanicmod3 <- glm(Survived ~ Class + SexAge, family=binomial, data=titanic_comb)

# extract model fit for the sex/age terms
titanicmod3 %>% tidy() %>%
  filter(str_detect(term, "SexAge"))

# prepare for visualising
plot_me <- 
  titanicmod3 %>% tidy() %>%
  filter(str_detect(term, "SexAge")) %>%
  tidyr::extract(term, into=c("Sex", "Age"), regex="SexAge(.*) (.*)") %>%
  mutate(OR = exp(estimate),
         low_ci = exp(estimate - 2*std.error),
         high_ci = exp(estimate + 2*std.error)) %>%
  select(Sex, Age, OR, low_ci, high_ci)
plot_me

# do a plot of odds ratios
ggplot(plot_me) +
  geom_pointrange(
    mapping=aes(
      x=Sex,
      col=Age,
      y=OR,
      ymin=low_ci,
      ymax=high_ci
    )
  ) +
  scale_y_log10()

# try position='dodge'
ggplot(plot_me) +
  geom_pointrange(
    mapping=aes(
      x=Sex,
      col=Age,
      y=OR,
      ymin=low_ci,
      ymax=high_ci
    ),
    position='dodge'
  ) +
  scale_y_log10()

# NOTE the warning message suggests we need to use position_dodge() instead:
ggplot(plot_me) +
  geom_pointrange(
    mapping=aes(
      x=Sex,
      col=Age,
      y=OR,
      ymin=low_ci,
      ymax=high_ci
    ),
    position=position_dodge(width=1)
  ) +
  scale_y_log10()

# we could add a new row with Male Adults as the comparison group:
male_adult = tibble(Age = "Adult", Sex = "Male", OR = 1, low_ci = 1, high_ci = 1)
plot_me2 = bind_rows(plot_me, male_adult)
plot_me2
ggplot(plot_me2) +
  geom_pointrange(
    mapping=aes(
      x=Sex,
      col=Age,
      y=OR,
      ymin=low_ci,
      ymax=high_ci
    ),
    position=position_dodge(width=1)
  ) +
  scale_y_log10()
# This shows that if you're a female, you're all good. if you're a male, then being a child helps a bunch!
