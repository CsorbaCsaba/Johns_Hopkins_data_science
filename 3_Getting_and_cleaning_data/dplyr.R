library(dplyr)

# Set up the working directory
RFile <- file.choose() # select this .R file from the explorer
wd  <- dirname(RFile) # get the name of the directory
setwd(wd)
getwd()
dir()

chicago <- readRDS("./Data/chicago.rds")
str(chicago)

# select
names(chicago)
head(select(chicago,city:dptp))
head(select(chicago,-(city:dptp)))

# ez basic R-ben így nézne ki
i <- match("city",names(chicago))
j <- match("dptp",names(chicago))
head(chicago[,-(i:j)])

#filter
chic.f <- filter(chicago, pm25tmean2 > 30)
head(chic.f)

chic.f <- filter(chicago, pm25tmean2 > 30 &
                     tmpd > 80)
head(chic.f)


#arrange
chicago <- arrange(chicago, date)
head(chicago)

chicago <- arrange(chicago, desc(date))
head(chicago)


#rename
chicago <- rename(chicago, 
                  pm25 = pm25tmean2, 
                  dewpoint = dptp)
head(chicago)


#mutate
chicago <- mutate(chicago, 
                  pm25detrend = pm25-mean(pm25, 
                                          na.rm = TRUE))
head(chicago)
head(select(chicago, pm25, pm25detrend))


chicago <- mutate(chicago, 
                  tempcat = factor(1 * (tmpd > 80),
                  labels = c("cold","hot")))
head(select(chicago, tempcat))
hotcold <- group_by(chicago, tempcat)
head(hotcold)

summarize(hotcold, pm25=mean(pm25),
          o3=max(o3tmean2),
          no2=median(no2tmean2))
 
summarize(hotcold, pm25=mean(pm25, na.rm = TRUE),
          o3=max(o3tmean2),
          no2=median(no2tmean2))



chicago %>% mutate(month=as.POSIXlt(date)$mon+1) %>%
    group_by(month) %>% summarize(pm25=mean(pm25,
                                            na.rm = TRUE),
                                  o3 = max(o3tmean2),
                                  no2=median(no2tmean2))
head(chicago)













