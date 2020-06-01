tolower("BLA")
toupper("bla")
strsplit("Location.1", "\\.")
sub("_","","valami_id")

sub("_","","ez_egy_teszt")
gsub("_","","ez_egy_teszt")

substr("Egyedem begyedem",1,7)

library(stringr)
stringr::str_trim("   Egyedem  begyedem   ")



data(mtcars)
mtcars
df <- mtcars
df$carname <- row.names(df)
grep("mazda", tolower(df$carname))
grepl("mazda", tolower(df$carname))
table(grepl("mazda", tolower(df$carname)))

df2 <- df[grepl("mazda", tolower(df$carname)),]
df2


grep("mazda", tolower(df2$carname),value=TRUE)
