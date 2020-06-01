library(datasets)
data("iris")
?iris
round(tapply(iris$Sepal.Length, iris$Species, mean),)
apply(iris[,1:4],2,mean)

data("mtcars")
?mtcars
tapply(mtcars$mpg, mtcars$cyl, mean)
with(mtcars, tapply(mpg, cyl, mean))
sapply(split(mtcars$mpg, mtcars$cyl),mean)
hp_mean <- tapply(mtcars$hp, mtcars$cyl, mean)
round(abs(hp_mean[1] - hp_mean[3]),)

debug(ls)
ls()
