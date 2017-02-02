#Gintare Baublyte
#02.02.2017
#Data wrangling exercise

#read data
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

#structure of dataset

str(lrn14)

#dimensions of dataset

dim(lrn14)

#Data has 183 rows (observations) and 60 columns (variables). Most of the variables are recorded in Likert scale. Gender has numbers 1 and 2 attributed to Female and Male respectively.

library(dplyr)

#Attitude is a sum of 10 questions. Here it's scaled back to the original scale of questions.
lrn14$Attitude

lrn14$Attitude / 10

lrn14$attitude <- lrn14$Attitude / 10

# questions related to deep, surface and strategic learning are combined
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# columns related to deep learning are selected and new column 'deep' is created by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

# columns related to surface learning are selected and new column 'surf' is created by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

# columns related to strategic learning are selected and new column 'stra' is created by averaging
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

#new dataset with just 7 variables is created

keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

learning2014 <- select(lrn14, one_of(keep_columns))

str(learning2014)

#some column names are renamed to match others

colnames(learning2014)

colnames(learning2014)[2] <- "age"

colnames(learning2014)[7] <- "points"

colnames(learning2014)

#those observations that have 0 points are ommited from the final dataset

learning2014 <- filter(learning2014, points > 0)

str(learning2014)

#setting of working directory

setwd("C:/Users/Severi/Documents/Open Data/IODS-project")

write.table(learning2014, file = "learning2014.txt")

read.table("learning2014.txt")

str(learning2014)

head(learning2014)
