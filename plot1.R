if (!exists("householdpower")) {
  source("getdata.R")
}
if (!exists("make.png")) {
  source("makepng.R")
}
## a histogram of global active power from 1 Feb to 2 Feb 2007
plot1 <- function(dat=NULL) {
  if (is.null(dat)) {
    dat <- householdpower$dates("20070201", "20070203")
  }
  hist(dat[["Global_active_power"]],
       xlab="Global Active Power (kilowatts)",
       main="Global Active Power",
       col="red")
}
plot1png <- function() {
  make.png("plot1", plot1)
}
