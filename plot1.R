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

#time to plot graph #1
energy$Global_active_power <- as.numeric(energy$Global_active_power)
hist(energy$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)")

## Copy my plot to a PNG file
dev.copy(png, file = "plot1.png")  
dev.off()