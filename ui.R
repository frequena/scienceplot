library(shinydashboard)
tags$head(tags$link(href="www/favicon.ico"))
header <- dashboardHeader(
  title = "Rsciencexplorer2016 - A Webtool for the exploration of biomedical terms used in 2016",
  titleWidth = 830,
  #Facebook Sharing
  tags$li(class = "dropdown",
          tags$a(href = "http://www.facebook.com/sharer.php?u=https://databiomics.shinyapps.io/rsciencexplorer2016/", 
                 target = "_blank", 
                 tags$img(height = "20px", 
                          src = "fb2.png")
          )
  ),
  # Linkedin link
  tags$li(class = "dropdown",
          tags$a(href = "http://www.linkedin.com/shareArticle?mini=true&url=hhttps://databiomics.shinyapps.io/rsciencexplorer2016/", 
                 target = "_blank", 
                 tags$img(height = "20px", 
                          src = "linkedin.png")
          )
  ),
  # Twitter link
  tags$li(class = "dropdown",
          tags$a(href = "http://twitter.com/share?url=https://databiomics.shinyapps.io/rsciencexplorer2016/  &text= Explore the most used biomedical terms in 2016 with RSciencexplorer2016!",
                 target = "_blank",
                 tags$img(height = "20px", 
                          src = "twitter.png")
          )
  )

)

sidebar <- dashboardSidebar(
  
  width = 250,
  sidebarMenu(id = 'tab',
    menuItem("Welcome", tabName = "dashbd", icon = icon("info-circle")),
    menuItem("Data Exploration", tabName = "data", icon = icon("flask")),
    menuItem("Network visualization", tabName = "net", icon = icon("arrows")),
    menuItem("I'm looking for a job...Know me!",
             icon = icon("at"), href = "http://www.databiomics.com/about")
  ),
  br(),
  br(),
  br(),
  br(),
  br(),
  br(),
  br(),
  br(),
  br(),
  br(),
  br(),
  hr(),
  # email sharing link
  menuItem("Feedback & suggestion", icon = icon("envelope-o"),
           href = "http://www.databiomics.com/about"))

 
    
body <-  dashboardBody(
  tabItems(
    tabItem(tabName = "dashbd",
            fluidRow(
              column(width = 8,
                     box(title = tags$em("Documentation"), width = 200, solidHeader = TRUE, status = "success",
                         tabsetPanel(type = "tabs", 
                                     tabPanel("Welcome",
                                              fluidRow(
                                                column(width = 12,
                                                       h2("Welcome to RSciencexplorer 2016!",  align = "left"),
                                                       p(" The amount of scientific material produced every year is huge but the capacity of the human being is limited.
                                                         The web application RSciencexplorer is a tool designed to aid the visualization, analysis and exploration
                                                         of biomedical terms that were published in 2016 throught relevant scientific journals (and their twitter accounts). 
                                                         This app was built with R and Shiny and it is designed so that any user of the scientific community can use it"),
                                                       p(strong("Suggested citation:"), "RSciencexplorer2016: A web application for the visualization and exploration of biomedical terms used in 2016, Version 1.0,", style = "font-family: 'times'", 
                                                         tags$img(src = "C_thin.png", width = "10px", height = "10px"), "Francisco Requena"),
                                                       
                                                       h2("How to use!",  align = "left"),
                                                       p(" You can select two types of information sources:", tags$br(), br(),
                                                         tags$b("Research articles:")," You can explore the terms used in articles which have been published during the year 2016 in a specific journal by Title, Abstract or Keywords." ,tags$br(),
                                                         tags$b("Twitter accounts:")," The tweets produced by every scientific journal in this social network.",  tags$br(),
                                                         br(),
                                                         "This app contains three main techniques: wordcloud, find associations and hierachical clustering:" ,  tags$br(),
                                                         br(),
                                                         tags$b("Wordcloud:")," You can create an image with the most frequent terms with the options",tags$em("Minimum Frequency"),
                                                         "(minimum value that a word has to appear so that it can be shown) and ",tags$em("Maximum Number of Words"), "displayed option.",  tags$br(),
                                                         br(),
                                                         br(),
                                                         img(src='2_image.png', align = "centre"),
                                                         br(),
                                                         br(),
                                                         tags$b("Find associations:")," You can write a term (not phrases) and visualize the number of words which appear together, for example, in 
                                                         a title. Besides, you can modify ",tags$em("Correlation limit"), "option. This value allows to adjust the minimum number of associations needed to
                                                         to appear in the table. For example, if we use zika term and a correlation limit of 0.2 in Articles by Titles in the journal Nature, we will
                                                         find a list of terms associated which appear in the titles along to zika term in at least the 20% of the total analyzed titles of this journal .",  tags$br(),
                                                         br(),
                                                         br(),
                                                         img(src='1_image.png', align = "centre"),
                                                         br(),
                                                         br(),
                                                         tags$b("Hierachical clustering:"),"  This method creates groups of terms which are been using together in a title,abstract... Besides, you can specify
                                                         the number of drawn rectangles through the ",tags$em("Number of clusters"), "option"),
                                                       br(),
                                                       br(),
                                                       img(src='3_image.png', align = "centre"),
                                                       br(),
                                                       br(),
                                                       p(" Besides, you can visualize the most frequent terms through a bar plot and the number of tweets by month and day."),
                                                       br(),
                                                       br(),
                                                       img(src='4_image.png', align = "centre"),
                                                       br(),
                                                       br(),
                                                       br(),
                                                       img(src='5_image.png', align = "centre"),
                                                       br(),
                                                       h2("Thanks to...",  align = "left"),
                                                       p(" Thanks to RDatamining.com, a website developed by Dr. Yanchang Zhao, where I could learn about text mining and R."),
                                                       br(),
                                                       br()
                                                       
                                                       
                                                       ))),
                                     
                                     tabPanel("Data source",
                                              h2("Data source",  align = "left"),
                                              p("Published articles during 2016 in the 31 most relevant scientific journals (according to ",a("Eigenfactor", href="http://www.eigenfactor.org/about.php", target="_blank"),") in multiples 
                                                fields of biomedical science...The title, abstract and keywords of the articles analyzed were obtained through Scopus website. Besides the tweets of 28 Twitter accounts from these journals were also analyzed. 
                                                Below you can see a list of the choosen fields and journals:"),
                                              dataTableOutput("welcome1"),
                                              br(),
                                              br(),
                                              dataTableOutput("welcome2")
                                     
                                     )))),
              
              column(width = 4,
                     box(title = tags$em("RSciencexplorer in numbers"), width = 200, solidHeader = TRUE, status = "success",
                         valueBoxOutput("narticles",width = 500),
                         valueBoxOutput("ntweets",width = 500),
                         valueBoxOutput("npapers",width = 500))))
                         
            
            
            
            ),
    
    tabItem(tabName = "net",
            
            fluidRow(
              column(width = 2,
                     box(title = "Data Source", width = 200, solidHeader = TRUE, status = "success",
                         selectInput("selectnet", label = h5(),
                                     choices = list(
                                       "Articles (by Title)" = 1,  
                                       "Tweets" = 2), 
                                     selected = 1),
                         conditionalPanel(
                           condition = "input.selectnet == 1" ,
                           selectInput("select_data_title_net", label = h5(),
                                       choices = journal_accounts_title_dtm,
                                       selected = 'data_articles_nature_title_dtm')),
                    
                         conditionalPanel(
                           condition = "input.selectnet == 2" ,
                           selectInput("select_data_tweet_net", label = h5(),
                                       choices = twitter_accounts_dtm,
                                       selected = 'data_nature_dtm'))),
                     
                     box(title = "Number of occurrences", width = 200, solidHeader = TRUE, status = "success",
                         sliderInput("n_occ",
                                     "Minimum nº of occurrences:",
                                     min = 5,  max = 150, value = 5),
                         tags$em('The process may take some time   (~ 1 min.) depending on the minimum number of occurrences chosen.'))),
                     
              
              
              column(width = 10, solidHeader = TRUE,
                     box(width = NULL, solidHeader = TRUE,
                         tabsetPanel(type = "tabs", 
                                     tabPanel("Network of words",  plotOutput("net_word", height = 750)))
                     ))
            

              
            )),
    
    
    tabItem(tabName = "data",
            
            fluidRow(
              column(width = 2,
                     box(title = "Data Source", width = 200, solidHeader = TRUE, status = "success",
                         selectInput("select_data", label = h5(),
                                      choices = list(
                                                     "Articles (by Title)" = 1,  
                                                     "Articles (by Abstract)" = 2,
                                                     "Articles (by Keywords)" = 3,
                                                     "Tweets" = 4), 
                                      selected = 1),
                         conditionalPanel(
                           condition = "input.select_data == 1" ,
                           selectInput("select_data_title", label = h5(),
                                       choices = journal_accounts_title_dtm,
                                       selected = 'data_articles_nature_title_dtm')),
                         conditionalPanel(
                           condition = "input.select_data == 2" ,
                           selectInput("select_data_abstract", label = h5(),
                                       choices = journal_accounts_abstract_dtm,
                                       selected = 'data_articles_nature_abstract_dtm')),
                         conditionalPanel(
                           condition = "input.select_data == 3" ,
                           selectInput("select_data_key", label = h5(),
                                       choices = journal_accounts_key_dtm,
                                       selected = 'data_articles_nature_key_dtm')),
                         conditionalPanel(
                           condition = "input.select_data == 4" ,
                           selectInput("select_data_tweet", label = h5(),
                                       choices = twitter_accounts_dtm,
                                       selected = 'data_nature_dtm'))),
                     
                     box(title = "Wordcloud", width = 200, solidHeader = TRUE, status = "success",
                         sliderInput("freq",
                                     "Minimum Frequency:",
                                     min = 1,  max = 50, value = 15),
                         sliderInput("max",
                                     "Maximum Number of Words:",
                                     min = 1,  max = 100,  value = 36)),
                   
                   
                     box(title = "Find associations", width = 200, solidHeader = TRUE, status = "success",
                         
                         textInput("term_used", label = h3(""), value = "Enter term..."),
                         sliderInput("correlation_number",
                                     "Correlation limit:",
                                     min = 0.1,  max = 1,  value = 0.2, step = 0.05)),
                     
                     box(title = "Clustering of terms", width = 200, solidHeader = TRUE, status = "success",
                         sliderInput("sparse",
                                     "Minimum Frequency:",
                                     min = 0.80,  max = 0.99, value = 0.99, step = 0.001),
                         radioButtons("draw_rect", "Draw Rectangles Around Hierarchical Clusters? :",
                                      c("Yes" = 1,
                                        "No" = 2), selected = 2),
                         conditionalPanel('input.draw_rect == 1',
                            
                         sliderInput("n_cluster",
                                     "Number of clusters:",
                                     min = 2,  max = 10, value = 2, step = 1)))),
                         
              column(width = 5, solidHeader = TRUE,
                     box(width = NULL, solidHeader = TRUE,
                         tabsetPanel(type = "tabs", 
                                     tabPanel("Wordcloud",  plotOutput("word_cloud", height = 482)))
                     )),
              column(width = 5, solidHeader = TRUE,
                     uiOutput('ui_selection')
       
                     ),
              column(width = 10, solidHeader = TRUE,
                     box(width = NULL, solidHeader = TRUE,
                         tabsetPanel(type = "tabs", 
                                     tabPanel("Clustering of terms",  plotOutput("cluster")),
                                     tabPanel("Most used terms",  plotOutput("word_freq")))
                     ))
                         
                     ))))

dashboardPage(
  skin = "green",
  header,
  sidebar,
  body
)
