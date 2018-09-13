

shinyServer(function(input, output) {
  
  
  
  output$ui_selection <- renderUI({
    if (input$select_data != 4) {
  
      box(width = NULL, solidHeader = TRUE,
          tabsetPanel(type = "tabs", 
                      tabPanel("Find associations",  dataTableOutput("assoc_term"))))
                      
                      
      
    } else {
      
      box(width = NULL, solidHeader = TRUE,
          tabsetPanel(type = "tabs", 
                      tabPanel("Find associations",  dataTableOutput("assoc_term")),
                      tabPanel("Tweets by month",  plotOutput("tweet_month")),
                      tabPanel("Tweets by day",  plotOutput("tweet_day"))))
    }
    })
  
  selected_dtm <- reactive({
    
    if (input$select_data == 1) { 
      
      name_id <- input$select_data_title
      
    } else if (input$select_data == 2) { 
      
      name_id <- input$select_data_abstract
      
    } else if (input$select_data == 3) { 
      
      name_id <- input$select_data_key
      
    } else { 
      
      name_id <- input$select_data_tweet
    } 
    
    return(name_id)
    
  })
  
  selected_net <- reactive({
    
    if (input$selectnet == 1) { 
      
      name_id2 <- input$select_data_title_net
      
    } else if (input$selectnet == 2) { 
      
      name_id2 <- input$select_data_tweet_net

    }
    return(name_id2)
    
  })
  
  freq_words <- reactive({
    req(input$tab == 'data')
    m = as.matrix(get(selected_dtm())) #we define dtm as matrix
    
    word_freqs = sort(rowSums(m), decreasing=TRUE) #now we get the word orders in decreasing order
    
    dm = data.frame(word=names(word_freqs), freq=word_freqs) #we create our data set
    
    wc <- wordcloud(dm$word, dm$freq, random.order=FALSE, colors=brewer.pal(6, "Dark2"),
                    min.freq = input$freq, scale=c(5, .8), max.words = input$max)
    plot_freq <- ggplot(dm[1:40,], aes(x = reorder(word, -freq), y = freq, fill = freq)) + 
      geom_bar(stat = 'identity') +  
      xlab('Terms') +  
      theme_bw() +
      ylab('Count') + 
      theme(legend.position="none", axis.text.x = element_text(angle = 90, hjust = 1, size = 12),
            axis.title.x = element_text(size = 15), axis.title.y = element_text(size = 15)) +
      scale_color_gradient(low = "aquamarine4", high = "midnightblue")
    
    result <- list('A' = wc, 'B' = plot_freq)
    
    return(result)
    
  })
  
  output$word_cloud <- renderPlot({
    
    
    freq_words()[[1]]
    
  }) 
  
  output$word_freq <- renderPlot({
    
    
    freq_words()[[2]]
    
  })
  
  
  output$assoc_term <- renderDataTable({
    
    result <- as.data.frame(findAssocs(get(selected_dtm()), input$term_used, input$correlation_number))
    return(result)
    
  })
  

  
  output$cluster <- renderPlot({
    req(input$tab == 'data')
    tdm_remove <- removeSparseTerms(get(selected_dtm()), sparse = input$sparse)
    tdm_remove_matrix <-  as.matrix(tdm_remove)
    dist_matrix <- dist(scale(tdm_remove_matrix))
    cluster <- try(hclust(dist_matrix, method = 'ward.D2'))
    validate(
      need(class(cluster) != "try-error", "No terms available. Please, increase the minimum frequency option.")
    )
    plot_cluster <-plot(cluster, cex = 1)

    if ( input$draw_rect == 1 ) {
    result <- try(rect.hclust(cluster, input$n_cluster, border = 2:11))
    validate(
      need(class(result) != "try-error", "Not terms enough available. Please, reduce the number of clusters option.")
    )
    
    } else {
      result <- plot_cluster
    }
    return(result)
    
  })
  
  # NETWORK OF TERMS
  
  output$net_word <- renderPlot({
    req(input$tab == 'net')
    
    
    if (input$selectnet == 1) { 
      
      name_data <- gsub('_title_dtm', '', selected_net())
      name_data <- gsub('data_', '', name_data)
      data <- get(name_data)
      
      data_plot <- data %>%
        mutate(Title = as.character(Title)) %>%
        unnest_tokens(word, Title) %>%
        anti_join(stop_words) %>%
        pairwise_count(word, Abstract, sort = T, upper = F)
      
    # } else if (input$select_data_net == 2) { 
    #   
    #   name_data <- gsub('_abstract_dtm', '', selected_dtm())
    #   name_data <- gsub('data_', '', name_data)
    #   data <- get(name_data)
    #   
    #   data_plot <- data %>%
    #     mutate(Title = as.character(Title)) %>%
    #     unnest_tokens(word, Abstract) %>%
    #     anti_join(stop_words) %>%
    #     pairwise_count(word, Title, sort = T, upper = F)
    #   
    # } else if (input$select_data_net == 3) { 
    #   
    #   name_data <- gsub('_key_dtm', '', selected_dtm())
    #   name_data <- gsub('data_', '', name_data)
    #   data <- get(name_data)
    #   
    #   data_plot <- data %>%
    #     mutate(Title = as.character(Title),
    #            Index.Keywords = as.character(Index.Keywords)) %>%
    #     unnest_tokens(word, Index.Keywords) %>%
    #     anti_join(stop_words) %>%
    #     pairwise_count(word, Title, sort = T, upper = F)
      
    } else if  (input$selectnet == 2) { 
      name_data <- gsub('_dtm', '', selected_net())
      data <- get(name_data)
      data_plot <- data %>%
        unnest_tokens(word, text) %>%
        anti_join(stop_words) %>%
        pairwise_count(word, date, sort = T, upper = F)
    } 

    
    plot <- try(data_plot %>%
      filter(n >= input$n_occ) %>%
      graph_from_data_frame() %>%
      ggraph(layout = 'fr') +
      geom_edge_link(aes(edge_alpha = n, edge_width = n)) +
      geom_node_point(color = "darkslategray4", size = 5) +
      geom_node_text(aes(label = name), repel = TRUE) +
      labs(colour = "Dose (mg)") +
      theme_void())
    
    validate(
      need(class(plot) != "try-error", "Not terms enough available. Please, reduce the number of occurrences option.")
    )
    return(plot)

  })
  
  # TWITTER
  
  tweet_function <- reactive({
    req(input$select_data == 4)
    tweet_date(get(gsub("_dtm.*","\\1", input$select_data_tweet)))
    
  })  
  
  output$tweet_month <- renderPlot({
    
    tweet_function()[[2]]
    
  })
  
  output$tweet_day <- renderPlot({
    
    tweet_function()[[1]]
    
  })
  
  # DOCUMENTATION SECTION
  
  output$welcome1 <- renderDataTable({
    
    result <- read.csv('data_journal_welcome.csv', stringsAsFactors = FALSE, header = TRUE, check.names = FALSE)[,2:3]
    return(result)
    
  })
  
  
  output$welcome2 <- renderDataTable({
    
    result <- read.csv('data_journal_welcome2.csv', stringsAsFactors = FALSE, header = TRUE, check.names = FALSE)
    colnames(result)[1] <- "NUMBER OF CATEGORIES"
    result[,1] <- paste('CATEGORY', seq(1:11))
    return(result)
    
  })
  
  output$narticles <- renderValueBox({
    
    
    valueBox(
      value = 12482,
      subtitle = "Number of articles analyzed",
      icon = icon("bar-chart"),
      color = "yellow"
    )
  })
  
  output$ntweets <- renderValueBox({
   
    
    valueBox(
      value = 26089,
      subtitle = "Number of tweets analyzed",
      icon = icon("twitter"),
      color = "aqua"
    )
  })
  
  output$npapers <- renderValueBox({
    
    
    valueBox(
      value = 31,
      subtitle = "Number of journals analyzed",
      icon = icon("rocket"),
      color = "green"
    )
  })
  
  
  
    
  })

  
  
  
  
  
  

