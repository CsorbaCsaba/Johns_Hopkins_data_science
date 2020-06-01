
getwd() #get working directory
Rfile <- file.choose()
wd <- dirname(Rfile)
setwd(wd)
dir()

#install.packages("readxl")
library(readxl)

#install.packages("XLConnect")
library(XLConnect)

#install.packages("readr")
library(readr)


x <- read_csv("./data/hw1_data.csv", n_max = 100)
str(x)


#install.packages("data.table")
#install.packages("bit64")
library(data.table)
library(bit64)

s <- fread("./data/hw1_data.csv", nrows = 100)
str(s)

# Some columns are type 'integer64' but package bit64 is not installed. 
# Those columns will print as strange looking floating point data. 
# There is no need to reload the data. Simply install.packages('bit64') 
# to obtain the integer64 print method and print the data again.