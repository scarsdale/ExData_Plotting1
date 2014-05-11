if (!exists("householdpower")) {
  source("getdata.R")
}
if (!exists("make.png")) {
  source("makepng.R")
}
if (!exists("plot2")) {
  source("plot2.R")
}
if (!exists("plot3")) {
  source("plot3.R")
}
## line plot of global reactive power over time
plot4b <- function(dat=NULL) {
  if (is.null(dat)) {
    dat <- householdpower$dates("20070201", "20070203")
  }
  with(dat, plot(datetime, Global_reactive_power, main="", type="l"))
}
## line plot of voltage over time
plot4a <- function(dat=NULL) {
  with(dat, plot(datetime, Voltage, main="", type="l"))
}
## four plots in a 2x2 table, clockwise from upper left:
## global active power over time (same as plot 2)
## voltage over time (plot 4a)
## submetering over time (same as plot 3)
## global reactive power over time (plot 4b)
plot4 <- function(dat=NULL) {
  if (is.null(dat)) {
    dat <- householdpower$dates("20070201", "20070203")
  }
  par(mfrow=c(2,2))
  plot2(dat)
  plot4a(dat)
  plot3(dat, bty="n")
  plot4b(dat)
}
plot4png <- function() {
  make.png("plot4", plot4)
}
