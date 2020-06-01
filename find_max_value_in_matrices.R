a <- matrix(c(1:50),10,5)
colnames(a) <- c('H', 'K', 'Sz','Cs','P')
a
rownames(a) <- c(1:10)
a
a[,('Cs'='31')]
which(a==max(a[,'Cs']),arr.ind = T) #a helye
which(a==max(a[,'Cs'])) # az értéke