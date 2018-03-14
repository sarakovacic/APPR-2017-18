library(shiny)
library(DT)
library(shinythemes)

shinyUI(fluidPage(theme = shinytheme("cyborg"),
  titlePanel("Gozdovi v Sloveniji"), 
  sidebarLayout(
    sidebarPanel(
      selectInput("type",label="Kategorija",
                  choice=c("Površina gozda", "Letni posek", "Letni prirastek",
                           "Prirastek in posek", "Zemljevid po regijah")
                           
      )
    ),
    mainPanel(plotOutput("box")
    ) 
    
  )))