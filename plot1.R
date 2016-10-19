if(!file.exists("data.zip")) {
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url, "data.zip")    
}

if(!file.exists("household_power_consumption.txt")) {
    unzip(zipfile = "data.zip")
}


