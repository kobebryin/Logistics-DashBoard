library(leaflet)
library(shiny)

fluidPage(
  titlePanel("dashboard"),
  sidebarLayout(
    sidebarPanel(
      # upload .csv
      fileInput('file1', 'Choose CSV File',
                accept=c('text/csv', 
                         'text/comma-separated-values,text/plain', 
                         '.csv')),
      # Simple integer interval
      sliderInput("integer", "Radius:",
                  min=6500, max=26500, value=6500)
    ),
    mainPanel(
      leafletOutput('map',width = "100%",height = 800)
    )
  )
)