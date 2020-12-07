rfilename <- "exdata_data_household_power_consumption.zip"

# Checking if file exists.
if (!file.exists(rfilename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, rfilename)
}  

# Checking if folder exists
if (!file.exists("Household_power_consumption.txt")) { 
  unzip(rfilename) 
}

#time to get data from february first, 2007 to february second, 2007
energyt <- read.table("Household_power_consumption.txt",skip=1,sep=";")
names(energyt) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
energy <- subset(energyt,energyt$Date=="1/2/2007" | energyt$Date =="2/2/2007")
energyt <- c(1,1)

#time to plot graph #3
energy$Date <- as.Date(energy$Date, format="%d/%m/%Y")
energy$Time <- strptime(energy$Time, format="%H:%M:%S")
energy[1:1440,"Time"] <- format(energy[1:1440,"Time"],"2007-02-01 %H:%M:%S")
energy[1441:2880,"Time"] <- format(energy[1441:2880,"Time"],"2007-02-02 %H:%M:%S")
energy$Global_active_power <- as.numeric(energy$Global_active_power)
energy$Sub_metering_1 <- as.numeric(energy$Sub_metering_1)
energy$Sub_metering_2 <- as.numeric(energy$Sub_metering_2)
energy$Sub_metering_3 <- as.numeric(energy$Sub_metering_3)

with(energy,plot(Time,Sub_metering_1,type="n",xlab="",ylab="Energy sub metering"))
with(energy,lines(Time,Sub_metering_1))
with(energy,lines(Time,Sub_metering_2,col="red"))
with(energy,lines(Time,Sub_metering_3,col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Copy my plot to a PNG file
dev.copy(png, file = "plot3.png")  
dev.off()