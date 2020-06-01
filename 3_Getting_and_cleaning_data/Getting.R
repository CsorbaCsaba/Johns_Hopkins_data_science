# Set up the working directory
RFile <- file.choose() # select this .R file from the explorer
wd  <- dirname(RFile) # get the name of the directory
setwd(wd)
getwd()
dir()



?connection

# MySQL
library(RMySQL)
# www.pantz.org/software/mysql/mysqlcommands.html
# http://genome.ucsc.edu/goldenPath/help/mysql.html
ucscDb <- dbConnect(MySQL(),user="genome",
                    host="genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb,'show databases;');dbDisconnect(ucscDb)
result

hg19 <- dbConnect(MySQL(),user="genome",db="hg19",
                  host="genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables)
allTables[1:5]

dbListFields(hg19,"affyU133Plus2")
dbGetQuery(hg19, "select count(*) from affyU133Plus2")
affyData <- dbReadTable(hg19,"affyU133Plus2")
head(affyData)

query <- dbSendQuery(hg19,"select * from affyU133Plus2 where misMatches between 1 and 3")
affMis <- fetch(query); quantile(affMis$misMatches)
affMisSmall <- fetch(query, n=10);dbClearResult(query)
dim(affMisSmall)
dbDisconnect(hg19)


#HDF5
#www.hdfgroup.org
source("http://bioconductor.org/biocLite.R")
# https://bioconductor.org/install
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(version = "3.11")

# To install core packages
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install()
BiocManager::available()
BiocManager::install("rhdf5")

library(rhdf5)
created <- h5createFile("./Data/example.h5")
created

created = h5createGroup("./Data/example.h5","foo")
created = h5createGroup("./Data/example.h5","baa")
created = h5createGroup("./Data/example.h5","foo/foobaa")
h5ls("./Data/example.h5")

A = matrix(1:10,nr=5, nc=2)
h5write(A,"example.h5","foo/A")
B = array(seq(0.1,2.0,by=0.1),dim=c(5,2,2))
attr(B, "scale") <- "liter"
h5write(B,"example.h5","foo/foobaa/B")
h5ls("example.h5")

df = data.frame(1L:5L,seq(0,1,length.out = 5),
                c("ab","cde","fghi","a","s"),
                stringsAsFactors = FALSE)
h5write(df, "example.h5", "df")
h5ls("example.h5")

readA = h5read("example.h5","foo/A")
readA
readB = h5read("example.h5","foo/foobaa/B")
readB
readdf = h5read("example.h5","df")
readdf

h5write(c(12,13,14), "example.h5","foo/A", 
        index=list(1:3,1))
h5read("example.h5","foo/A")




# Reading data from the WEB
con <- url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")

htmlCode <- readLines(con)
close(con)
htmlCode


library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes = TRUE)
xpathSApply(html, "//title",xmlValue)
xpathSApply(html, "//td[@id='col-citedby']",xmlValue)

library(XML)
library(httr)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlParse(rawToChar(GET(url)$content))
xpathSApply(html, "//title",xmlValue)
xpathSApply(html, "//td[@id='col-citedby']",xmlValue)


library(httr); html2 =GET(url)
content2 = content(html2,as="text")
parsedHtml =htmlParse(content2,asText = TRUE)
xpathSApply(parsedHtml,"//title",xmlValue)
xpathSApply(parsedHtml, "//td[@id='col-citedby']",xmlValue)


pg2 = GET("http://httpbin.org/basic-auth/user/passwd",
          authenticate("user","passwd"))
pg2
names(pg2)


google=handle("https://google.com")
pg1=GET(handle = google,path="/")
pg2=GET(handle = google,path="search")


#TWITTER 
# https://developer.twitter.com/en/docs/api-reference-index
# https://developer.twitter.com/en/docs/tweets/timelines/api-reference/get-statuses-home_timeline
myapp = oauth_app("twitter",key = "yourconsumerKeyHere",
                  secret = "yourconsumerSecretHere")
sig = sign_oauth1.0(myapp, token = "yourTokenHere",
                    token_secret = "yourTokenSecretHere")
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)

json1 = content(homeTL)
json2 = jsonlite::fromJSON(toJSON(jsno1))
json2[1,1:4]




connection <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(connection)
close(connection)
c(nchar(htmlCode[10]), nchar(htmlCode[20]), nchar(htmlCode[30]), nchar(htmlCode[100]))


url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
lines <- readLines(url, n = 10)
w <- c(1, 9, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3)
colNames <- c("filler", "week", "filler", "sstNino12", "filler", "sstaNino12", 
              "filler", "sstNino3", "filler", "sstaNino3", "filler", "sstNino34", "filler", 
              "sstaNino34", "filler", "sstNino4", "filler", "sstaNino4")
d <- read.fwf(url, w, header = FALSE, skip = 4, col.names = colNames)
d <- d[, grep("^[^filler]", names(d))]
sum(d[, 4])










