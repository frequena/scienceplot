library(shinydashboard)
header <- dashboardHeader(
  title = "Rscience2016 - A Webtool for the visualization of biomedical terms in 2016",
  titleWidth = 780,
  #Facebook Sharing
  tags$li(class = "dropdown",
          tags$a(href = "http://www.facebook.com/sharer.php?u=https://ow-raza.shinyapps.io/sectarianviolencePK/", 
                 target = "_blank", 
                 tags$img(height = "20px", 
                          src = "fb2.png")
          )
  ),
  # Linkedin link
  tags$li(class = "dropdown",
          tags$a(href = "http://www.linkedin.com/shareArticle?mini=true&url=https://ow-raza.shinyapps.io/sectarianviolencePK/", 
                 target = "_blank", 
                 tags$img(height = "20px", 
                          src = "linkedin.png")
          )
  ),
  # Twitter link
  tags$li(class = "dropdown",
          tags$a(href = "http://twitter.com/share?url=https://ow-raza.shinyapps.io/sectarianviolencePK/  &text= my first shiny app @reye27",
                 target = "_blank",
                 tags$img(height = "20px", 
                          src = "twitter.png")
          )
  ),
  # Github link
  tags$li(class = "dropdown",
          tags$a(href = "https://github.com/oraza",
                 target = "_blank",
                 tags$img(height = "20px", 
                          src = "github.png")))
)

sidebar <- dashboardSidebar(
  
  width = 250,
  sidebarMenu(id = 'tab',
    menuItem("Welcome", tabName = "dashbd", icon = icon("dashboard")),
    menuItem("Articles Data", icon = icon("navicon"), tabName = "graphs", 
             menuSubItem("by Title", tabName = "journal_title", icon = icon("database")), 
             menuSubItem("by Abstract", tabName = "journal_abstract", icon = icon("database")),
             menuSubItem("by Keywords", tabName = "journal_key", icon = icon("database"))),
    menuItem("Twitter Data", tabName = "tweets", icon = icon("th"))
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
           href = "mailto:?ow.raza@hotmail.com?subject=Feedback on VAS app"),
  br(),
  # source code link
  menuItem("Source code", icon = icon("file-code-o"), 
           href = "https://github.com/oraza/sectarianviolencePK"),
  br(),
  # github fork link
  menuItem("Fork me @ github", icon = icon("code-fork"), 
           href = "https://github.com/oraza/sectarianviolencePK"))
 
    
body <-  dashboardBody(
  tabItems(
    tabItem(tabName = "dashbd",
            fluidRow(
              
            h2("Introduction",  align = "center", style = "font-family: 'times'; color:red"),
            p("Shia population is estimated between 5% to 20% of total population of Pakistan. Since last five decades,
              Shia in Pakistan have been targeted by various militant groups. Doctors, lawyers, businessmen, teachers and
              other professionals have been under attacks by various Sunni Muslim militant groups, most prominently", 
              a("Sipah-e-Sahaba", href = "https://en.wikipedia.org/wiki/Sipah-e-Sahaba_Pakistan")," and",
              a("Lashkar-e-Jhangvi.", href="https://en.wikipedia.org/wiki/Lashkar-e-Jhangvi"),"These attacks have
              significantly surged after the end of Afghan War, when local anti-shia milinants came under coaliation with",
              a("Talibans.", href = "https://en.wikipedia.org/wiki/Taliban"), style = "font-family: 'times'"),
            fluidPage(
              fluidRow(
                column(
                  h2("About this app ...", align = "center", style = "font-family: 'times'; color:red"),
                  p("This app helps you to explore and visualize the sectarian violence against Shia community in Pakistan. 
                    I have used the database available", a("here.", href="http://lubpak.com/archives/132675"), 
                    style = "font-family: 'times'"),
                  width = 4,
                  align = "left"
                  
                ),
                column(
                  h2("How to use!", style = "font-family: 'times'; color:red"),
                  p("This app contains two major sections; database and graphs. After cleaning and re-defining type of incident, 
                    two variables were added, i.e, type of government and president at the day of incident. This new 
                    addition was done to explore and understand further relationship of sectarian violence in Pakistan.", 
                    style = "font-family: 'times'"), 
                  p("Section for", strong("data"), "presents the database, which is provided with copying, printing and 
                    downloading options. Section for", strong("visualization"), "has two sub-sections, a. explorer for 
                    people killed & b. explorer for people injured in sectarian violence. In these sub-sections, data is
                    plotted against geo-political regions of Pakistan. Within each sub-section, navigation panel contains four 
                    tabs that plot data points according to the selected tab. Graphs are plotted on an interactive platform,
                    such that when the mouse-pointer hovers over data-point it shows further information. Users can choose to
                    turn off the data-points by clicking on labels given in the legend.", 
                    style = "font-family: 'times'"),
                  width = 8,
                  align = "left"
                ),
                br(),
                br()
              )
            ),
            br(),
            br(),
            p(strong("Suggested citation:"), "Violnce Against Shia: App for exploring and visualizing sectarian violence
              in Pakistan, 1968 - 2014, Version 1.0,", style = "font-family: 'times'", 
              tags$img(src = "C_thin.png", width = "10px", height = "10px"), "Owais Raza")
    )),  
    
    
    tabItem(tabName = "journal_title",
            
            fluidRow(
              column(width = 2,
                     box(title = "Journal Name", width = 200, solidHeader = TRUE, status = "success",
                         selectInput("select_journal_title", label = h4(""),
                                     choices = journal_accounts_title_dtm,
                                     selected = "data_articles_nature_title_dtm")),
                     box(title = "Wordcloud", width = 200, solidHeader = TRUE, status = "success",
                         sliderInput("freq",
                                     "Minimum Frequency:",
                                     min = 1,  max = 50, value = 15),
                         sliderInput("max",
                                     "Maximum Number of Words:",
                                     min = 1,  max = 300,  value = 100))

                         
                     ),
              
              column(width = 5, solidHeader = TRUE,
                     box(width = NULL, solidHeader = TRUE,
                         tabsetPanel(type = "tabs", 
                                     tabPanel("Wordcloud",  plotOutput("###")))
                     )),
              column(width = 5, solidHeader = TRUE,
                     box(width = NULL, solidHeader = TRUE,
                         tabsetPanel(type = "tabs", 
                                     tabPanel("Tweets by month",  plotOutput("###")),
                                     tabPanel("Tweets by day",  plotOutput("####")))
                     )),
              column(width = 10, solidHeader = TRUE,
                     box(width = NULL, solidHeader = TRUE,
                         tabsetPanel(type = "tabs", 
                                     tabPanel("Frequent Words",  plotOutput("###")))
                         
                     )))
            ),
    
    tabItem(tabName = "journal_abstract",

            fluidRow(
              column(width = 2,
                     box(title = "Journal Name", width = 200, solidHeader = TRUE, status = "success",
                         selectInput("select_journal_abstract", label = h4(""),
                                     choices = journal_accounts_abstract_dtm,
                                     selected = "data_articles_nature_abstract_dtm")),
                     box(title = "Wordcloud", width = 200, solidHeader = TRUE, status = "success",
                         sliderInput("freq",
                                     "Minimum Frequency:",
                                     min = 1,  max = 50, value = 15),
                         sliderInput("max",
                                     "Maximum Number of Words:",
                                     min = 1,  max = 300,  value = 100))
                     
                     
              ),
              
              
              column(width = 5, solidHeader = TRUE,
                     box(width = NULL, solidHeader = TRUE,
                         tabsetPanel(type = "tabs", 
                                     tabPanel("Wordcloud",  plotOutput("###")))
                     )),
              column(width = 5, solidHeader = TRUE,
                     box(width = NULL, solidHeader = TRUE,
                         tabsetPanel(type = "tabs", 
                                     tabPanel("Tweets by month",  plotOutput("###")),
                                     tabPanel("Tweets by day",  plotOutput("###")))
                     )),
              column(width = 10, solidHeader = TRUE,
                     box(width = NULL, solidHeader = TRUE,
                         tabsetPanel(type = "tabs", 
                                     tabPanel("Frequent Words",  plotOutput("###")))
                         
                     )))
    ),
  
tabItem(tabName = "journal_key",
        
        fluidRow(
          column(width = 2,
                 box(title = "Journal Name", width = 200, solidHeader = TRUE, status = "success",
                     selectInput("select_journal_key", label = h4(""),
                                 choices = journal_accounts_key_dtm,
                                 selected = "data_articles_nature_key_dtm")),
                 box(title = "Wordcloud", width = 200, solidHeader = TRUE, status = "success",
                     sliderInput("freq",
                                 "Minimum Frequency:",
                                 min = 1,  max = 50, value = 15),
                     sliderInput("max",
                                 "Maximum Number of Words:",
                                 min = 1,  max = 300,  value = 100))
                 
                 
          ),
          
          column(width = 5, solidHeader = TRUE,
                 box(width = NULL, solidHeader = TRUE,
                     tabsetPanel(type = "tabs", 
                                 tabPanel("Wordcloud",  plotOutput("###")))
                 )),
          column(width = 5, solidHeader = TRUE,
                 box(width = NULL, solidHeader = TRUE,
                     tabsetPanel(type = "tabs", 
                                 tabPanel("Tweets by month",  plotOutput("###")),
                                 tabPanel("Tweets by day",  plotOutput("###")))
                 )),
          column(width = 10, solidHeader = TRUE,
                 box(width = NULL, solidHeader = TRUE,
                     tabsetPanel(type = "tabs", 
                                 tabPanel("Frequent Words",  plotOutput("###")))
                     
                 )))
),
tabItem(tabName = "tweets",
        
fluidRow(
  column(width = 2,
         box(title = "Twitter Account", width = 200, solidHeader = TRUE, status = "success",
             selectInput("select_twitter_account", label = h4(""),
                         choices = twitter_accounts_dtm,
                         selected = 'data_nature_dtm')),
         box(title = "Wordcloud", width = 200, solidHeader = TRUE, status = "success",
             sliderInput("freq1",
                         "Minimum Frequency:",
                         min = 1,  max = 50, value = 15),
             sliderInput("max1",
                         "Maximum Number of Words:",
                         min = 1,  max = 300,  value = 100))
         
         
  ),
  
  column(width = 5, solidHeader = TRUE,
         box(width = NULL, solidHeader = TRUE,
             tabsetPanel(type = "tabs", 
                         tabPanel("Wordcloud",  plotOutput("word_cloud")))
         )),
  column(width = 5, solidHeader = TRUE,
         box(width = NULL, solidHeader = TRUE,
             tabsetPanel(type = "tabs", 
                         tabPanel("Tweets by month",  plotOutput("###")),
                         tabPanel("Tweets by day",  plotOutput("###")))
         )),
  column(width = 10, solidHeader = TRUE,
         box(width = NULL, solidHeader = TRUE,
             tabsetPanel(type = "tabs", 
                         tabPanel("Frequent Words",  plotOutput("word_freq")))
             
         ))))))


dashboardPage(
  skin = "green",
  header,
  sidebar,
  body
)
