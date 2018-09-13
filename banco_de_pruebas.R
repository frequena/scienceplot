twitter_accounts <- setNames(list_twitter_data, vector_twitter)
twitter_accounts_dtm <- setNames(list_twitter_data_dtm, vector_twitter)

journal_accounts_title_dtm <- setNames(list_journal_data_title, vector_articles_names)
journal_accounts_abstract_dtm <- setNames(list_journal_data_abstract, vector_articles_names)
journal_accounts_key_dtm <- setNames(list_journal_data_key, vector_articles_names)

tdm_remove <- removeSparseTerms(data_articles_bioinformatics_abstract_dtm, sparse = 0.99)
tdm_remove_matrix <-  as.matrix(tdm_remove)
dist_matrix <- dist(scale(tdm_remove_matrix), 'euclidean')
cluster <- try(hclust(dist_matrix, method = 'complete'))

plot_cluster <-plot(cluster, cex = 0.6)

rect.hclust(plot_cluster)

#############################

prueba <- articles_bioinformatics
prueba$Title <- as.character(prueba$Title)
prueba2 <- prueba %>%
  unnest_tokens(word, Title) %>%
  pairwise_count(word, Abstract, sort = T, upper = F)

prueba2 %>%
  filter(n >= 200) %>%
  graph_from_data_frame() %>%
  ggraph(layout = "fr") +
  geom_edge_link(aes(edge_alpha = n, edge_width = n)) +
  geom_node_point(color = "darkslategray4", size = 5) +
  geom_node_text(aes(label = name), repel = TRUE) +
  ggtitle("Word Network in NASA Dataset Titles") +
  theme_void()

#####################


twitter_accounts_dtm

name_data <- gsub('_title_dtm', '', 'data_articles_nature_title_dtm')
name_data <- gsub('data_', '', name_data)
data <- get(name_data)

data_plot <- data %>%
  mutate(Title = as.character(Title)) %>%
 unnest_tokens(word, Abstract) %>%
  anti_join(stop_words) %>%
  pairwise_count(word, Title, sort = T, upper = F)













