# Twitter sentiment analysis. Originally by Kate Newton of RNZ, modified for Intro to R course
#
# We're reproducing the story here:
#
# https://www.rnz.co.nz/news/national/421955/bad-vibes-rating-political-scandals-by-twitter-toxicity

# load in packages
library(tidyverse)
library(tidytext)  # for text sentiment analysis
library(lubridate) # for dates

# read in the tweets (grabbed from the twitter API using `rtweet` package)
nzpol_tweets <- read_csv("data/nzpol_sentiment/nzpol_tweets.csv")

# pull out the columns we want
nzpol_tweets <- nzpol_tweets %>% 
  select(user_id, status_id, created_at, 
         screen_name, text, source, is_quote, 
         is_retweet, hashtags, retweet_text, 
         retweet_screen_name, retweet_user_id, 
         retweet_location, retweet_created_at) %>% 
  arrange(created_at)

# tidy it up by removing 'stop words' (the, a etc)
tidy_tweets <- nzpol_tweets %>% 
  unnest_tokens(word, text) %>% #use tidytext pkg to split each tweet into one row per word
  anti_join(stop_words) %>% # get rid of stopwords aka common words such as 'the, 'a'
  filter(!str_detect(word, "http|https|t\\.co|amp|[:digit:]+")) %>% # and get rid of common web jargon
  mutate(day_of = floor_date(created_at, "day"), 
         hour_of = floor_date(created_at, "hour")) # create columns to categorise by day and hour

# add the sentiment of each word in the tweet.
sentiments <- tidy_tweets %>% 
  inner_join(get_sentiments("afinn")) %>% # using AFINN library (gives words a positivity/negativity rating on a scale of +5 to -5); see tidytext documentation for alternatives
  select(word, day_of, hour_of, value)

# in case that doesn't work...
#sentiments = read_csv("data/nzpol_sentiment/sentiments.csv")

# Lets do the graph. We need to:
# 1. show the sentiment summarised hourly.
# 2. colour the sentiment based on whether it is positive or negative.
