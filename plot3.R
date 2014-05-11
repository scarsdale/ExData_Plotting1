if (!exists("householdpower")) {
  source("getdata.R")
}
if (!exists("make.png")) {
  source("makepng.R")
}
## a line graph of submetering (3 variables) from 1 Feb to 2 Feb 2007
plot3 <- function(dat=NULL) {
  if (is.null(dat)) {
    dat <- householdpower$dates("20070201", "20070203")
  }
  submetering <- c("Sub_metering_1",
                   "Sub_metering_2",
                   "Sub_metering_3")
  colors = c("black", "red", "blue")
  plot(dat$datetime,
       dat[[submetering[1]]],
       ylab="Energy sub metering",
       xlab="",      
       main="",
       type="l",
       col=colors[1]
       )
  lines(dat$datetime, dat[[submetering[2]]], col=colors[2])
  lines(dat$datetime, dat[[submetering[3]]], col=colors[3])
  legend("topright", submetering, col=colors, lty=rep(1, 3))
}
plot3png <- function() {
  make.png("plot3", plot3)
}
