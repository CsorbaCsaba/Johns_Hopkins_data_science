library(dplyr)
library(tidyr)
#library(Hmisc)
#library(plyr)
#library(reshape2)


# Set up the working directory
RFile <- file.choose() # select this .R file from the explorer
wd  <- dirname(RFile) # get the name of the directory
setwd(wd)
getwd()
dir()
if(!file.exists("./Data")) {dir.create("./Data")}


#1
#Create a logical vector that identifies the households on 
#greater than 10 acres who sold more than $10,000 worth of 
#agriculture products. Assign that logical vector to the 
#variable agricultureLogical. Apply the which() function 
#like this to identify the rows of the data frame where 
#the logical vector is TRUE. which(agricultureLogical)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl,destfile = "./Data/housing.csv")

df <- read.csv("./Data/housing.csv")
agricultureLogical <-df$ACR==3 & df$AGS==6
head(which(agricultureLogical))



#2
#Using the jpeg package read in the following picture of 
#your instructor into R
#Use the parameter native=TRUE. What are the 30th and 80th 
#quantiles of the resulting data?
# install.packages('jpeg')
library(jpeg)

# Download the file
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg'
              , './Data/jeff.jpg'
              , mode='wb' )
# Read the image
picture <- jpeg::readJPEG('./Data/jeff.jpg'
                          , native=TRUE)
# Get Sample Quantiles corressponding to given prob
quantile(picture, probs = c(0.3, 0.8) )



#3
#Match the data based on the country shortcode. 
#How many of the IDs match? Sort the data frame in 
#descending order by GDP rank. What is the 13th country 
#in the resulting data frame?

library(data.table)
fileUrL1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrL1,destfile = "./Data/gdp.csv")
fileUrL2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrL2,destfile = "./Data/country.csv")

# Download data and read FGDP data into data.table
FGDP <- data.table::fread("./Data/gdp.csv"
                          , skip=4
                          , nrows = 190
                          , select = c(1, 2, 4, 5)
                          , col.names=c("CountryCode", "Rank", "Economy", "Total")
)
head(FGDP)
# Download data and read FGDP data into data.table
FEDSTATS_Country <- data.table::fread("./Data/country.csv")
head(FEDSTATS_Country)

mergedDT <- merge(FGDP, FEDSTATS_Country, by = 'CountryCode')
str(mergedDT)
# How many of the IDs match?
nrow(mergedDT)

# Sort the data frame in descending order by GDP rank (so United States is last). 
# What is the 13th country in the resulting data frame?
mergedDT[order(-Rank)][13,.(Economy)]

mergedDT$Rank2 <- as.numeric(mergedDT$Rank)


#4
#What is the average GDP ranking for the "High income: OECD" 
#and "High income: nonOECD" group?
# "High income: OECD" 
mergedDT[`Income Group` == "High income: OECD"
         , lapply(.SD, mean)
         , .SDcols = c("Rank2")
         , by = "Income Group"]

# "High income: nonOECD"
mergedDT[`Income Group` == "High income: nonOECD"
         , lapply(.SD, mean)
         , .SDcols = c("Rank2")
         , by = "Income Group"]



#5
#Cut the GDP ranking into 5 separate quantile groups. 
#Make a table versus Income.Group. How many countries 
#are Lower middle income but among the 38 nations with 
#highest GDP?
library('dplyr')

breaks <- quantile(mergedDT[, Rank], 
                   probs = seq(0, 1, 0.2), 
                   na.rm = TRUE)
mergedDT$quantileGDP <- cut(mergedDT[, Rank], 
                            breaks = breaks)
mergedDT[`Income Group` == "Lower middle income", 
         .N, by = c("Income Group", "quantileGDP")]






