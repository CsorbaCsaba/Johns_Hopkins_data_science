
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

Baltimore <- NEI %>% filter(fips == "24510" & SCC %in% as.vector(SCC1[,"SCC"])) %>%
    mutate(year = factor(year), type = factor(type), city = "Baltimore City") %>% 
    select(4:7) %>% arrange(year, type) %>% group_by(year,type,city) %>% summarise(Emissions = sum(Emissions, na.rm = TRUE))

LAcounty <- NEI %>% filter(fips == "06037" & SCC %in% as.vector(SCC1[,"SCC"])) %>%
    mutate(year = factor(year), type = factor(type), city = "Los Angeles") %>% 
    select(4:7) %>% arrange(year, type) %>% group_by(year,type,city) %>% summarise(Emissions = sum(Emissions, na.rm = TRUE))

bc_and_la <- rbind(Baltimore, LAcounty)
head(bc_and_la,20)


dev.cur()
png("./output/plot6.png", height = 520, width = 520)
ggplot(bc_and_la, aes(year, Emissions, fill = city)) + geom_col(aes(fill = year)) + facet_grid(.~city) + guides(fill = FALSE) + theme_bw() +
    labs(x = "Year", title = "Emissions from motor vehicle sources", subtitle = "1999–2008, Baltimore City vs. Los Angeles")
dev.off()









