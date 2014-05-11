make.householdpower <- function() {
  zipfile <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"
  txtfile <- "household_power_consumption.txt"
  url <- paste("https://d396qusza40orc.cloudfront.net",
               data.zipfile, sep="/")
  d <- NULL
  ## download the zip file to the current working directory,
  ## if it does not already exist
  data.download <- function() {
    if (!file.exists(data.zipfile)) {
      download.file(data.url, data.zipfile, method="curl")
    }
    data.zipfile
  }
  ## unzip the zip file (downloading first if necessary),
  ## if its contents do not already exist
  data.unzip <- function() {
    if (!file.exists(data.txtfile)) {
      unzip(data.download())
    }
    data.txtfile
  }
  ## perform additional preprocessing not done by read.table()
  data.clean <- function() {
    frame <- data.read()
    frame$Date <- strptime(frame$Date, "%d/%m/%Y", tz="UTC")
    frame$Time <- strptime(frame$Time, "%H:%M:%S", tz="UTC")
    frame
  }  
  ## read the data file into a data frame,
  ## returning a memoized copy if possible
  data.read <- function() {
    if (is.null(d)) {
      d <<- read.table(data.unzip(),
                       sep=";",
                       header=TRUE,
                       na.strings="?",
                       nrows=2075259,
                       comment.char="")
    }
    d
  }
  ## return the subset of the data relevant to the given dates
  data.dates <- function(start, end) {
    daterange <- strptime(c(start, end), "%Y%m%d", tz="UTC")
    frame <- data.clean()
    pred <- !is.na(frame$Date) & (frame$Date >= daterange[1] &
                                  frame$Date <= daterange[2])
    frame[pred,]
  }
  list(dates=data.dates,
       cleaned=data.clean,
       raw=data.read)
}
householdpower <- make.householdpower()
