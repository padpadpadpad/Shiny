
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  headerPanel("Modified Sharpe-Schoolfield Thermal Response Curves"),

  # Sidebar with a slider input for number of bins

    fluidRow(
      column(2,
          
          h3('Schoolfield high parameters'),
      
          sliderInput("b(Tc)",
                  "b(Tc):",
                  min = -10,
                  max = 10,
                  value = 0,
                  step = 0.1),
          sliderInput("Tc",
                  "Tc:",
                  min = 0,
                  max = 100,
                  value = 20,
                  step = 1),
          sliderInput("Ea",
                  "Ea:",
                  min = 0,
                  max = 2,
                  value = 0.6,
                  step = 0.1),
          sliderInput("Eh",
                  "Eh:",
                  min = 0,
                  max = 10,
                  value = 4,
                  step = 0.1),
          sliderInput("Th",
                  "Th:",
                  min = 0,
                  max = 100,
                  value = 40,
                  step = 1)
      ),
      column(2,
             
             h3('Full model parameters'),
             
             sliderInput("b(Tc)2",
                         "b(Tc):",
                         min = -10,
                         max = 10,
                         value = 0,
                         step = 0.1),
             sliderInput("Tc2",
                         "Tc:",
                         min = 0,
                         max = 100,
                         value = 20,
                         step = 1),
             sliderInput("Ea2",
                         "Ea:",
                         min = 0,
                         max = 2,
                         value = 0.6,
                         step = 0.1),
             sliderInput("El",
                         "El:",
                         min = 0,
                         max = 10,
                         value = 4,
                         step = 0.1),
             sliderInput("Tl",
                         "Tl:",
                         min = 0,
                         max = 100,
                         value = 15,
                         step = 1),
             sliderInput("Eh2",
                         "Eh:",
                         min = 0,
                         max = 10,
                         value = 4,
                         step = 0.1),
             sliderInput("Th2",
                         "Th:",
                         min = 0,
                         max = 100,
                         value = 40,
                         step = 1)
      ),
      column(8,
             checkboxGroupInput('Curve', 'Curve:', choices = c("High inactivation only", "Full model"), selected = NULL, inline = TRUE),
             sliderInput("temp",
                         "Temperature ºC:",
                         min = 0,
                         max = 100,
                         value = c(10, 50),
                         step = 1),
             plotOutput("plot1"),
             tableOutput("values"))

    )

))
