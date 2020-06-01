library(swirl)
swirl()
Cs
1

head(airquality)
xyplot(Ozone~Wind, data = airquality, 
       pch = 8,
       col = "red", 
       main = "Big Apple Data")

xyplot(Ozone~Wind | as.factor(Month), data = airquality, 
       layout = c(5,1))

p <- xyplot(Ozone~Wind, data = airquality)
print(p)
names(p)
mynames[myfull]
p[["formula"]]
p[["x.limits"]]


table(f)
xyplot(y ~ x | f, layout = c(2,1))
v1
v2
myedit("plot1.R")
source(pathtofile("plot1.R"),local=TRUE)

myedit("plot2.R")
source(pathtofile("plot2.R"),local=TRUE)

str(diamonds)
table(diamonds$color)
table(diamonds$color, diamonds$cut)

myedit("myLabels.R")
source(pathtofile("myLabels.R"),local=TRUE)

xyplot(price~carat | color*cut, data = diamonds, strip = FALSE,
       pch = 20, xlab = myxlab, ylab = myylab, main = mymain)

xyplot(price~carat | color*cut, data = diamonds,
       pch = 20, xlab = myxlab, ylab = myylab, main = mymain)





######################

## Working_with_Colors

######################

colors()
sample(colors(),10)
pal <- colorRamp(c("red","blue"))
pal(1)
pal(seq(0,1,len=6))
p1 <- colorRampPalette(c("red","blue"))
p1(2)
pal(seq(0,1,len=6))
p1(6)
0xcc
p2 <- colorRampPalette(c("red","yellow"))
p2(2)
p2(10)
showMe(p2(2))
p3 <- colorRampPalette(c("blue","green"),alpha=.5)
p3(5)
plot(x,y,pch=19, col=rgb(0,.5,.5,.3))

cols <- brewer.pal(3, "BuGn")
showMe(cols)
pal <- colorRampPalette(cols)
showMe(pal(20))
image(volcano, col=p1(20))

