# Set up the working directory
RFile <- file.choose() # select this .R file from the explorer
wd  <- dirname(RFile) # get the name of the directory
setwd(wd)
getwd()
dir()


if(!file.exists("./Data")) {dir.create("./Data")}

fileURL1 = "https://raw.githubusercontent.com/jtleek/dataanalysis/master/week2/007summarizingData/data/reviews.csv"
fileURL2 = "https://raw.githubusercontent.com/jtleek/dataanalysis/master/week2/007summarizingData/data/solutions.csv"
download.file(fileURL1, destfile="./Data/reviews.csv")
download.file(fileURL2, destfile = "./Data/solutions.csv")

reviews <- read.csv("./Data/reviews.csv")
solutions <- read.csv("./Data/solutions.csv")
head(reviews)
head(solutions)

names(reviews)
names(solutions)

mergedData <- merge(reviews,
                    solutions,
                    by.x = "solution_id",
                    by.y = "id",
                    all = TRUE)
head(mergedData)


# default - merge all common column names
# ne nagyon használd
intersect(names(reviews),names(solutions))
mergedData2 <- merge(reviews, solutions, all = TRUE)
head(mergedData2)


# join
# nem használható mindenre, id alapján kulcsol
library(plyr)
df1 <- data.frame(id=sample(1:10),x=rnorm(10))
df2 <- data.frame(id=sample(1:10),y=rnorm(10))
arrange(join(df1,df2),id)


df1 <- data.frame(id=sample(1:10),x=rnorm(10))
df2 <- data.frame(id=sample(1:10),y=rnorm(10))
df3 <- data.frame(id=sample(1:10),z=rnorm(10))
dfList <- list(df1,df2,df3)
join_all(dfList)
arrange(join_all(dfList),id)






