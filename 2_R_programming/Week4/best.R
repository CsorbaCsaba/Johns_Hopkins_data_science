best <- function(state, outcome) {
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