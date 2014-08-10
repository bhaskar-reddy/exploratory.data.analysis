## Common code used for all the plots is contained a single common file named
## "loadtidydata.R". It performs the following common functions :
##      1. Download data ("household_power_consumption.zip") from cloudfront site
##      2. Unzip as "household_power_consumption.txt" file
##      3. Load the filtered data for dates '2007-02-01' and '2007-02-02'

## source "loadtidydata.R"
source("loadtidydata.R")

## call loadtidydata() function
df <- loadtidydata()

## plot the first png
png("plot1.png", width = 480, height = 480, units = "px")
hist(df$Global_active_power, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")
dev.off()
