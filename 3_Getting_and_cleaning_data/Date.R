d1 <- date()
d1

d2 <- Sys.Date()
d2

# %d day as number
# %a abbreviated weekday
# %A unabbreviated weekday
# %m month
# %b abbreviated month
# %B unabbreviated month
# %y 2 digit year
# %Y 4 difit year

format(d2,"%Y %B %d %A")


x <- c("1jan1960","2jan1960","31mar1960")
z <- as.Date(x, "%d%b%Y")
z




library(lubridate)
ymd("20160809")
x<-dmy(c("1jan1960","2jan1960","31mar1960"))
x

wday(x[1])
wday(x[1], label = TRUE)




