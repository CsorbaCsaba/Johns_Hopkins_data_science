library(data.table)

#set the working directory
Rfile <- file.choose()
wd <- dirname(Rfile)

setwd(wd)
dir()

list.files(file.path(wd,"data"))

# calculate the required memory
# rows * columns * data(i.e.:8bytes/numeric)
round(2075259*9*8/2^{20},2)
# 142,5 Mb


df <- fread("./data/household_power_consumption.txt", na.strings = "?")
df <- subset(df, 
             as.Date(Date, format = "%d/%m/%Y") == as.Date("2007-02-01") | 
                 as.Date(Date, format = "%d/%m/%Y") == as.Date("2007-02-02"))
head(df)
summary(df)
sapply(df, class)
df$DayTime <- as.POSIXct(paste(df$Date, df$Time), format = "%d/%m/%Y %H:%M:%S")
str(df)

png("./output/plot3.png", width = 480, height = 480)

plot(df$DayTime,df$Sub_metering_1, type = "l", xlab = "",
     ylab = "Energy sub metering")
lines(df$DayTime, df$Sub_metering_2, col = "red")
lines(df$DayTime, df$Sub_metering_3, col = "blue")
legend("topright", col = c("black","red","blue"),
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = c(1,1), lwd = c(1,1))

dev.off()

