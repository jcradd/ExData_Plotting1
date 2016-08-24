
file_url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zip_file_name<-"household_power_consumption.zip"
file_name<-"household_power_consumption.txt"
if(!file.exists(file_name))
{
download.file(file_url, destfile = zip_file_name) 
unzip(zip_file_name)
}
file_data<-read.table(file_name, header=T, sep=";",na.strings = "?",as.is = T)
file_data<-file_data[(file_data$Date=="1/2/2007")|(file_data$Date=="2/2/2007"), ]

library(dplyr)

file_data$datetime<-
  with(file_data, paste(Date, Time)) %>%
  strptime("%d/%m/%Y %H:%M:%S")

png("plot4.png",width = 480, height = 480)
par(mfrow=c(2,2))
### Chart 1
plot(file_data$datetime, file_data$Global_active_power, type="l",
     ylab = "Global Active Power", xlab ="", col="black")
### Chart 2
plot(file_data$datetime, file_data$Voltage, type="l",
     ylab = "Voltage", xlab ="", col="black")
### Chart 3
plot(file_data$datetime, file_data$Sub_metering_1, type="l",
      ylab = "Energy sub metering", xlab ="", col="black")
points(file_data$datetime, file_data$Sub_metering_2, type="l", col="red")
points(file_data$datetime, file_data$Sub_metering_3, type="l", col="blue")
legend("topright", lty=1, bty="n", col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
### Chart 4
plot(file_data$datetime, file_data$Global_reactive_power, type="l",
     ylab = "Global_reactive_power", xlab ="", col="black")
dev.off()



