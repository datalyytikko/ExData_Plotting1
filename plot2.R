#Source code for creating plot2
library(lubridate)
library(readr)
library(dplyr)

#fetch data if needed
if(!file.exists("data.zip")) {
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url, "data.zip")    
}

#unpack data if needed
if(!file.exists("household_power_consumption.txt")) {
    unzip(zipfile = "data.zip")
}

#read all
data <- read_delim(file = "household_power_consumption.txt", 
                   delim =";", 
                   na = c("?"))

#leave only the ones we're interested in
data <- data %>%
    filter(Date == "2/2/2007" | Date == "1/2/2007") 

#fix datatypes
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$datetime = data$Date + seconds(data$Time)

#create plot and save it as png
png("plot2.png", width = 480, height = 480)
    plot(x = data$datetime, 
         y = data$Global_active_power, 
         type="l",
         ylab="Global Active Power (kilowatts)",
         xlab="")
dev.off()