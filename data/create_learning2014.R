#Gintare Baublyte
#02.02.2017
#Data wrangling exercise

lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

str(lrn14)

dim(lrn14)

#Data has 183 rows (observations) and 60 columns (variables). Most of the variables are recorded in Likert scale. Gender has numbers 1 and 2 attributed to Female and Male respectively.

