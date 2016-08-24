
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

png("plot2.png",width = 480, height = 480)
plot(file_data$datetime, file_data$Global_active_power, type="l",
      ylab = "Global Active Power (kilowatts)", xlab ="")
dev.off()



