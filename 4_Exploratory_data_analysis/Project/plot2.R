
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

## selecting Baltimore City data
NEI2 <- NEI %>% filter(fips == "24510") %>% select(Emissions, year) %>% arrange(year) %>% 
    group_by(year) %>% summarize(Emissions = sum(Emissions, na.rm = TRUE))

dev.cur()
png("./output/plot2.png", height = 520, width = 520)
with(NEI2, barplot(Emissions, names = year, xlab = "Years", ylab = "Emissions", 
                   main = "Emissions in the Baltimore City over the years (using dplyr)", col = year))
dev.off()



## 2 using aggregate function
NEI3 <- aggregate(NEI[NEI$fips == "24510",]$Emissions, by = NEI[NEI$fips == "24510",]["year"], sum, na.rm = TRUE)
with(NEI3, barplot(x, names = year, xlab = "Years", ylab = "Emissions", 
                   main = "Emissions in the Baltimore City over the years (using aggregate func)", col = year))


## 3 using data.table
## https://cran.r-project.org/web/packages/data.table/vignettes/datatable-sd-usage.html
NEI4 <- as.data.table(NEI)
NEI_to_plot <- NEI4[NEI4$fips == "24510"][,lapply(.SD, sum, na.rm = TRUE), by = year, .SDcols = "Emissions"]
with(NEI_to_plot, barplot(Emissions, names = year, xlab = "Years", ylab = "Emissions",
                          main = "Emissions in the Baltimore City over the years (using data.table)", 
                          col = year))
