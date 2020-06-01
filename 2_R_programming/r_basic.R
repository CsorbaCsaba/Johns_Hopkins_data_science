
# Set up the working directory
RFile <- file.choose() # select this .R file from the explorer
wd  <- dirname(RFile) # get the name of the directory
setwd(wd)
getwd()
dir()

mean(mtcars$mpg)
e <- matrix(c(1,2,3,4,5,6,7,8,9),nrow = 4, ncol = 2)

print(iris$Species)

install.packages("ggplot2")
#install.packages(c("ggplot2","devtools","lme4"))

install.packages("devtools")
library(devtools)
detach("package:devtools", unload = TRUE)

old.packages()
update.packages()
y

version
sessionInfo()

# installing/loading the latest installr package:
install.packages("installr"); library(installr) # install+load installr

updateR() # updating R.


browseVignettes()
install.packages("ggplot2")
library(ggplot2)
browseVignettes("ggplot2")

install.packages("KernSmooth")
library(KernSmooth)
