#Gintare Baublyte
#10.02.2017
#The data is on student alcohol consumption (https://archive.ics.uci.edu/ml/datasets/STUDENT+ALCOHOL+CONSUMPTION)

#read datafiles into R
setwd("C:/Users/Severi/Documents/Open Data/IODS-project/data")
math <- read.csv(file = "student-mat.csv", header = TRUE, sep = ";")
por <- read.csv(file = "student-por.csv", header = TRUE, sep = ";")

#structure of the datasets
str(math)
str(por)

#dimensions fo the datasets
dim(math)
dim(por)

#access dplyr library
library(dplyr)

#common columns to use as identifiers
join_by <- (c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet"))

# join the two datasets by the selected identifiers
math_por <- inner_join(math, por, by = join_by, suffix = c(".math", ".por"))

#explore the structure and dimensions of the joined data
str(math_por)
dim(math_por)

#combine duplicated answers in the joined data

alc <- select(math_por, one_of(join_by))

notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

notjoined_columns

for(column_name in notjoined_columns) {
  two_columns <- select(math_por, starts_with(column_name))
  first_column <- select(two_columns, 1)[[1]]
  
  if(is.numeric(first_column)) {
    alc[column_name] <- round(rowMeans(two_columns))
  } else {
    alc[column_name] <- select(two_columns, 1)[[1]]
  }
}

#create a new column alc_use
#by averaging the answers related to weekday and weekend alcohol consumption

alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

#create a new logical column high_use
#with is TRUE for students for which alc_use is greater than 2
#and FALSE otherwise

alc <- mutate(alc, high_use = alc_use > 2)

#glimpse at the joined and modified data

glimpse(alc)

#save the joined and modified dataset

setwd("C:/Users/Severi/Documents/Open Data/IODS-project/data")

write.table(alc, file = "alc.txt", sep = ";")

#check that it works
read.table("alc.txt", header = T, sep = ";")
