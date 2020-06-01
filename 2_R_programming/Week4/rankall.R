rankall <- function(outcome, num = "best") { 
    # Set up the working directory
    RFile <- file.choose() # select this .R file from the explorer
    wd  <- dirname(RFile) # get the name of the directory
    setwd(wd)
    getwd()
    dir()
    
    ## Read outcome data
    df <- read.table("./data/outcome-of-care-measures.csv", 
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