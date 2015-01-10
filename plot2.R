# Load required libraries

library(lubridate) # for data parsing
library(dplyr) 

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
dataset <- subset(wdataset, dmy(Date) > "2007-02-01" & dmy(Date) < "2007-02-03")

## Setup device
png(filename = "Plot2.png", width = 480, height = 480, units = "px")

## Create plot
Sys.setlocale("LC_TIME", "English") # setting english local time
plot(dataset$Global_active_power~dataset$dtime, ylab = "Global Active Power (kilowatts)", type="l", xlab ="")
dev.off()