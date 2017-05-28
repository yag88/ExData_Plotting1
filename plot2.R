######################## 

## Plot 2

######################## Initially same as plot1.R for loading the data and subsetting
## Import household power consumption data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "household_power_consumption.zip")

## Unzip the file and read into R
unzip("household_power_consumption.zip", exdir = "..")

# use read_csv2 from readr package
library(readr)
mydata <- read_csv2("household_power_consumption.txt")

# Subsetting on the 2 dates we're looking for: 
myabstract <- mydata[mydata$Date %in% c("1/2/2007","2/2/2007"),]
# converting data to the correct type numeric: 

myabstract[,4:9] <- sapply(myabstract[,4:9], as.numeric)
#==========================================================
# in addition, I need a new date-time column, build from column 1 (char Date) and column 2 (time Time)
myabstract$datetime <- strptime(paste(myabstract$Date,myabstract$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

## Now we star plotting: 
# open device
png(filename = "plot2.png", height=480, width=480)
# plot the line, avoid the "datetime" x-label
with(myabstract, plot(datetime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
#don't forget to close the device
dev.off()
