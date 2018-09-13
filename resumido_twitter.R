


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



# TWITTER

vector_twitter <- data_journal$TWITTER.ACCOUNT
vector_twitter <- na.omit((vector_twitter))

list_twitter_data <- list()

for (i in 1:length(vector_twitter)) {
  
  data <- get_timeline(user = vector_twitter[i], n = 3200)
  data <- clean_data(data)
  assign(paste0('data', '_', vector_twitter[i]), data)
  list_twitter_data <- append(list_twitter_data, paste0('data', '_', vector_twitter[i]))
}



list_twitter_data_dtm <- list()

for (i in 1:28) {
  x <- get(paste0('data_',vector_twitter[[i]][1]))$text
  myCorpus = Corpus(VectorSource(x))
  myCorpus = tm_map(myCorpus, content_transformer(tolower))
  myCorpus = tm_map(myCorpus, removePunctuation)
  myCorpus = tm_map(myCorpus, removeNumbers)
  myCorpus = tm_map(myCorpus, removeWords,
                    stopwords("SMART"))
  
  myDTM= TermDocumentMatrix(myCorpus,
                            control = list(minWordLength = 2))
  
  assign(paste0('data', '_', vector_twitter[i], '_dtm'), myDTM)
  list_twitter_data_dtm <- append(list_twitter_data_dtm, paste0('data', '_', vector_twitter[i], '_dtm'))
}

