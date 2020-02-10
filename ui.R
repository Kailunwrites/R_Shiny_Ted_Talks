library(DT)
library(shiny)
library(shinydashboard)


shinyUI(dashboardPage(
    dashboardHeader(title = "Dashboard"),
    
    dashboardSidebar(
        
        sidebarUserPanel("Ted Talks"),
        sidebarMenu(
            menuItem("Popularity", tabName = "statistics", icon = icon("fire")),
            menuItem("Sentiment", tabName = "statistics_2", icon = icon("user-cog")),
            menuItem("Word Tree Popularity", tabName="pic1", icon= icon("map")),
            menuItem("Word Tree Sentiment", tabName="pic2", icon= icon("map")),
            menuItem("Data", tabName = "data", icon = icon("database"))
        )
        
        # selectizeInput("selected",
        #                "Select Item to Display",
        #                choice)
    ),
    
    dashboardBody(
        
        tags$head(
            tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
        ),
        
        tabItems(
            tabItem(tabName = "statistics",
                    
                    fluidRow(infoBoxOutput("maxBox"),
                             infoBoxOutput("minBox")),
                    
                    fluidRow(box(htmlOutput("bar"), height = 300),
                             box(htmlOutput("hist"), height = 300)),
                            
                    fluidRow(box(numericInput("num_low", label = h3("Numeric input low"), value= 50000 )),
                             
                             box(numericInput("num_high", label = h3("Numeric input high"), value= 50000000 )),
                             box(selectizeInput("selected",
                                                "Select Item to Display",
                                                choice))
                             )),
            
            tabItem(tabName = "statistics_2",

                    fluidRow(infoBoxOutput("maxBox2"),
                             infoBoxOutput("avgBox2")),

                    fluidRow(box(htmlOutput("statistics_2"), height = 300),
                             box(htmlOutput("hist_2"), height = 300)),
                    
                    fluidRow(box(selectizeInput("selected2",
                                                "Select Item to Display",
                                                choice2)))),
            
            tabItem(tabName="pic1", 
                    tags$img(width=1500, height=1000, src='Most_Views.png')),
                    
                    #box(selectizeInput("Talk_picture", "Select Talk to Display",choice3))),
            tabItem(tabName="pic2", 
                    tags$img(width=1500, height=1000, src='Long_wind.png')),
            
            tabItem(tabName = "data",
                    fluidRow(box(DT::dataTableOutput("table"), width = 12)))
        )
        
    )
))