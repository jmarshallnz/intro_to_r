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
