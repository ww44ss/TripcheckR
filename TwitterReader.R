## Rscript for reading twitter logs, cleaning them, adn storing the results as a .csv
## Currently just a straight forward data pull of data.

## You will need to provide your own keys

library(twitteR)
library(ROAuth)

## create URLs
reqURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"
consumerKey <- "Ys4tfBmMdPcZT1zCvvInGyQ8a"
consumerSecret <- "t5k5I8kwqDkOiDtYVKgjGbBgZc8FVleGvubezLhD1aVVS0rp4s"

twitCred <- OAuthFactory$new(consumerKey=consumerKey,
                             consumerSecret=consumerSecret,
                             requestURL=reqURL,
                             accessURL=accessURL,
                             authURL=authURL)

twitCred$handshake()

readline()
##Program will pause for input

registerTwitterOAuth(twitCred)

##Should return TRUE is authenticated

## Get the relevant tweet data

name <- "TripCheckUS20B"

user <- getUser(paste0("@", name))

##get the data
## n is an adjustable variable
## user_data is a generic filename

user_data<-userTimeline(user, n=3000, maxID=NULL, sinceID=NULL, includeRts=FALSE)


##convert data to dataframe

clean_data<-do.call(rbind,lapply(user_data,as.data.frame))

##convert times to R format
#clean_data$created<-as.Date(clean_data$created)

write.csv(clean_data, paste0(name,"_NN",".csv"))

##display a bunch of stuff
print(paste0(name,"_NN",".csv"))
dim(clean_data)
head(clean_data)


