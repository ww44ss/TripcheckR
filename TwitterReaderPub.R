## Rscript for reading twitter logs, cleaning them, adn storing the results as a .csv
## Currently just a straight forward data pull of data.

## You will need to provide your own keys

require(twitteR)
require(ROAuth)

reqURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"
consumerKey <- "YourKey"
consumerSecret <- "YourSecret"

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

user_data<-userTimeline(user, n=1500, maxID=NULL, sinceID=NULL, includeRts=FALSE)


##convert data to dataframe

clean_data<-do.call(rbind,lapply(user_data,as.data.frame))

##convert times to R format
clean_data$created<-as.Date(clean_data$created)

write.csv(clean_data, paste0(name,".csv"))

##display a bunch of stuff
print(paste0(name,".csv"))
dim(clean_data)
head(clean_data)


