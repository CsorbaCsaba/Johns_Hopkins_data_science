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


head(restData)
summary(restData)
str(restData)
quantile(restData$councilDistrict, na.rm = TRUE)
quantile(restData$councilDistrict, probs = c(0.5,0.75,0.9))
table(restData$zipCode,useNA = "ifany")
table(restData$councilDistrict, restData$zipCode, useNA = "ifany")
sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))
all(restData$zipCode > 0)
sapply(restData, function(x) sum(is.na(x)))
colSums(is.na(restData))
all(colSums(is.na(restData[,1:6]))==0)
table(restData$zipCode %in% c("21212"))
table(restData$zipCode %in% c("21212","21213"))

restData[restData$zipCode %in% c("21212","21213"),]


data("UCBAdmissions")
df = as.data.frame(UCBAdmissions)
summary(df)

crossTab <- xtabs(Freq ~ Gender + Admit,data = df)
crossTab



data("warpbreaks")
xt2 <- xtabs(breaks ~.,data = warpbreaks)
xt2


data("warpbreaks")
warpbreaks$replicate <- rep(1:9,len=54)
head(warpbreaks)
xt <- xtabs(breaks ~.,data = warpbreaks)
xt
ftable(xt)




print(object.size("./Data/restaurants.csv"),
      units="auto",
      standard = "SI")
print(object.size("./Data/restaurants.csv"),
      units="kB",
      standard = "SI")