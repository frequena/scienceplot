library(ggplot2)
library(shinydashboard)
library(wordcloud)
library(lubridate)
library(dplyr)
library(ROAuth)
library(stringr)
library(httr)
library(rtweet)
library(plotly)
library(tm)
library(DT)
library(topicmodels)
library(factoextra)
library(tidytext)
library(igraph)
library(ggraph)
library(widyr)

#load('./segunda_prueba.RData')


twitter_accounts <- setNames(list_twitter_data, vector_twitter)
twitter_accounts_dtm <- setNames(list_twitter_data_dtm, vector_twitter)

journal_accounts_title_dtm <- setNames(list_journal_data_title, vector_articles_names)
journal_accounts_abstract_dtm <- setNames(list_journal_data_abstract, vector_articles_names)
journal_accounts_key_dtm <- setNames(list_journal_data_key, vector_articles_names)
journal_accounts_key_dtm[[13]] <- NULL

stop_words <- rbind(stop_words, c('rt', 'SMART'))