x <- c(1,3,5,8,25,100)
seq(along=x)



# Set up the working directory
RFile <- file.choose() # select this .R file from the explorer
wd  <- dirname(RFile) # get the name of the directory
setwd(wd)
getwd()
dir()


if(!file.exists("./Data")) {dir.create("./Data")}
#dir("./Data")
fileURL <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileURL,destfile = "./Data/restaurants.csv")
restData <- read.csv("./Data/restaurants.csv")


#ha táblába akarunk új oszlopot, akkor így
restData$nearMe = restData$neighborhood %in% c("Roland Park","Homeland")
# most a nearMe oszlopot hoztuk létre
table(restData$nearMe)

restData$zipWrong = ifelse(restData$zipCode < 0, TRUE, FALSE)
# most a zipWrong oszlopot hoztuk létre
table(restData$zipWrong)
table(restData$zipWrong, restData$zipCode < 0)


#categorical variables
restData$zipGroup = cut(restData$zipCode, 
                        breaks = quantile(restData$zipCode))
table(restData$zipGroup)
table(restData$zipGroup,restData$zipCode)


library(Hmisc)
restData$zipGroups = cut2(restData$zipCode, g=4)
table(restData$zipGroups)


#factor
restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]


yesno <- sample(c("yes","no"),size = 10,replace = TRUE)
yesnofac = factor(yesno, levels = c("yes","no"))
yesnofac
relevel(yesnofac,ref = "yes")

as.numeric(yesnofac)



library(Hmisc)
library(plyr)
restData2 <- mutate(restData,zipGroups=cut2(zipCode,g=4))
table(restData2$zipGroups)

