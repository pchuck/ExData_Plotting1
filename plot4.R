#! /usr/bin/env Rscript
##
##   generate tiled power graphics
##

## read the data file
power = read.csv("data/household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE)

## extract only data from 2007-02-{01,02}
feb2power = subset(power, Date == "1/2/2007" | Date == "2/2/2007")

## convert to numerics and combine date/time into a single column
feb2power$Global_active_power = as.numeric(feb2power$Global_active_power)
feb2power$Date = strptime(paste(feb2power$Date, feb2power$Time), format="%d/%m/%Y %H:%M:%S")

## create the tiled graphic
generatePlot <- function(feb2power) {
    par(mfrow = c(2, 2))
    ## global active power
    with(feb2power, plot(Date, Global_active_power, ylab="Global Active Power", xlab="", type="l"))

    ## voltage
    with(feb2power, plot(Date, Voltage, ylab="Voltage", xlab="datetime", type="l"))

    ## energy sub metering
    with(feb2power, plot(Date, Sub_metering_1, ylab="Energy sub metering", xlab="", type="n"))
    with(feb2power, lines(Date, Sub_metering_1, col="black"))
    with(feb2power, lines(Date, Sub_metering_2, col="red"))
    with(feb2power, lines(Date, Sub_metering_3, col="blue"))
    legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1), bty = "n")

    ## global reactive power
    with(feb2power, plot(Date, Global_reactive_power, ylab="Global_reactive_power", xlab="datetime", type="l"))
}

## plot to the screen
generatePlot(feb2power)

## write to png; default resolution is 480x480
png("plot4.png")
generatePlot(feb2power)
dev.off()

