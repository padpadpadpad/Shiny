
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(TeamPhytoplankton)
library(ggplot2)

temperature <- seq(0,100,0.1)

shinyServer(function(input, output) {
  
  # create output graph
  output$SHplot <- renderPlot({
    ggplot() +
      geom_line(aes(temperature, schoolfield.high(input$`b(Tc)`, input$Ea, input$Eh, input$Th + 273.15, temp = temperature + 273.15, Tc = input$Tc)), linetype = 2, col = 'red', size = 3) +
      theme_classic(base_size = 18, base_family = 'Helvetica') +
      xlab('Temperature (ºC)') +
      ylab('ln Rate')
  })

})
