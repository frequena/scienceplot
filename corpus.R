
# READ OF DATA

data_journal <- read.csv('data_journal.csv', stringsAsFactors = FALSE, header = TRUE)


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

# SCOPUS

vector_articles <- data_journal$FILE.NAME
vector_articles_names <- data_journal$NAME.OF.JOURNAL

list_journal_data <- list()
for (i in 1:length(vector_articles)) {
  data <- read.csv(paste0('./data/scopus/', vector_articles[i]))
  data <- data %>%
    select(Title, Abstract, Index.Keywords, Source.title)
  data$Abstract <- gsub("©.*","\\1", data$Abstract)
  assign(vector_articles[i], data)
  list_journal_data <- append(list_journal_data, paste0(vector_articles[i]))
}


# TWITTER

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

# JOURNAL TITLE

list_journal_data_title <- list()

for (i in 1:31) {
  x <- get(paste0(vector_articles[[i]][1]))$Title
  myCorpus = Corpus(VectorSource(x))
  myCorpus = tm_map(myCorpus, content_transformer(tolower))
  myCorpus = tm_map(myCorpus, removePunctuation)
  myCorpus = tm_map(myCorpus, removeNumbers)
  myCorpus = tm_map(myCorpus, removeWords,
                    stopwords("SMART"))
  
  myDTM= TermDocumentMatrix(myCorpus,
                            control = list(minWordLength = 2))
  
  assign(paste0('data', '_', vector_articles[i], '_title_dtm'), myDTM)
  list_journal_data_title <- append(list_journal_data_title, paste0('data', '_', vector_articles[i], '_title_dtm'))
}

# JOURNAL ABSTRACT

list_journal_data_abstract <- list()

for (i in 1:31) {
  x <- get(paste0(vector_articles[[i]][1]))$Abstract
  myCorpus = Corpus(VectorSource(x))
  myCorpus = tm_map(myCorpus, content_transformer(tolower))
  myCorpus = tm_map(myCorpus, removePunctuation)
  myCorpus = tm_map(myCorpus, removeNumbers)
  myCorpus = tm_map(myCorpus, removeWords,
                    stopwords("SMART"))
  
  myDTM= TermDocumentMatrix(myCorpus,
                            control = list(minWordLength = 2))
  
  assign(paste0('data', '_', vector_articles[i], '_abstract_dtm'), myDTM)
  list_journal_data_abstract <- append(list_journal_data_abstract, paste0('data', '_', vector_articles[i], '_abstract_dtm'))
}

# JOURNAL KEYWORDS

list_journal_data_key <- list()

for (i in 1:31) {
  x <- get(paste0(vector_articles[[i]][1]))$Index.Keywords
  myCorpus = Corpus(VectorSource(x))
  myCorpus = tm_map(myCorpus, content_transformer(tolower))
  myCorpus = tm_map(myCorpus, removePunctuation)
  myCorpus = tm_map(myCorpus, removeNumbers)
  myCorpus = tm_map(myCorpus, removeWords,
                    stopwords("SMART"))
  
  myDTM= TermDocumentMatrix(myCorpus,
                            control = list(minWordLength = 2))
  
  assign(paste0('data', '_', vector_articles[i], '_key_dtm'), myDTM)
  list_journal_data_key <- append(list_journal_data_key, paste0('data', '_', vector_articles[i], '_key_dtm'))
}

