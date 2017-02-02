#Gintare Baublyte
#02.02.2017
#Data wrangling exercise

lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

str(lrn14)

dim(lrn14)

#Data has 183 rows (observations) and 60 columns (variables). Most of the variables are recorded in Likert scale. Gender has numbers 1 and 2 attributed to Female and Male respectively.

library(dplyr)

lrn14$Attitude

lrn14$Attitude / 10

lrn14$attitude <- lrn14$Attitude / 10

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

learning2014 <- select(lrn14, one_of(keep_columns))

str(learning2014)

colnames(learning2014)

colnames(learning2014)[2] <- "age"

colnames(learning2014)[7] <- "points"

colnames(learning2014)

learning2014 <- filter(learning2014, points > 0)

str(learning2014)

setwd("C:/Users/Severi/Documents/Open Data/IODS-project")
