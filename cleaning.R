

clean_data <- function(x) {
  
  stopifnot(is.data.frame(x))
  
  colnames(x)[1] <- 'date'
  x$date <- as.Date(x$date)
  x <- x %>%
    select(date, text) %>%
    filter(date >= as.Date('2016-01-01'))
  
  x$text <- tolower(x$text) ## Remove uppercase letters
  
  x$date <- sub(" .*", "", x$date) ## Eliminate time
  
  x$text <- gsub('amp', '', x$text) ## Remove amp
  
  x$text <- gsub('http\\S+\\s*', '', x$text) ## Remove URLs
  
  x$text <- gsub('\\b+RT', '', x$text) ## Remove RT
  
  x$text <- gsub('#\\S+', '', x$text) ## Remove Hashtags
  
  x$text <- gsub('@\\S+', '', x$text) ## Remove Mentions
  
  x$text <- gsub('[[:cntrl:]]', '', x$text) ## Remove Controls and special characters
  
  x$text <- gsub("\\d", '', x$text) ## Remove Controls and special characters
  
  x$text <- gsub('[[:punct:]]', '', x$text) ## Remove Punctuations
  
  x$text <- gsub("^[[:space:]]*","",x$text) ## Remove leading whitespaces
  
  x$text <- gsub("[[:space:]]*$","",x$text) ## Remove trailing whitespaces
  
  x$text <- gsub(' +',' ',x$text) ## Remove extra whitespaces
  
  return(x)
}
