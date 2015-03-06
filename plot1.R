#! /usr/bin/env Rscript
##

## read the data file
power = read.csv("data/household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE)

## extract only data from 2007-02-{01,02}
feb2power = subset(power, Date == "1/2/2007" | Date == "2/2/2007")

## convert to numeric
global.active.power = as.numeric(feb2power$Global_active_power)

## generate a histogram (screen)
hist(global.active.power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

## write to png; default resolution is 480x480
png("plot1.png")
hist(global.active.power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()

