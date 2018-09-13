


' ANALYSE OF SPANISH MASS MEDIA WITH TWEETS '

# Load of libraries to extract tweets

install.packages("twitteR")
install.packages("ROAuth")
library("twitteR")
library("ROAuth")

# ID - TOKEN

download.file(url="http://curl.haxx.se/ca/cacert.pem",destfile="cacert.pem")


#create an object "cred" that will save the authenticated object that we can use for later sessions
cred <- OAuthFactory$new(consumerKey='Ztxt61kNQYYoL1hONLD5qRf78',
                         consumerSecret='ZxFWtZB0ODTfNbjJd8bdtSiraImVToQEnHtu0LNDNbHLYuH8VL',
                         requestURL='https://api.twitter.com/oauth/request_token',
                         accessURL='https://api.twitter.com/oauth/access_token',
                         authURL='https://api.twitter.com/oauth/authorize')

# Executing the next step generates an output -->
#To enable the connection, please direct your web browser to: <hyperlink> . Note:  You only need to do this part once
cred$handshake(cainfo="cacert.pem")
