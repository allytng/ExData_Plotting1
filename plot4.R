# Reconstruct plot 4 to examine how household energy usage varies over a 2-day period in February, 2007 (2007-02-01 and 2007-02-02).

## Download data into working directory, if not already done 

dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists("power.zip")) {
        download.file(dataset_url, "power.zip")
}

if(!file.exists("household_power_consumption.txt")) {
        unzip("power.zip")
}

## Read data into R

fulldata <- read.table("household_power_consumption.txt", na.strings = "?", sep = ";", header = TRUE)

## Convert the Date and Time variables to Date/Time classes 

fulldata$Time <- strptime(paste(fulldata$Date, fulldata$Time), "%d/%m/%Y %H:%M:%S")
fulldata$Date <- as.Date(fulldata$Date, "%d/%m/%Y")

## Subset data to required dates in Feb: 2007-02-01 and 2007-02-02

data <- fulldata[fulldata$Date == "2007-02-01" | fulldata$Date == "2007-02-02", ]

## Construct plot 4 and save in png file with width of 480 pixels and height of 480 pixels. 

png(filename = "plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2), mar = c(5, 5, 3, 1)) ### allow 4 plots and set margins

### Global Active Power plot 
plot(data$Time, data$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "") 

### Voltage plot
plot(data$Time, data$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

### Energy sub metering plot
plot(data$Time, data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "") 
points(data$Time, data$Sub_metering_2, type = "l", col = "red") 
points(data$Time, data$Sub_metering_3, type = "l", col = "blue") 
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, bty = "n")  

### Global_reactive_power plot
plot(data$Time, data$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")

dev.off()