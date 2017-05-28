## plot1

## load files only for the dates 2007-02-01 and 2007-02-02

## Import household power consumption data

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "household_power_consumption.zip")

## Unzip the file and read into R
unzip("household_power_consumption.zip", exdir = "..")

# I tried the read.table first, (see below), but it's too long.
#mydata <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, colClasses = c("character", "character", rep("numeric", 7)), na.strings = "?")
## with system.time: 
## user  system elapsed 
## 16.419   0.756  18.632 


# instead, I can use read_csv2 from readr package
library(readr)
# I tried to load directly into the right types (using col_types) - see below my trials. 
# but finally it's faster to keep everything "as is", make the subset from the date as string, and force numbers into numeric later
##mycol <- cols( .default = col_double(), Date = col_date(format = "%d/%m/%Y"), Time = col_time(format = "%H:%M:%S"))
##mycol <- cols( Date = col_date(format = "%d/%m/%Y"))

system.time(mydata <- read_csv2("household_power_consumption.txt")
# this one is fast: 
# user  system elapsed 
# 3.930   0.432   4.532

# Subsetting on the 2 dates we're looking for: 
myabstract <- mydata[mydata$Date %in% c("1/2/2007","2/2/2007"),]
# converting data to the correct types: Date, Time, and numeric: 

myabstract[,4:9] <- sapply(myabstract[,4:9], as.numeric)

#==========================================================
## Now we star plotting: 
# open device
png(filename = "plot1.png", height=480, width=480)
# plot the histogram (1 line is enough)
hist(myabstract$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
#don't forget to close the device
dev.off()
