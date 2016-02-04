
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(TeamPhytoplankton)
library(ggplot2)

shinyServer(function(input, output) {
  
  # create output graph
  output$plot1 <- renderPlot({
    
    plot1.data <- data.frame(expand.grid(temperature = seq(input$temp[1], input$temp[2], 0.1), curve = c('High inactivation only', 'Full model')))
    
    plot1.data$y <- NA
    
    plot1.data$y[plot1.data$curve == 'High inactivation only'] <- schoolfield.high(input$`b(Tc)`, input$Ea, input$Eh, input$Th + 273.15, temp = plot1.data$temperature[plot1.data$curve == 'High inactivation only'] + 273.15, Tc = input$Tc)
    plot1.data$y[plot1.data$curve == 'Full model'] <- schoolfield(input$`b(Tc)2`, input$Ea2, input$El, input$Tl + 273.15, input$Eh2, input$Th2 + 273.15, temp = plot1.data$temperature[plot1.data$curve == 'Full model'] + 273.15, Tc = input$Tc2)
    
    head(plot1.data)
    
     plot1 <-  ggplot(plot1.data[plot1.data$curve %in% input$Curve,],
                      aes(x = temperature, y = y, group = curve)) +
      geom_line(aes(col = curve), linetype = 1, size = 1.5) +
      theme_classic(base_size = 18, base_family = 'Helvetica') +
      xlab('Temperature (ºC)') +
      ylab('ln Rate') 

    print(plot1)
  })

##############################################################################################
  # create output table for parameters used
  sliderValues <- reactive({
   data.frame(bTc = input$`b(Tc)`, Tc = input$Tc, Ea = input$Ea, Eh = input$Eh, Th = input$Th, row.names = NULL)
  })
  
  output$values <- renderTable({
   sliderValues()
  })

})
