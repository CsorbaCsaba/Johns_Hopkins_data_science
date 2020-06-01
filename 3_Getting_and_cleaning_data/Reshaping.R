library(reshape2)
head(mtcars)

mtcars$carname <- rownames(mtcars)

carMelt <- melt(mtcars, id=c("carname","gear", "cyl"), 
                             measure.vars= c("mpg","hp"))
head(carMelt)
tail(carMelt)



cylData <- dcast(carMelt, cyl ~ variable)
cylData

cylData <- dcast(carMelt, cyl ~ variable, mean)
cylData


head(InsectSprays)
#vagy 1 lépés
tapply(InsectSprays$count,InsectSprays$spray, sum)

spIns = split(InsectSprays$count, InsectSprays$spray)
spIns
spIns[1]
spIns["A"]

# vagy így 3 lépésben (spIns - sprCount - unlist)
sprCount = lapply(spIns,sum)
sprCount
unlist(sprCount)  #numeric

#vagy így 2 lépésben (spIns - sapply)
sapply(spIns,sum)

#vagy így 1 lépésben
library(plyr)
ddply(InsectSprays,.(spray),summarize, sum=sum(count))

### ha ebbõl egy új oszlopot akarunk, akkor
spraySums <- ddply(InsectSprays,
                   .(spray),
                   summarize, 
                   sum=ave(count, FUN=sum))
head(spraySums)
tail(spraySums)
