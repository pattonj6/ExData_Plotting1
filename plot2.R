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

plot(dt_pwr_subset$DateTime, dt_pwr_subset$Global_active_power, type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)")

## Copy my plot to a PNG file
## Don't forget to close the PNG device!
dev.copy(png, file = "./plot2.png")
dev.off()  



dt_pwr_subset <- mutate(dt_pwr_subset, DateTime = paste(dt_pwr_subset$Date, dt_pwr_subset$Time))
dt_pwr_subset$DateTime <- dmy_hms(dt_pwr_subset$DateTime)
dt_pwr$Date <- dmy(dt_pwr$Date)

powerdata$DateTime <- as.Date(as.character(powerdata$DateTime), format = "%d/%m/%Y %H:%M:%S")

dt_powerdata$Date <- as.Date(as.character(dt_powerdata$Date), format = "%d/%m/%Y") 
dt_powerdata$Time <- as.Date((dt_powerdata$Time), format = "%H:%M:%S") 

## head(powerdata) shows Date column format is %d %m %Y
filtered_dt_powerdata <- dt_powerdata[which(dt_powerdata$Date == "01/02/2007"),]

## For each plot you should:

## Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
## Name each of the plot files as plot1.png, plot2.png, etc.
## Create a separate R code file (plot1.R, plot2.R, etc.) that constructs 
## the corresponding plot, i.e. code in plot1.R constructs the plot1.png plot. 

## Your code file should include code for reading the data so that the plot can be fully reproduced. 
## You must also include the code that creates the PNG file.

## Add the PNG file and R code file to the top-level folder of your git 
## repository (no need for separate sub-folders)

## When you are finished with the assignment, push your git repository to GitHub so that the 
## GitHub version of your repository is up to date. There should be four PNG files and four R code files, 
## a total of eight files in the top-level folder of the repo.
