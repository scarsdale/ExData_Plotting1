## write the plot created by function <plotfn> to a PNG file <filename>
make.png <- function(filename, plotfn) {
  png(paste(filename, "png", sep="."), width=480, height=480)
  plotfn()
  dev.off()
}
