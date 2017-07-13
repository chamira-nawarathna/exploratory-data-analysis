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

## Create the histogram
hist(plotData$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

## Save file and close device
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()