# Load required libraries

library(lubridate) # for data parsing

## Calculating required memory

rowsn <- 2075259
colsn <- 9
reqmem <- rowsn*colsn*8/2^(20)
writeLines("The required memory in Mb is ...")
print(reqmem)

## Loading files

writeLines("Loading whole dataset ...")
wdataset <- read.table("household_power_consumption.txt", header=TRUE, as.is=TRUE, sep=";", quote='\"', stringsAsFactors=F, na.strings="?")
head(wdataset)
writeLines("Subset first two days of February 2007")
dataset <- subset(wdataset, dmy(Date) > "2007-02-01" & dmy(Date) < "2007-02-03")

## Setup device

png(filename = "Plot1.png", width = 480, height = 480, units = "px")

# plot data
hist(x = dataset$Global_active_power, xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red", main = "Global Active Power")
dev.off()