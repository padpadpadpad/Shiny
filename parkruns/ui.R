# shiny app with leaflet to add graphs to the side
# ui
library(leaflet)
library(shinydashboard)



header <- dashboardHeader(
  title = "Parkruns UK"
)

body <- dashboardBody(
  fluidRow(
    column(width = 8,
           box(width = NULL, title = 'Introduction',
               collapsible = TRUE,
               solidHeader = TRUE,
               status = 'success',
               p("Since coming back to running after a long-term injury, I took up running a weekly parkrun. My weekly parkrun is Trelissick in South Cornwall and it is rather hilly. However, there appears to be nowhere on the internet where you can compare the different parkrun profiles to get a handle on how hilly YOUR parkrun is! This is my attempt at doing that. All the data was collected using the Strava API using the package rStrava. Hope you enjoy it. Currently I have only managed to get the parkruns from A-M.")),
           box(width = NULL, solidHeader = TRUE,
               leafletOutput("map", height = 610)
           )),
    column(width = 4,
           box(width = NULL, title = 'Selected parkrun elevation profile:',
               plotOutput("elev_plot", height = 240),
               status = 'success'
               ),
           box(width = NULL, title = 'How hilly is the selected parkrun?',
               status = 'success',
               plotOutput("elev_dist", height = 240))
    )
  )
)

dashboardPage(
  skin = 'green',
  header,
  dashboardSidebar(disable = TRUE),
  body
)
    
           