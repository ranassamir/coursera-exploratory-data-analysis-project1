
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

png("plot3.png", width=500, height=500)
plot(df$Datetime, df$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(df$Datetime, df$Sub_metering_2, type="l", col="red")
lines(df$Datetime, df$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()