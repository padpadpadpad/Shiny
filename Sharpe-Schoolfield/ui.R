
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Modified Sharpe-Schoolfield Thermal Response Curves"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel('Parameters:',
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
                  value = 50,
                  step = 5),
      sliderInput("Ea",
                  "Ea:",
                  min = 0,
                  max = 2,
                  value = 1,
                  step = 0.1),
      sliderInput("Eh",
                  "Eh:",
                  min = 0,
                  max = 10,
                  value = 5,
                  step = 0.5),
      sliderInput("Th",
                  "Th:",
                  min = 0,
                  max = 100,
                  value = 50,
                  step = 5)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("SHplot")
    )
  )
))
