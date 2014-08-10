## Common code used for all four plots is contained in this common file. It 
## performs the following common functions :
##      1. Download data ("household_power_consumption.zip") from cloudfront site
##      2. Unzip as "household_power_consumption.txt" file
##      3. Load the filtered data for dates '2007-02-01' and '2007-02-02'

loadtidydata <- function() {
        
        ## if file does not exist, download file from the cloudfront site
        zipfile <- file.path(getwd(), "household_power_consumption.zip")
        if (!file.exists(zipfile)) {
                url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                
                download.file(url, zipfile, method="curl")
                dateDownloaded <- date()
        
                ## unzip file, saves as 'household_power_consumption.txt'
                f <- unzip(zipfile)
        } else {
                ## if file exists, get file path
                f <- file.path(getwd(), "household_power_consumption.txt")
        }

        set.seed(10)

        ## to get a subset of the data based on dates 2007-02-01 and 2007-02-02 
        ## using read.table, we need to 
        ## 1. store columns names in a temp variable
        ## 2. calculate number of rows to skip, so that 1st row starts from 2007-02-01
        ## 3. calculate number of rows to read, so that final row ends on 2007-02-02

        ## 1. to store column names, create tmp table, with just 1 row
        tmp <- read.table(f, sep=";", header=T, nrow=1)
        columns <- colnames(tmp)
        
        ## 2. calculate number of rows to skip, based on first row information
        sttime = strptime('16/12/2006 17:24:00',format='%d/%m/%Y %H:%M:%S')
        endtime <- strptime('01/02/2007 00:00:00',format='%d/%m/%Y %H:%M:%S')
        dftime <- difftime(endtime, sttime, units="mins")
        skiprows <- as.numeric(dftime)
        
        ## 3. calculate number of rows to read, based on date below 2007-02-03
        sttime = strptime('01/02/2007 00:00:00',format='%d/%m/%Y %H:%M:%S')
        endtime <- strptime('03/02/2007 00:00:00',format='%d/%m/%Y %H:%M:%S')
        dftime <- difftime(endtime, sttime, units="mins")
        numrows <- as.numeric(dftime)

        ## load data filtered by the date that is of interest to us.
        df <- read.table(f, sep=";", header=T, skip=skiprows, nrow=numrows, 
                         na.strings="?")
        
        ## set the column names back
        names(df) <- columns

        ## return the data.frame
        df
}