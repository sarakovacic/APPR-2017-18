library(shiny)
library(datasets)

shinyServer(function(input, output) {
  output$box <- renderPlot({
    if(input$type == "Površina gozda"){
      print(g3)}
    else if (input$type == "Letni prirastek"){
      print(gg33)}
    else if (input$type == "Letni posek"){
      print(g333)}
    else if (input$type == "Prirastek in posek"){
      print(gg3)}
    else if (input$type == "Zemljevid po regijah"){
      print(zemljevid.delez)}
  })
}
)