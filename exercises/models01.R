# Modelling Donkey bodyweights in R

# Load our libraries
library(tidyverse)

# read in the data
donkeys <- read_csv("data/donkeys/donkeys.csv")

# fit a model
model1 <- lm(Bodywt ~ Heartgirth + Umbgirth + Length + Height, data=donkeys)

# assess it
summary(model1)
