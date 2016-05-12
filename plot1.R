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

GlobalActive <- as.numeric(as.character(hPwr2$Global_active_power))

# Open "png" device to write the charts to plot4.png
#   png(filename = "plot1.png", width = 480, height = 480, units = "px")

par(mar = c(4, 4, 2, 2), mfrow = c(1, 1), mfcol = c(1,1), cex.lab = 1, cex.sub = 4)
hist(GlobalActive, col = "red", xlab = "Global Active Power (kilowatts)", main =  "Global Active Power")

dev.off()
