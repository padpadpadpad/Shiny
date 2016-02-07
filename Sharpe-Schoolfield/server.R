
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(TeamPhytoplankton)
library(ggplot2)
library(grid)
library(gridExtra)

shinyServer(function(input, output) {
  
  # create output graph
  output$plot1 <- renderPlot({
    
    plot1.data <- data.frame(expand.grid(temperature = seq(input$temp[1], input$temp[2], 0.1), curve = c('High inactivation only', 'Full model')))
    
    plot1.data$y <- NA
    
    plot1.data$y[plot1.data$curve == 'High inactivation only'] <- schoolfield.high(input$`b(Tc)`, input$Ea, input$Eh, input$Th + 273.15, temp = plot1.data$temperature[plot1.data$curve == 'High inactivation only'] + 273.15, Tc = input$Tc)
    plot1.data$y[plot1.data$curve == 'Full model'] <- schoolfield(input$`b(Tc)2`, input$Ea2, input$El, input$Tl + 273.15, input$Eh2, input$Th2 + 273.15, temp = plot1.data$temperature[plot1.data$curve == 'Full model'] + 273.15, Tc = input$Tc2)
    
     bTc <- data.frame(rate = c(input$`b(Tc)`, schoolfield(ln.c = input$`b(Tc)2`, Ea = input$Ea2, El = input$El, Tl = input$Tl + 273.15, Eh = input$Eh2, Th = input$Th2 + 273.15, temp = input$Tc2 + 273.15, Tc = input$Tc2)), temp = c(input$Tc, input$Tc2), curve = c('High inactivation only', 'Full model'))   
     
     
    
     plot1 <-  ggplot(plot1.data[plot1.data$curve %in% input$Curve,],
                      aes(x = temperature, y = y, group = curve)) +
      geom_line(aes(col = curve), linetype = 1, size = 1.5) +
      geom_point(aes(temp, rate), col = 'black', size = 4, bTc[bTc$curve %in% input$Curve,]) +
      theme_classic(base_size = 18, base_family = 'Helvetica') +
      theme(legend.title=element_blank()) + 
      xlab('Temperature (ºC)') +
      ylab('ln Rate') 
  
     # fancy plot
     grid.plot <- viewport(layout = grid.layout(nrow = 2, ncol = 1, heights = c(0.1, 0.9)))
     grid.1 <- viewport(layout.pos.col = 1, layout.pos.row = 2, name = 'grid.1')
     grid.2 <- viewport(layout.pos.col = 1, layout.pos.row = 1, name = 'grid.2')
     
     splot <- vpTree(grid.plot, vpList(grid.2, grid.1))
     
     vplayout <- function(x, y)
       viewport(layout.pos.row = x, layout.pos.col = y)
     
     # assemble plot
     grid.newpage()
     pushViewport(splot)
     seekViewport('grid.1')
     print(plot1, vp = vplayout(2,1))
     seekViewport('grid.2')
     if('High inactivation only' %in% input$Curve){
       grid.text(paste('High Inactivation \n Topt = ', round(Topt(input$Eh, input$Th + 273.15, input$Ea, K = 'N'), 2),'ºC'), x = unit(0.8, 'npc'), just = 'right', gp = gpar(fontsize = 16, fontfamily='Helvetica'))
     }
     if('Full model' %in% input$Curve){
       grid.text(paste('Full model \n Topt = ', round(Topt(input$Eh2, input$Th2 + 273.15, input$Ea2, K = 'N'), 2),'ºC'), x = unit(0.1, 'npc'), just = 'left', gp = gpar(fontsize = 16, fontfamily='Helvetica'))
     }

  }, height = 400)

##############################################################################################
  # create output table for parameters used
  sliderValues <- reactive({
   data.frame(curve = c('High inactivation only', 'Full model'), bTc = c(input$`b(Tc)`, input$`b(Tc)2`), Tc = c(input$Tc, input$Tc2), Ea = c(input$Ea, input$Ea2), Eh = c(input$Eh, input$Eh2),  Th = c(input$Th, input$Th2), Topt = c(round(Topt(input$Eh, input$Th + 273.15, input$Ea, K = 'N'), 2), round(Topt(input$Eh2, input$Th2 + 273.15, input$Ea2, K = 'N'), 2)), El = c(NA, input$El), Tl = c(NA, input$Tl))
  })
  
  output$values <- renderTable({
   sliderValues()
  })

})
