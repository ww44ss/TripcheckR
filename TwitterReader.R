## Rscript for reading twitter logs, cleaning them, adn storing the results as a .csv
##
##
require(twitteR)
require(ROAuth)

reqURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"
consumerKey <- "7UddBUI2lFO6dIJuOplYuGSr4"
consumerSecret <- "UO50oEmKoIKP6LRBNrcs4LsPVekltKrDWQh6tMn7nQ9t5eB6SI"

twitCred <- OAuthFactory$new(consumerKey=consumerKey,
                             consumerSecret=consumerSecret,
                             requestURL=reqURL,
                             accessURL=accessURL,
                             authURL=authURL)

twitCred$handshake()

##Program will pause for input

registerTwitterOAuth(twitCred)

##Should return TRUE is authenticated

## Get the relevant tweet data

name <- "TripCheckUS20"

user <- getUser(paste0("@", name))

##get the data
## n is an adjustable variable

hwy20Bfull<-userTimeline(user, n=600, maxID=NULL, sinceID=NULL, includeRts=FALSE)

##convert data to dataframe
hwy20_df<-do.call(rbind,lapply(hwy20Bfull,as.data.frame))

##convert times to R format
hwy20_df$created<-as.Date(hwy20_df$created)

write.csv(hwy20_df, paste0(name,".csv"))

