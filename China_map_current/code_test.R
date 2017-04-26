df <- read.csv(
  "a.csv"
)

file <- read.csv("new_data.csv") #read upload file
value <- file[,11]# get the row what we need !1row is 同步/市配
value_chr<-gsub("%", "", as.character(value) )
value_int<-as.double(value_chr)
df2 <- data.frame(df,value_int) # put it into df2

df_paste <- data.frame()# create a new df(use for paste Name and value)
df_length <- nrow(df2) # get the length of df2
start <- 1 # variable for repeat loop

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
