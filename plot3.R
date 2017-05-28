########################

## Plot 3

######################## Initially same as plot1.R for loading the data and subsetting
## load files only for the dates 2007-02-01 and 2007-02-02

## Import household power consumption data

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "household_power_consumption.zip")

## Unzip the file and read into R
unzip("household_power_consumption.zip", exdir = "..")

#  use read_csv2 from readr package
library(readr)
#  it's faster to keep everything "as is", make the subset from the date as string, and force numbers into numeric later
mydata <- read_csv2("household_power_consumption.txt")

# Subsetting on the 2 dates we're looking for: 
myabstract <- mydata[mydata$Date %in% c("1/2/2007","2/2/2007"),]
# converting data (except date time) to the correct type numeric: 
myabstract[,4:9] <- sapply(myabstract[,4:9], as.numeric)

# in addition, I need a new date-time column, build from column 1 (char Date) and column 2 (time Time)
myabstract$datetime <- strptime(paste(myabstract$Date,myabstract$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
#==========================================================

## Now we star plotting: 
# open device
png(filename = "plot3.png", height=480, width=480)
# plot the first line in black, avoid the "datetime" xlabel 
with(myabstract, plot(datetime, Sub_metering_1, type='l', col="black", xlab = "", ylab='Energy sub metering'))
# the red and blue lines
with(myabstract, lines(datetime, Sub_metering_2, col="red"))
with(myabstract, lines(datetime, Sub_metering_3, col="blue"))
# and the legend from a 3-vector
legend(x='topright', legend=colnames(myabstract)[7:9], col=c('black', 'red', 'blue'), lty=rep(1, 3))
#don't forget to close the device
dev.off()
