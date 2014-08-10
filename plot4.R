## Common code used for all the plots is contained a single common file named
## "loadtidydata.R". It performs the following common functions :
##      1. Download data ("household_power_consumption.zip") from cloudfront site
##      2. Unzip as "household_power_consumption.txt" file
##      3. Load the filtered data for dates '2007-02-01' and '2007-02-02'

## source "loadtidydata.R"
source("loadtidydata.R")

## call loadtidydata() function
df <- loadtidydata()

## Add new DateTime variable concatenating Date and Time provided
df$DateTime <- strptime(paste(df$Date,df$Time), "%d/%m/%Y %H:%M:%S")

## plot the fourth png
png("plot4.png", width = 480, height = 480, units = "px")

## for multi-plot graph, use par() function
par(mfrow=c(2,2), mar=c(4,4,2,1))

## plot 1
plot (df$DateTime, df$Global_active_power, type="l", xlab="",
      ylab="Global Active Power (kilowatts)")
## plot 2
plot(df$DateTime, df$Voltage, type="l", xlab="datetime", ylab="Voltage")
## plot 3
plot (df$DateTime, df$Sub_metering_1, type="l", xlab="",
      ylab="Energy sub metering")
lines(df$DateTime, df$Sub_metering_2, col="red")
lines(df$DateTime, df$Sub_metering_3, col="blue")
legend("topright", lty="solid", bty="n", col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
## plot 4
plot (df$DateTime, df$Global_reactive_power, type="l", xlab="datetime", 
      ylab="Global_reactive_power")
dev.off()
