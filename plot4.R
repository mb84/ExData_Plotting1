# Load required libraries

library(lubridate) # for data parsing
library(dplyr) # for data handling

## Calculating required memory

rowsn <- 2075259
colsn <- 9
reqmem <- rowsn*colsn*8/2^(20)
writeLines("The required memory in Mb is ...")
print(reqmem)

## Loading files

writeLines("Loading whole dataset ...")
wdataset <- read.csv("household_power_consumption.txt", header=TRUE, sep=";", quote='\"', comment.char="", stringsAsFactors=F, na.strings="?")
wdataset <- mutate(wdataset, dtime = paste(Date, Time, sep = " "))
wdataset$dtime <- dmy_hms(wdataset$dtime)
writeLines("Subset first two days of February 2007")

dataset <- subset(wdataset, dmy(Date) > "2007-02-01" & dmy(Date) < "2007-02-03") # subsetting the dataset

## Setup device
png(filename = "Plot4.png", width = 480, height = 480, units = "px")

## Create plot
Sys.setlocale("LC_TIME", "English") # setting english local time

par(mfrow = c(2,2)) # creating multiple base plots

# plotting first plot
plot(dataset$Global_active_power~dataset$dtime,   ylab = "Global Active Power", type="l", xlab ="")

# plotting second plot
plot(dataset$Voltage~dataset$dtime,   ylab = "Voltage", type="l", xlab ="datetime")

# plotting 3rd plot
plot(dataset$Sub_metering_1~dataset$dtime, type="n", ylab="Energy sub metering", xlab="")

# annotation 
points(dataset$Sub_metering_1~dataset$dtime, col="black", type="l")
points(dataset$Sub_metering_2~dataset$dtime, col="red", type="l")
points(dataset$Sub_metering_3~dataset$dtime, col="blue", type="l")
legend("topright", col = c("black", "red", "blue"), bty = "n", legend = c ("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, border = FALSE)

# plotting 4th plot
plot(dataset$Global_reactive_power~dataset$dtime,  ylab = "Global_reactive_power", type="l", xlab ="datetime" )

dev.off()