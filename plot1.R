#clean console
cat("\014")

#clean all variables
rm(list=ls(all=TRUE))

# install required packages
if (!"ggplot2" %in% installed.packages()) install.packages("ggplot2")
if (!"dplyr" %in% installed.packages()) install.packages("dplyr")

library(ggplot2)
library(dplyr)

# download data if needed
if ( !file.exists("household_power_consumption.txt") ){ 
  download.file("https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip", "household_power_consumption.zip");
  unzip("household_power_consumption.zip",overwrite=TRUE);
}

#clean all variables
rm(list=ls(all=TRUE))

df <- read.csv2("household_power_consumption.txt",numerals="no.loss",dec = ".",colClasses =c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),na.strings = "?")
df$Date <- as.Date(df$Date,"%d/%m/%Y")
df <- df[which(df$Date %in% c(as.Date("2007-02-01"),as.Date("2007-02-02"))),]
df <- as.numeric(df$Global_active_power)

png("./plot1.png", width=500, height=500)
hist(df, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()