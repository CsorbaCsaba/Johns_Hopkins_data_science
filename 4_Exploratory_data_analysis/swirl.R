library(swirl)
install_from_swirl("Exploratory Data Analysis")

swirl()
CS
1
head(pollution)
dim(pollution)

summary(pollution$pm25)
quantile(ppm)

boxplot(ppm, col="blue")
abline(h=12)

hist(ppm, col="green")
rug(ppm)

low
high

hist(ppm, col="green",breaks = 100)
rug(ppm)

hist(ppm, col = "green")
abline(v=12, lwd=2)
abline(v=median(ppm), col="magenta",lwd=4)


names(pollution)
reg <- table(pollution$region)
reg
barplot(reg, col="wheat",main = "Number of Counties in Each Region")


boxplot(pm25 ~ region, data=pollution, col="red")


par(mfrow=c(2,1),mar=c(4,4,2,1))
east <- subset(pollution, region=="east")
head(east)
hist(east$pm25, col="green")
hist(subset(pollution, region=="west")$pm25, col = "green")



with(pollution, plot(latitude, pm25))
abline(h=12, lwd=2, lty=2)

plot(pollution$latitude,ppm, col=pollution$region)
abline(h=12, lwd=2, lty=2)




par(mfrow=c(1,2),mar=c(5,4,2,1))
west <- subset(pollution, region=="west")
plot(west$latitude, west$pm25, main="West")
plot(east$latitude, east$pm25, main="East")








?Devices
with(faithful, plot(eruptions, waiting))
title("Old Faithful Geyser data")
dev.cur()

pdf(file="myplot.pdf")
with(faithful, plot(eruptions, waiting))
title("Old Faithful Geyser data")
dev.off()



#There are two basic types of file devices, vector and
#bitmap devices. These use different formats and have
#different characteristics. Vector formats are good for
#line drawings and plots with solid colors using a modest
#number of points, while bitmap formats are good for plots
#with a large number of points, natural scenes or
#web-based plots.

#We'll mention 4 specific vector formats. The first is
#pdf, which we've just used in our example. This is useful
#for line-type graphics and papers. It resizes well, is
#usually portable, but it is not efficient if a plot has
#many objects/points.

#The second is svg which is XML-based, scalable vector
#graphics. This supports animation and interactivity and
#is potentially useful for web-based plots.

#In contrast, jpeg files are good for photographs or
#natural scenes. They use lossy compression, so they're
#good for plots with many points. Files in jpeg format
#don't resize well, but they can be read by almost any
#computer and any web browser. They're not great for line
#drawings.

#The last two bitmap formats are tiff, an older lossless
#compression meta-format and bmp which is a native Windows
#bitmapped format.



dev.cur()
dev.off()
dev.set(4)

with(faithful, plot(eruptions, waiting))
title(main = "Old Faithful Geyser data")
dev.copy(png, file="geyserplot.png")
dev.off()





head(cars)
with(cars, plot(speed, dist))
text(mean(cars$speed),max(cars$dist), "SWIRL rules!")

#lattice
head(state)
table(state$region)
xyplot(Life.Exp ~ Income | region, data = state,
       layout=c(4,1))
xyplot(Life.Exp ~ Income | region, data = state,
       layout=c(2,2))

#ggplot2
head(mpg)
dim(mpg)
table(mpg$model)
qplot(displ, hwy, data = mpg)





head(airquality)
range(airquality$Ozone, na.rm = TRUE)
hist(airquality$Ozone)

table(airquality$Month)
boxplot(Ozone ~ Month, airquality)

boxplot(Ozone ~ Month, airquality, xlab = "Month", 
        ylab = "Ozone (ppb)",
        col.axis = "blue",
        col.lab = "red")

title(main="Ozone and Wind in New York City")



with(airquality, plot(Wind, Ozone))
title(main = "Ozone and Wind in New York City")

length(par())
names(par())
par()$pin
par("fg")
par("pch")
par("lty")


plot(airquality$Wind, airquality$Ozone, type = "n")
title(main = "Wind and Ozone in NYC")
may <- subset(airquality, Month == 5)
points(may$Wind,may$Ozone, col = "blue", pch=17)
notmay <- subset(airquality, Month!=5)
points(notmay$Wind, notmay$Ozone, col="red", pch=8)
legend("topright", pch=c(17,8),col=c("blue","red"),legend=c("May","Other Months"))
abline(v=median(airquality$Wind), lty=2, lwd=2)



par(mfrow=c(1,2))
plot(airquality$Wind, airquality$Ozone, main = "Ozone and Wind")
plot(airquality$Ozone, airquality$Solar.R, main = "Ozone and Solar Radiation")


par(mfrow = c(1, 3), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
plot(airquality$Wind, airquality$Ozone, main = "Ozone and Wind")
plot(airquality$Solar.R, airquality$Ozone, main = "Ozone and Solar Radiation")
plot(airquality$Temp, airquality$Ozone, main = "Ozone and Temperature")

mtext("Ozone and Weather in New York City", outer = TRUE)







########################

## GGPLOT2

########################

str(mpg)
qplot(displ, hwy, data = mpg, color = drv, 
      geom = c("point", "smooth") )

qplot(y=hwy, data = mpg, color = drv)
myhigh


qplot(drv, hwy, data = mpg, 
      geom = "boxplot",
      color = manufacturer)


qplot(hwy, data = mpg, fill = drv)


qplot(displ, hwy, data = mpg, facets = .~drv)
qplot(hwy, data = mpg, facets = drv~., 
      binwidth=2)

