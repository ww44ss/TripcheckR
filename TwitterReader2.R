
## Updated Twitter readers with new authentication method

## TwitterReader2
## reads in a large number of tweets from a specific user
## and stores the results in a csv file for later analysis

library(twitteR)
require(plyr)
library(methods)

## create URLs
reqURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"

## Keys
## you get these from apps.twitter.com
consumerKey <- "OGbiXRQtI7ttxeG0CQ1BmQ9yd"
consumerSecret <- "7bLLF1wV9ZQJd1o7CMuHakwnNYfOU4XIXBLGYjTmczPvP9X8wE"
accessToken <- "52073060-KCY5uz5g5lhVXUk8tJFWRrzUejk034yfCDceRgk14"
accessTokenSecret <- "pBwWtpMXzhLGJXLHypjPtGE2vZd6cnwHzhGHl4UKC6mRk"

## set up authentication
setup_twitter_oauth(consumerKey, consumerSecret, accessToken, accessTokenSecret)

##name of access
name <- "TripCheckUS20B"
##define user
user <- getUser(paste0("@", name))
## get the data
user_data<-userTimeline(user, n=3000, maxID=NULL, sinceID=NULL, includeRts=FALSE)
##inspect it
head(user_data)
## convert to a data frame
clean_data<-do.call(rbind,lapply(user_data,as.data.frame))
##write the data as a csv
write.csv(clean_data, paste0(name,"_Sep15",".csv"))

