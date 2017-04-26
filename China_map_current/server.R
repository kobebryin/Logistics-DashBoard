library(shiny)
library(leaflet)
library(htmltools)

df <- read.csv(
  "a.csv"
)

function(input,output){
  output$map <- renderLeaflet({
    inFile <- input$file1    #load upload .csv file
    
    # if nothing upload then return null - no map showing
    if (is.null(inFile)){
      return(NULL)
    }
    
    file <- read.csv(inFile$datapath) #read upload file
    value <- file[,11]                # get the row what we need !11 row is 同步/市配
    value_chr<-gsub("%", "", as.character(value) ) #convert factor to character and split the "%"
    value_int<-as.double(value_chr)   # convert data to double
    df2 <- data.frame(df,value_int)   # put it into df2
    
    df_paste <- data.frame() # create a new df(use for paste Name and value)
    df_length <- nrow(df2)   # get the length of df2
    start <- 1               # variable for repeat loop
    
    #loop for paste row of Name and value
    repeat{
      if(start > df_length){
        break
      }else{
        content <- paste(sep = "<br/>",df2[start,1],df2[start,4])
        df_paste[start,1] <- content
        start <- start + 1
      }
    }
    df_result <- data.frame(df2,df_paste) # set all file in new df_result(data.frame)
    #Name:city name
    #Long:longitude
    #Lat:latitude
    #value:data
    #V1: Name + value
    
    #slider's value
    radiusValue = input$integer
    
    #show the map include visualize data 
    leaflet(df_result) %>%
      addTiles() %>%
      setView(lng=110.601,lat=30.179,zoom=4) %>%
      #addMarkers(~Long, ~Lat, popup = ~as.character(value))  
      addCircles(lng = ~Long, lat = ~Lat, weight = 1,
               radius = ~sqrt(value_int)*radiusValue, popup = ~V1
      )
  })
}



