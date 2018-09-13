library(igraph)
library(ggraph)
library(widyr)
devtools::install_github('thomasp85/ggraph')
devtools::install_github('thomasp85/ggforce')
devtools::install_github('dgrtwo/widyr')
prueba <- articles_PLOSCompBiol
prueba$Index.Keywords <- as.character(prueba$Index.Keywords)
prueba2 <- prueba %>%
  unnest_tokens(word, Index.Keywords) %>%
  # anti_join(stop_words) %>%
  pairwise_count(word, Abstract, sort = T, upper = F)

prueba2 %>%
  filter(n >= 5) %>%
  graph_from_data_frame() %>%
  ggraph(layout = 'dendrogram') +
  geom_edge_link(aes(edge_alpha = n, edge_width = n)) +
  geom_node_point(color = "darkslategray4", size = 5) +
  geom_node_text(aes(label = name), repel = TRUE) +
  ggtitle("Word Network in NASA Dataset Titles") +
  theme_void()
