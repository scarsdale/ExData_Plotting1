if (!exists("householdpower")) {
  source("getdata.R")
}
if (!exists("make.png")) {
  source("makepng.R")
}
## a line graph of global active power from 1 Feb to 2 Feb 2007
plot2 <- function() {
  dat <- householdpower$dates("20070201", "20070203")
  plot(dat$datetime,
       dat[["Global_active_power"]],
       ylab="Global Active Power (kilowatts)",
       xlab="",      
       main="",
       type="l",
       )
}
plot2png <- function() {
  make.png("plot2", plot2)
}
