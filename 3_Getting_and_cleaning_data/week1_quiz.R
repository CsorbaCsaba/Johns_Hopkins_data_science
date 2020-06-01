# Set up the working directory
RFile <- file.choose() # select this .R file from the explorer
wd  <- dirname(RFile) # get the name of the directory
setwd(wd)
getwd()
dir()


data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(data_url, "./Data/Microdata_2006.csv")
downloadDate <- date()
df <- read.csv("./Data/Microdata_2006.csv")
head(df)

w <- df[df$VAL == 24,]
w[!is.na(w$VAL),]$VAL


library(xlsx)
library(XLConnect)
library(readxl)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile='./Data/sample.xlsx', mode='wb')

# rowIndex <- 18:23
# colIndex <- 7-15
# df2 <- read.xlsx("./Data/sample.xlsx", 
#                  sheetIndex = 1, 
#                  colIndex = colIndex,
#                  rowIndex = rowIndex)
range_x <- "R18C7:R23C15"
dat <- read_excel("./Data/sample.xlsx",1, range = range_x)
sum(dat$Zip*dat$Ext,na.rm=T)

#4
library(XML)
### remove 's' from 'https'...
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(fileUrl, useInternal=TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)
xmlSApply(rootNode, xmlValue)
rootNode[[1]][[1]][[2]]
zip <- xpathSApply(rootNode, "//zipcode",xmlValue)
zip[zip == 21231]

#5
library(data.table)
filUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl,"./Data/acs.csv")
fread("./Data/acs.csv")


