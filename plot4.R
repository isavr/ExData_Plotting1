## check if file dir exists
dataFileName<-"household_power_consumption.txt";
	if (!file.exists(dataFileName)){
		dirName <- "household_power_consumption.zip"
		if (!file.exists("household_power_consumption.zip")){	 
			download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", dirName, mode = "wb");
		}
		unzip(dirName)
      }
require(data.table)
data<-fread(dataFileName, header=TRUE, nrows = -1,
	 na.strings=c("", "?"), stringsAsFactors=FALSE,
	 colClasses=c("character", "character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"));
badData<-is.na(data$Date);
goodData<-data[!badData];

rm(data);
rm(badData);
fl<-goodData$Date == "2/2/2007" | goodData$Date == "1/2/2007";
neededData<-goodData[fl];

rm(fl);
rm(goodData);

## Plot 4
Sys.setlocale("LC_TIME", "English") # Windows
datetime <- strptime(paste(neededData$Date, neededData$Time, sep=" "), "%d/%m/%Y %H:%M:%S", tz = "UTC")
globalActivePower <- as.numeric(neededData$Global_active_power);
subMetering1 <- as.numeric(neededData$Sub_metering_1);
subMetering2 <- as.numeric(neededData$Sub_metering_2);
subMetering3 <- as.numeric(neededData$Sub_metering_3);
voltage <- as.numeric(neededData$Voltage);
globalReactivePower <- as.numeric(neededData$Global_reactive_power);

png("plot4.png", width=480, height=480);

par(mfrow = c(2, 2))
##
	plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2);
##
	plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")
##
	plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
	lines(datetime, subMetering2, type="l", col="red")
	lines(datetime, subMetering3, type="l", col="blue")
	legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=2.5, col=c("black", "red", "blue"), bty="n")
##
	plot(datetime, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")

rm(globalActivePower);
rm(globalReactivePower);
rm(voltage);
rm(datetime);
rm(subMetering1);
rm(subMetering2);
rm(subMetering3);
dev.off();