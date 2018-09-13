
data_journal <- read.csv('data_journal.csv', stringsAsFactors = FALSE, header = TRUE)
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
