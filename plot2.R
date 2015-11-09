#clean console
cat("\014")

#clean all variables
rm(list=ls(all=TRUE))

# install required packages
if (!"ggplot2" %in% installed.packages()) install.packages("ggplot2")

library(ggplot2)

# download data if needed
if ( !file.exists("household_power_consumption.txt") ){ 
  download.file("https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip", "household_power_consumption.zip");
  unzip("household_power_consumption.zip",overwrite=TRUE);
}

df <- read.csv2("household_power_consumption.txt",numerals="no.loss",dec = ".",colClasses =c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),na.strings = "?")
#df$Global_active_power <- as.numeric(df$Global_active_power)
df$Datetime <- strptime(paste(df$Date, df$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
df$Date <- as.Date(df$Date,"%d/%m/%Y")
df <- df[which(df$Date %in% c(as.Date("2007-02-01"),as.Date("2007-02-02"))),]

png("plot2.png", width=500, height=500)
plot(df$Datetime, df$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()