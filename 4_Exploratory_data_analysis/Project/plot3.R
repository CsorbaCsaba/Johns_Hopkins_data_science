
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

head(NEI)
str(NEI)
summary(NEI$Emissions)
table(NEI$type)

NEI2 <- NEI %>% filter(fips == "24510") %>%
    mutate(year = factor(year), type = factor(type, labels = c("ON-ROAD","NON-ROAD","POINT","NONPOINT"))) %>%
    select(4:6) %>% arrange(year, type) %>% group_by(year, type) %>%
    summarise(Emissions = sum(Emissions, na.rm = TRUE)) %>% arrange(year, type)

minEmissions <- NEI2 %>% group_by(type) %>% summarise(minEm = min(Emissions))

dev.cur()
png("./output/plot3.png", height = 520, width = 520)
ggplot(NEI2, aes(year, Emissions)) + geom_col(aes(fill = type)) + facet_grid(.~type) +
    guides(fill=FALSE) + theme_bw() +
    #geom_line(mapping = aes(year, Emissions)) +
    geom_hline(data = minEmissions, aes(yintercept = minEm)) +
    labs(x="Year", title = "Emissions in tons", subtitles = "Baltimore City 1999-2008",
         caption = "The horizontal line is the minimum Emissions by Type to help to compare")

dev.off()




