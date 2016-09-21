rm( list = ls() )
library(twitteR)
library(httr)
source("twitter_api.R")
oauth_endpoints("twitter")

myapp <- oauth_app("twitter",
                   key = api_key,
                   secret = secret_key
)

# 3. Get OAuth credentials
twitter_token <- oauth1.0_token(oauth_endpoints("twitter"), myapp)

req <- GET("https://api.twitter.com/1.1/statuses/home_timeline.json",
           config(token = twitter_token))
stop_for_status(req)
content(req)

tweets <- searchTwitter('#rstats', n=50)
