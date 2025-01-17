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
#vagy 1 l�p�s
tapply(InsectSprays$count,InsectSprays$spray, sum)

spIns = split(InsectSprays$count, InsectSprays$spray)
spIns
spIns[1]
spIns["A"]

# vagy �gy 3 l�p�sben (spIns - sprCount - unlist)
sprCount = lapply(spIns,sum)
sprCount
unlist(sprCount)  #numeric

#vagy �gy 2 l�p�sben (spIns - sapply)
sapply(spIns,sum)

#vagy �gy 1 l�p�sben
library(plyr)
ddply(InsectSprays,.(spray),summarize, sum=sum(count))

### ha ebb�l egy �j oszlopot akarunk, akkor
spraySums <- ddply(InsectSprays,
                   .(spray),
                   summarize, 
                   sum=ave(count, FUN=sum))
head(spraySums)
tail(spraySums)
