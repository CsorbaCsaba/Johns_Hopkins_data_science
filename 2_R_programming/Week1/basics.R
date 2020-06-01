## basic

getwd() #get working directory
Rfile <- file.choose()
wd <- dirname(Rfile)
setwd(wd)
dir()


source("myFunction.R")
ls()
myfunction()
second(4)
second(4:10)
