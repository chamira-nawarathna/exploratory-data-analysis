## selecting the working directory
setwd("C:/Users/star/Desktop/Exploratory_Data_Analysis")

householdFile <- "./household_power_consumption.txt"

## Reading the data from the table
plotData <- read.table(householdFile, header=T, sep=";", na.strings="?")

## Format date to Type Date
plotData$Date <- as.Date(plotData$Date, "%d/%m/%Y")

## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
plotData <- subset(plotData,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove incomplete observation
plotData <- plotData[complete.cases(plotData),]

## Combine Date and Time column
dateTime <- paste(plotData$Date, plotData$Time)

## Name the vector
dateTime <- setNames(dateTime, "DateTime")

## Remove Date and Time column
plotData <- plotData[ ,!(names(plotData) %in% c("Date","Time"))]

## Add DateTime column
plotData <- cbind(dateTime, plotData)

## Format dateTime Column
plotData$dateTime <- as.POSIXct(dateTime)

## Create Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(plotData, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

## Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()