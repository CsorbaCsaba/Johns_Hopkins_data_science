
library(dplyr)
library(data.table)
library(ggplot2)

R.file <- file.choose()
wd <- dirname(R.file)
setwd(wd)
dir()

source_f <- file.path(wd, "source_files")
output_dir <- file.path(wd, "output")
if (!dir.exists(output_dir)) {dir.create(output_dir)}

## check the .zip file
unzip("exdata_data_NEI_data.zip", list = TRUE)

## check if the directory exists and extract the .zip file
if (!dir.exists(source_f)) {
    dir.create(source_f)
    unzip("exdata_data_NEI_data.zip", list = FALSE, 
          overwrite = TRUE, exdir = source_f)
} else {unzip("exdata_data_NEI_data.zip", list = FALSE, 
              overwrite = TRUE, exdir = source_f)
}

## read .rds file 
NEI <- readRDS(file.path(source_f,"summarySCC_PM25.rds"))
SCC <- readRDS(file.path(source_f,"Source_Classification_Code.rds"))

head(NEI)
str(NEI)
summary(NEI$Emissions)
table(NEI$type)

head(SCC)
str(SCC)
summary(SCC)
table(SCC$SCC.Level.One)
table(SCC$SCC.Level.Four)

SCC1 <- SCC %>% filter(grepl("Combustion", SCC.Level.One, ignore.case = TRUE) | grepl("Coal", SCC.Level.Four, ignore.case = TRUE)) %>%
    select(SCC)

NEI1 <- NEI %>% filter(SCC %in% as.vector(SCC1[,"SCC"])) %>%
    mutate(year = factor(year), type = factor(type, labels = c("POINT","NONPOINT"))) %>%
    select(4:6) %>% arrange(year, type) %>% group_by(year, type) %>%
    summarise(Emissions = sum(Emissions, na.rm = TRUE)) %>% arrange(year, type)

dev.cur()
png("./output/plot4.png", height = 520, width = 520)
ggplot(NEI1, aes(year, Emissions)) + geom_col(aes(fill = type)) + theme_bw() +
    labs(x = "Year", title = "Change of coal combustion-related sources", subtitle = "1999–2008, USA")
dev.off()


## by type
dev.cur()
png("./output/plot4_1.png", height = 520, width = 520)
ggplot(NEI1, aes(year, Emissions)) + geom_col(aes(fill = type)) + facet_grid(.~type) + guides(fill = FALSE) + theme_bw() +
    labs(x = "Year", title = "Change of coal combustion-related sources", subtitle = "1999–2008, USA")
dev.off()









