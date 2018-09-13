

data_journal <- read.csv('data_journal.csv', stringsAsFactors = FALSE, header = TRUE)
vector_twitter <- data_journal$TWITTER.ACCOUNT
vector_twitter <- na.omit((vector_twitter))

# GATHERING RAW DATA TWITTER

list_twitter_data <- list()

for (i in 1:length(vector_twitter)) {
  
  data <- get_timeline(user = vector_twitter[i], n = 3200)
  data <- clean_data(data)
  assign(paste0('data', '_', vector_twitter[i]), data)
  list_twitter_data <- append(list_twitter_data, paste0('data', '_', vector_twitter[i]))
}



