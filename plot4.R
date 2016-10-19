#Source code for creating plot4
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
png("plot4.png", width = 480, height = 480)
    #four plots
    #1,2
    #3,4
    par(mfrow=c(2,2))
    
    #plot 1
    plot(x = data$datetime, 
         y = data$Global_active_power, 
         type="l",
         ylab="Global Active Power (kilowatts)",
         xlab="")
    
    #plot 2
    plot(x = data$datetime, 
         y = data$Voltage,
         type = "l",
         xlab = "datetime",
         ylab = "Voltage")
    
    #plot 3
    plot(y = data$Sub_metering_1, 
         x = data$datetime,
         type="n",
         ylab="Energy sub metering",
         xlab="")
    points(x=data$datetime,y=data$Sub_metering_1, type="l")
    points(x=data$datetime,y=data$Sub_metering_2, type="l", col = "red")
    points(x=data$datetime,y=data$Sub_metering_3, type="l", col = "blue")
    legend("topright", 
           lty = 1, 
           col = c("black", "red", "blue"), 
           c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    #plot 4
    plot(x = data$datetime, 
         y = data$Global_reactive_power, 
         type="l",
         ylab="Global_reactive_power",
         xlab="datatime")
dev.off()
