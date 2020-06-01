
## PLOT
# Set up the working directory
RFile <- file.choose() # select this .R file from the explorer
wd  <- dirname(RFile) # get the name of the directory
setwd(wd)
getwd()
dir()

df <- read.table("../data/outcome-of-care-measures.csv", 
                 colClasses = "character",
                 header = TRUE,
                 sep = ",",
                 na.strings = c("NA","Not Available"))
df[, 11] <- as.numeric(df[, 11]) 
hist(df[, 11])



## best
best <- function(state, outcome) {
    # Set up the working directory
    RFile <- file.choose() # select this .R file from the explorer
    wd  <- dirname(RFile) # get the name of the directory
    setwd(wd)
    getwd()
    dir()
    
    ## Read outcome data
    df <- read.table("../data/outcome-of-care-measures.csv", 
                     colClasses = "character",
                     header = TRUE,
                     sep = ",",
                     na.strings = c("NA","Not Available"))
    
    ## Check that state and outcome are valid
    valid_s <- state %in% unique(df[,"State"]) 
    if (valid_s == FALSE) {stop("Invalid state")}
    valid_o <- outcome %in% c("heart attack","heart failure","pneumonia")
    if (valid_o == FALSE) {stop("Invalid outcome")}
    
    ## Return hospital name in that state with lowest 30-day death
    if (outcome == "heart attack") {
        c <- 11
    } else if (outcome == "heart failure") {
        c <- 17
    } else if (outcome == "pneumonia") {
        c <- 23
    }
    
    data <- df[df["State"] == state,c(2,7,c)]
    data <- data[complete.cases(data),]
    data[,3] <- as.numeric(data[,3])
    res <- data[data[3] == min(data[3]),]

    ## rate
    if (length(res) !=  1) {
        fin <- res[order(res[1]),]$Hospital.Name
    } else {fin <- res$Hospital.Name}
    return(fin)
    }
best("TX","heart failure")




rankhospital <- function(state, outcome, num="best") {
    # Set up the working directory
    RFile <- file.choose() # select this .R file from the explorer
    wd  <- dirname(RFile) # get the name of the directory
    setwd(wd)
    getwd()
    dir()
    
    ## Read outcome data
    df <- read.table("../data/outcome-of-care-measures.csv", 
                     colClasses = "character",
                     header = TRUE,
                     sep = ",",
                     na.strings = c("NA","Not Available"))
    
    ## Check that state and outcome are valid
    valid_s <- state %in% unique(df[,"State"]) 
    if (valid_s == FALSE) {stop("Invalid state")}
    valid_o <- outcome %in% c("heart attack","heart failure","pneumonia")
    if (valid_o == FALSE) {stop("Invalid outcome")}
    
    ## Return hospital name in that state with the given rank 
    ## 30-day death rate
    if (outcome == "heart attack") {
        c <- 11
    } else if (outcome == "heart failure") {
        c <- 17
    } else if (outcome == "pneumonia") {
        c <- 23
    }

    data <- df[df["State"] == state,c(2,7,c)]
    data <- data[complete.cases(data),]
    data[,3] <- as.numeric(data[,3])
    data <- data[order(data[,3],data[,1]),]
    
    if (is.character(num)) {
        if (num == "best") {
            d <- 1
        } else if (num == "worst") {
            d <- nrow(data)
        } else {stop("Wrong choice")}
    } else {
        if (num > nrow(data)) {
            stop("NA")
        } else {
            d <- num
        }
    }
    res <- data[d,1]
    return(res)
    
}
rankhospital("TX", "heart failure", 4)




rankall <- function(outcome, num = "best") { 
    # Set up the working directory
    RFile <- file.choose() # select this .R file from the explorer
    wd  <- dirname(RFile) # get the name of the directory
    setwd(wd)
    getwd()
    dir()
    
    ## Read outcome data
    df <- read.table("../data/outcome-of-care-measures.csv", 
                     colClasses = "character",
                     header = TRUE,
                     sep = ",",
                     na.strings = c("NA","Not Available"))
    
    ## Check that outcome are valid
    valid_o <- outcome %in% c("heart attack","heart failure","pneumonia")
    if (valid_o == FALSE) {stop("Invalid outcome")}
    
    ## For each state, find the hospital of the given rank
    if (outcome == "heart attack") {
        c <- 11
    } else if (outcome == "heart failure") {
        c <- 17
    } else if (outcome == "pneumonia") {
        c <- 23
    }
    
    data <- df[,c(2,7,c)]
    data[,3] <- as.numeric(data[,3])
    colnames(data) <- c("hospital","state","rate")
    data <- data[!is.na(data$rate),]
    data <- data[order(data[,2], data[,3], data[,1]),]
    data
    
    ## first matches
    ## data[match(unique(data[,"state"]) , data$state),]
    
    res <- data.frame()
    for (i in unique(data$state)) {
        temp <- subset(data, data$state == i)
        temp <- temp[order(temp$rate,temp$hospital),]
        
        if (is.character(num)) {
            if (num == "best") {
                d <- 1
            } else if (num == "worst") {
                d <- nrow(temp)
            } else {stop("Wrong choice")}
        } else {d <- num}
        #     if (num > nrow(temp)) {
        #         stop("NA")
        #     } else {
        #         d <- num
        #     }
        # }
        res <- rbind(res,temp[d,])
    }
    res <- res[,1:2]
    return(res)
    
    ## Return a data frame with the hospital names and the 
    ## (abbreviated) state name
}
head(rankall("heart attack", 20),10)
tail(rankall("pneumonia", "worst"), 3)
tail(rankall("heart failure"), 10)

