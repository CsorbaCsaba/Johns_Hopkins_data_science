
library(dplyr)
library(data.table)

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

## 1. using dplyr to get the plotable dataset
NEI2 <- NEI %>% select(Emissions, year) %>% arrange(year) %>% group_by(year) %>% summarise(Emissions = sum(Emissions, na.rm = TRUE))

png("./output/plot1.png", width = 520, height = 520)

with(NEI2, barplot(Emissions, names = year, xlab = "Years", ylab = "Emissions",
                          main = "Emissions by year (using dplyr)", col = year, lines(Emissions, lwd = 2)))

dev.off()





## 2. using aggregate function
NEI3 <- aggregate(NEI$Emissions, by = NEI["year"], sum)
NEI3
with(NEI3, barplot(x, names = year, xlab = "Years", ylab = "Emissions",
                   main = "Emissions by year (using aggregate func)", col = year))

## 3 using data.table
NEI4 <- as.data.table(NEI)
head(NEI4)
NEI_to_plot <- NEI4[, lapply(.SD, sum, na.rm = TRUE), by = year, .SDcols = "Emissions"]
with(NEI_to_plot, barplot(Emissions, names = year, xlab = "Years", ylab = "Emissions",
                          main = "Emissions by year (using data.table)", col = year))





