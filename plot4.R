## 1.06.16 jpatton
## week1 assignment for Exploratory Data Analysis
## plot4.R
library(lubridate)
library(dplyr)

if (!file.exists("data")) {
  dir.create("data")
}
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile = "./data/household_power_consumption.zip")
unzip("./data/household_power_consumption.zip", exdir = "./data")
powerdata <- read.table("./data/household_power_consumption.txt", sep=";", header = TRUE, 
                        stringsAsFactors = FALSE, na.strings = "?",
                        colClasses = c("character", "character", "numeric", "numeric", 
                                       "numeric", "numeric", "numeric", "numeric", "numeric"))

## subset to get 02-01-2007 and 02-02-2007 rows only.
pwr_subset <- powerdata[which(grepl("^[1|2]/2/2007", powerdata$Date)),]

## convert to a data.table
dt_pwr_subset <- tbl_df(pwr_subset)

## add a column with date and time character concatenated
## convert char to date class (POSIXct)
dt_pwr_subset <- mutate(dt_pwr_subset, DateTime = paste(dt_pwr_subset$Date, dt_pwr_subset$Time))
dt_pwr_subset$DateTime <- dmy_hms(dt_pwr_subset$DateTime)

## open the graphics device
## x,y plot with line data, the POSIXct is smart enough to label the x-axis for me!
## to add extra data sets on same axis, use lines() or points()
png(file = "./plot4.png", width = 480, height = 480, pointsize = 12, bg = "white", 
    type = "windows")

par(mfrow = c(2,2))

## plot upper left (1,1)
## x,y plot with line data, the POSIXct is smart enough to label the x-axis for me!
plot(dt_pwr_subset$DateTime, dt_pwr_subset$Global_active_power, type = "l", xlab = "", 
     ylab = "Global Active Power")

## plot upper right (1,2)
with(dt_pwr_subset, plot(DateTime, Voltage, type = "l"))

## plot upper right (2,1)
with(dt_pwr_subset, plot(DateTime, Sub_metering_1, type = "l", xlab = "", 
                         ylab = "Energy sub metering"))
with(dt_pwr_subset, lines(DateTime, Sub_metering_2, type = "l", col = "red"))
with(dt_pwr_subset, lines(DateTime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n")

## plot lower right (2,2)
with(dt_pwr_subset, plot(DateTime, Global_reactive_power, type = "l"))
dev.off()