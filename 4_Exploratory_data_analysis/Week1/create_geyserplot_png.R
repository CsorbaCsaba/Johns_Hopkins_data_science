library(datasets)
with(faithful, plot(eruptions, waiting)) #create a plot on screen device
title(main = "Old Faithful Geyser data") #add a main title
dev.copy(png,file = "./output/geyserplot.png") #copy my plot to png file
dev.off() #close the PNG device