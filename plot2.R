rfilename <- "exdata_data_household_power_consumption.zip"

# Checking if archieve exists.
if (!file.exists(rfilename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, rfilename)
}  

# Checking if folder exists
if (!file.exists("Household_power_consumption.txt")) { 
  unzip(rfilename) 
}

#time to get data from febreary first, 2007 to febreary second, 2007
energyt <- read.table("Household_power_consumption.txt",skip=1,sep=";")
names(energyt) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
energy <- subset(energyt,energyt$Date=="1/2/2007" | energyt$Date =="2/2/2007")
energyt <- c(1,1)

#time to plot graph #2
energy$Date <- as.Date(energy$Date, format="%d/%m/%Y")
energy$Time <- strptime(energy$Time, format="%H:%M:%S")
energy[1:1440,"Time"] <- format(energy[1:1440,"Time"],"2007-02-01 %H:%M:%S")
energy[1441:2880,"Time"] <- format(energy[1441:2880,"Time"],"2007-02-02 %H:%M:%S")
energy$Global_active_power <- as.numeric(energy$Global_active_power)

with(energy,plot(Time,Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)"))
title(main="Global Active Power Vs Time")

# Copy my plot to a PNG file
dev.copy(png, file = "plot2.png")  
dev.off()