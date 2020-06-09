
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


SCC1 <- SCC %>% filter(grepl("vehicle", SCC.Level.One, ignore.case = TRUE) | grepl("vehicle", SCC.Level.Two, ignore.case = TRUE) |
                           grepl("vehicle", SCC.Level.Three, ignore.case = TRUE) | grepl("vehicle", SCC.Level.Four, ignore.case = TRUE)) %>%
    select(SCC)

NEI1 <- NEI %>% filter(fips == "24510" & SCC %in% as.vector(SCC1[,"SCC"])) %>% mutate(year = factor(year), type = factor(type)) %>% 
    select(4:6) %>% arrange(year, type) %>% group_by(year,type) %>% summarise(Emissions = sum(Emissions, na.rm = TRUE))

dev.cur()
png("./output/plot5.png", height = 520, width = 520)
ggplot(NEI1, aes(year, Emissions, fill = type)) + geom_col() + theme_bw() +
    labs(x = "Year", title = "Emissions from motor vehicle sources", subtitle = "1999–2008, Baltimore City")
dev.off()


## by type
dev.cur()
png("./output/plot5_1.png", height = 520, width = 520)
ggplot(NEI1, aes(year, Emissions, fill = type)) + geom_col() + facet_grid(.~type) + guides(fill = FALSE) + theme_bw() +
    labs(x = "Year", title = "Emissions from motor vehicle sources", subtitle = "1999–2008, Baltimore City")
dev.off()

