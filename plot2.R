## 1.06.16 jpatton
## week1 assignment for Exploratory Data Analysis
## plot2.R
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

## x,y plot with line data, the POSIXct is smart enough to label the x-axis for me!
plot(dt_pwr_subset$DateTime, dt_pwr_subset$Global_active_power, type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)")

## Copy my plot to a PNG file
## Don't forget to close the PNG device!
dev.copy(png, file = "./plot2.png")
dev.off()