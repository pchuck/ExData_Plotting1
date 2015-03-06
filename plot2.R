#! /usr/bin/env Rscript
##
##   generate global active power level line graph
##

## read the data file
power = read.csv("data/household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE)

## extract only data from 2007-02-{01,02}
feb2power = subset(power, Date == "1/2/2007" | Date == "2/2/2007")

## convert to numerics and combine date/time into a single column
feb2power$Global_active_power = as.numeric(feb2power$Global_active_power)
feb2power$Date = strptime(paste(feb2power$Date, feb2power$Time), format="%d/%m/%Y %H:%M:%S")

## generate a plot (screen)
with(feb2power, plot(Date, Global_active_power, ylab="Global Active Power (kilowatts)", xlab="", type="l"))

## write to png; default resolution is 480x480
png("plot2.png")
with(feb2power, plot(Date, Global_active_power, ylab="Global Active Power (kilowatts)", xlab="", type="l"))
dev.off()

