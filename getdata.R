make.householdpower <- function() {
  zipfile <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"
  txtfile <- "household_power_consumption.txt"
  url <- paste("https://d396qusza40orc.cloudfront.net",
               data.zipfile, sep="/")
  d <- NULL
  bydaterange <- list()
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
    frame$datetime <- strptime(paste(frame$Date, frame$Time, sep=" "),
                               "%d/%m/%Y %H:%M:%S",
                               tz="UTC")
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
  ## return the subset of the data relevant to the given dates,
  ## using memoized data if possible
  data.dates <- function(start, end) {
    rangestr <- paste(start, end, sep="-")
    if (is.null(bydaterange[[rangestr]])) {
      daterange <- strptime(c(start, end), "%Y%m%d", tz="UTC")
      frame <- data.clean()
      pred <- !is.na(frame$Date) & (frame$datetime >= daterange[1] &
                                    frame$datetime <= daterange[2])
      bydaterange[[rangestr]] <<- frame[pred,]
    }
    bydaterange[[rangestr]]
  }
  list(dates=data.dates,
       cleaned=data.clean,
       raw=data.read)
}
householdpower <- make.householdpower()
