
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

png("plot3.png",width = 480, height = 480)
plot(file_data$datetime, file_data$Sub_metering_1, type="l",
      ylab = "Energy sub metering", xlab ="", col="black")
points(file_data$datetime, file_data$Sub_metering_2, type="l", col="red")
points(file_data$datetime, file_data$Sub_metering_3, type="l", col="blue")
legend("topright", lty=1 ,col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()



