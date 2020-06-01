# Week2 Programming assignment
pollutantmean <- function(directory, pollutant, id=1:332) {
    getwd() #get working directory
    Rfile <- file.choose()
    wd <- dirname(Rfile)
    setwd(wd)
    #dir()
    
    if (directory == "specdata") {
        f <- file.path(wd,"specdata")
        setwd(f)    
    } else {
        print("wrong directory")
    }
    df <- data.frame()
    for (i in id) {
        # n_int_digits = function(x) {
        #     result = floor(log10(abs(x)))
        #     result[!is.finite(result)] = 0
        #     result
        # }
        if (nchar(as.character(i)) == 1) {
            x <- paste("00",i,".csv", sep = "")
        } else if (nchar(as.character(i)) == 2) {
            x <- paste("0",i,".csv", sep = "")
        } else {
            x <- paste(i, ".csv", sep = "")
        }
        print(paste("Workfile: ", paste(wd,  x, sep = "/")))
        temptable <- read.table(paste(wd,  x, sep = "/"), header = TRUE, sep = ",")
        df <- rbind(df, temptable)
    }
    cleanTable <- df[!is.na(df[pollutant]),]
    poll <- cleanTable[pollutant]
    aver <- mean(poll[,pollutant], na.rm = TRUE)
    print(aver)
    }
pollutantmean("specdata", "nitrate", 1:152)
rm(list = ls())


complete <- function(directory = "specdata", id = 1:332) {
    getwd() #get working directory
    Rfile <- file.choose()
    wd <- dirname(Rfile)
    setwd(wd)
    
    if (directory == "specdata") {
        f <- file.path(wd,"specdata")
        setwd(f)    
    } else {
        print("wrong directory")
    }
    df <- data.frame()
    res <- data.frame()
    nobs <- numeric(length(id))
    files <- list.files(wd, full.names = T)
    c <- 1
    for (i in id) {
        df <- read.table(files[i], header = TRUE, sep = ",")
        nobs[c] <- sum(complete.cases(df))
        res <- data.frame(id, nobs)
        c <- c + 1
    }
    return(res)
}
complete("specdata", c(11,55,78,92,101,263))
rm(list = ls())


corr <- function(directory, threshold = 0) {
    getwd() #get working directory
    Rfile <- file.choose()
    wd <- file.path(dirname(Rfile),"specdata")


    act_files <- list.files(wd, full.names = TRUE)
    df <- complete(directory, 1:332)
    id <- df[df["nobs"] > threshold, ]$id
    corel <- numeric()
    
    for (i in id) {
        mydata <- read.table(act_files[i], header = TRUE, sep = ",")
        dff <- mydata[complete.cases(mydata), ]
        corel <- c(corel, cor(dff$sulfate, dff$nitrate))
    }
    return(corel)
}
cr <- corr("specdata",150)
summary(cr)
rm(list = ls())


pollutantmean("specdata", "sulfate", 1:10)
pollutantmean("specdata", "nitrate", 70:72)
pollutantmean("specdata", "sulfate", 34)
pollutantmean("specdata", "nitrate")
cc <- complete("specdata", c(6, 10, 20, 34, 100, 200, 310))
print(cc$nobs)
cc <- complete("specdata", 54)
print(cc$nobs)

RNGversion("3.5.1") 
set.seed(42)
cc <- complete("specdata", 332:1)
use <- sample(332, 10)
print(cc[use, "nobs"])


cr <- corr("specdata")                
cr <- sort(cr)   
RNGversion("3.5.1")
set.seed(868)                
out <- round(cr[sample(length(cr), 5)], 4)
print(out)

cr <- corr("specdata", 129)                
cr <- sort(cr)                
n <- length(cr)    
RNGversion("3.5.1")
set.seed(197)                
out <- c(n, round(cr[sample(n, 5)], 4))
print(out)

cr <- corr("specdata", 2000)                
n <- length(cr)                
cr <- corr("specdata", 1000)                
cr <- sort(cr)
print(c(n, round(cr, 4)))
