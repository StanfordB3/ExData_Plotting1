####  Section I: Download Data from University of California, Irvine Repository
if (!file.exists("household_power_consumption.txt")) {
    # dir.create("~/RData")
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    DestFile <- "exdata household_power_consumption.zip"
    # DestFile = paste0("~/RData/", DestFile)
    download.file(fileURL, destfile = DestFile, method = "curl")
    now()
    
    # # Unzip the data file to the local direcotory
    unzip(DestFile)
}


#### Section II: R Libraries 
library(dplyr)
library(lubridate)
library(stringr)

### ReadFile "household_power_consumption.txt" 
currentFile <- "./household_power_consumption.txt"
hPower <- read.csv(currentFile, header = TRUE, sep = ";")

### Translate charactere "Date" and "Time" column in to proper "R" dates
hPwr <- mutate(hPower, dmy_hms(paste(Date, Time)))
colnames(hPwr)[colnames(hPwr)=="dmy_hms(paste(Date, Time))"] <- "Date_Time"

hPwr2 <- filter(hPwr, Date == "1/2/2007" | Date == "2/2/2007")

# Open "png" device to write the charts to plot4.png
#   png(filename = "plot3.png", width = 480, height = 480, units = "px")

## set parameters
par(mar = c(3, 4,1,1), cex.lab = 1, cex = 0.5, mfrow = c(1, 1), mfcol = c(1, 1))
plot(hPwr2$Date_Time, hPwr2$Sub_metering_1, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(hPwr2$Date_Time, hPwr2$Sub_metering_1, col = "black")
# The data for Sub_metering_2 is different than the Dr. Peng's example
lines(hPwr2$Date_Time, hPwr2$Sub_metering_2, col = "red") 
lines(hPwr2$Date_Time, hPwr2$Sub_metering_3, col="blue")

## Paint the legend
legend("topright", lty = c(1, 1, 1), col = c("gray", "blue", "red"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# dev.off()
