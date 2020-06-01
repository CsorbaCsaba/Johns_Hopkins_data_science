
# Set up the working directory
RFile <- file.choose() # select this particularly .R file from the explorer
wd  <- dirname(RFile) # get the name of the directory
setwd(wd)
getwd()
dir()

pollution <- read.csv("./data/avgpm25.csv",
                      colClasses = c("numeric","character",
                                     "factor","numeric","numeric"))
head(pollution)

#five number summary
summary(pollution$pm25)

#boxplot
boxplot(pollution$pm25, col = "blue")
abline(h=12)

#histogram
hist(pollution$pm25, col = "green", breaks = 100)
rug(pollution$pm25)

hist(pollution$pm25, col = "green", breaks = 100)
abline(v=12,lwd=2)
abline(v=median(pollution$pm25), col="magenta",lwd=4)

#barplot
barplot(table(pollution$region), col="wheat",
        main = "Number of Counties in Each Region")




#Multiple boxplots
boxplot(pm25 ~ region, data=pollution, col="red")

#Multiple histograms
par(mfrow= c(2,1), mar=c(4,4,2,1))
hist(subset(pollution, region=="east")$pm25, col="green")
hist(subset(pollution, region=="west")$pm25, col="green")


#Scatterplot
with(pollution, plot(latitude, pm25, col=region))
abline(h=12,lwd=2,lty=2)

par(mfrow= c(1,2), mar=c(5,4,2,1))
with(subset(pollution, region =="east"),
     plot(latitude, pm25, main = "East"))
with(subset(pollution, region =="west"),
     plot(latitude, pm25, main = "West"))


# Lattice system - lattice plot
library(lattice)
state <- data.frame(state.x77, region = state.region)
xyplot(Life.Exp ~ Income | region, data = state,
       layout=c(4,1))



# GGPLOT system - ggplot2 Plot
library(ggplot2)





######
## BASE PLOTTING SYSTEM
library(datasets)

#histogram
hist(airquality$Ozone)

#scatterplot
with(airquality, plot(Wind, Ozone))

#boxplot
airquality <- transform(airquality, Month=factor(Month))
boxplot(Ozone ~ Month, airquality, xlab = "Month",
        ylab="Ozone (ppb)")

par("lty")
par("mfrow");par(mfrow=c(1,1))
par("bg")


library(datasets)
with(airquality, plot(Wind, Ozone))
title(main = "Ozone and Wind in New York City")


with(airquality, plot(Wind, Ozone, main="Ozone and Wind in New York City"))
with(subset(airquality, Month==5), points(Wind, Ozone, col="blue"))
with(subset(airquality, Month==6), points(Wind, Ozone, col="red"))


with(airquality, plot(Wind, Ozone, main="Ozone and Wind in New York City", type = "n"))
with(subset(airquality, Month==5), points(Wind, Ozone, col="blue"))
with(subset(airquality, Month!=5), points(Wind, Ozone, col="red"))
legend("topright", pch = 1, col = c("blue","red"), legend = c("May","Other Months"))


with(airquality, plot(Wind, Ozone, main="Ozone and Wind in New York City", pch=20))
model <- lm(Ozone ~ Wind, airquality)
abline(model, lwd=2)


par(mfrow=c(1,2))
with(airquality, {
    plot(Wind, Ozone, main="Ozone and Wind")
    plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
})



par(mfrow=c(1,3),mar=c(4,4,2,1),oma=c(0,0,2,0))
with(airquality, {
    plot(Wind, Ozone, main="Ozone and Wind")
    plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
    plot(Temp, Ozone, main="Ozone and Temperature")
    mtext("Ozone and Weather in New York City")
})





x <- rnorm(100)
hist(x)
y <- rnorm(100)
plot(x,y)
par("mar")
#az alsó rész az 1-es, a bal oldal a 2-es
# a teteje a 3-as, és a jobb oldal a 4-es

plot(x,y, pch=20)
plot(x,y, pch=19)
plot(x,y, pch=1)
plot(x,y, pch=2)
plot(x,y, pch=3)
plot(x,y, pch=17)

#0example(points)

title("Scatterplot")
text(-2,-2, "label")
legend("topleft", legend="data", pch = 17)
fit <- lm(y~x)
abline(fit, lwd = 3, col="blue")


plot(x,y, xlab="Weight",ylab = "Height",
     main = "Scatterplot", pch=2)




g <- gl(2,50, labels = c("Male","Female"))
str(g)
plot(x,y)
plot(x,y,type = "n")
points(x[g=="Male"],y[g=="Male"],col="green")
points(x[g=="Female"],y[g=="Female"],col="blue",pch=19)


library(datasets)
with(faithful, plot(eruptions, waiting)) #create a plot on screen device
title(main = "Old Faithful Geyser data") #add a main title
dev.copy(png,file = "./output/geyserplot.png") #copy my plot to png file
dev.off() #close the PNG device





