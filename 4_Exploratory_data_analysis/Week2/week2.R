#set the working directory
Rfile <- file.choose()
wd <- dirname(Rfile)
setwd(wd)
dir()
list.files(file.path(wd, "source"))

library(lattice)
library(datasets)


# simple scatterplot
xyplot(Ozone ~ Wind, data = airquality)

#convert Month to a factor variable
airquality <- transform(airquality, Month = factor(Month))
xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(5,1))


# no auto printing
p <- xyplot(Ozone ~ Wind, data = airquality)
print(p)


# Lattice panel functions
set.seed(10)
x <- rnorm(100)
f <- rep(0:1, each = 50)
y <- x + f - f * x + rnorm(100, sd = 0.5)
f <- factor(f, labels = c("Group 1", "Group 2"))
xyplot(y ~ x | f, layout = c(2,1))


# custom panel function
xyplot(y ~ x | f, panel = function(x, y, ...) {
    panel.xyplot(x, y, ...) #first call the default panel function for xyplot
    panel.abline(h = median(y), lty = 2) ##add a horizontal line at the median
}, layout = c(2,1))


# custom panel function 2
xyplot(y ~ x | f, panel = function(x, y, ...) {
    panel.xyplot(x, y, ...) #first call the default panel function for xyplot
    panel.lmline(x, y, col = 2) ##add a simple linear regression line
}, layout = c(2,1))




##############

#       GGPLOT2

##############

library(ggplot2)
str(mpg)
mpg[,c(1,2,7)] <- lapply(mpg[,c(1,2,7)], as.factor)

#•1
qplot(displ, hwy, data = mpg)

#2
qplot(displ, hwy, data = mpg, color = drv)

#3
qplot(displ, hwy, data = mpg, geom = c("point","smooth"))

#4
qplot(hwy, data = mpg, fill = drv)

#5 Facets
qplot(displ, hwy, data = mpg, facets = . ~ drv, shape = drv, color = drv)

qplot(hwy, data = mpg, facets = drv ~ ., binwidth = 2)

qplot(displ, hwy, data = mpg, facets = .~manufacturer)













