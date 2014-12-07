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

## Plot 1
globalActivePower <- as.numeric(neededData$Global_active_power);

png("plot1.png", width=480, height=480);
hist(globalActivePower, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red");
rm(globalActivePower);
dev.off();