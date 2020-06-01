### 1 ----------------------------------------------

df <- data.frame(ID=1:5, AGE=sample(c(NA,40:50),5,replace = T), SEX=sample(c(NA,"F","M"),5,replace = T),stringsAsFactors = FALSE)
df
str(df)
any(is.na(df))
is.na(df)

is.na(df$ID)
is.na(df$AGE)
is.na(df$SEX)

df[is.na(df$ID),1]
df[is.na(df$AGE),2]
df[is.na(df$SEX),3]

df
mean(df$AGE,na.rm = TRUE)
for(i in 1:ncol(df)){
  if(is.numeric(df[,i])){
  df[is.na(df[,i]),i] <- mean(df[,i],na.rm = TRUE)
  }
}
rm(df)
rm(i)


### 2 ----------------------------------------------
a <- data.frame(ID=1:50, AGE=sample(c(NA,35:65),50, replace = T), SEX=sample(c(NA,"F","M"),50,replace = T))
a
any(is.na(a))
is.na(a)

str(a)

b<-a

str(b)

c <- sapply(b,is.factor)
b[c] <- lapply(b[c],as.character)
str(b)

is.na(b)

for(i in 1:ncol(b)){
  b[is.na(b[, i]), i] <- 0
}

rm(i)