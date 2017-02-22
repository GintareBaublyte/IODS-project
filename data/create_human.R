#Gintare Baublyte
#16.02.2017

library(plyr)
library(dplyr)

#Read the "Human development" and "Gender inequality" datas into R

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#Explore the datasets

str(hd)
dim(hd)

str(gii)
dim(gii)

#Create summaries of the variables

summary(hd)

summary(gii)

#Rename the variables

hdnew <- plyr::rename(hd, c("HDI.Rank" = "rank", "Country" = "country", "Human.Development.Index..HDI." = "hdi", "Life.Expectancy.at.Birth" = "lifeexp", "Expected.Years.of.Education" = "eduexp", "Mean.Years.of.Education" = "edumean", "Gross.National.Income..GNI..per.Capita" = "gni", "GNI.per.Capita.Rank.Minus.HDI.Rank" = "gnirank"))
names(hdnew)

giinew <- plyr::rename(gii, c("GII.Rank"="rank", "Country"="country", "Gender.Inequality.Index..GII."="gii", "Maternal.Mortality.Ratio"="matmort", "Adolescent.Birth.Rate"="adolbirth", "Percent.Representation.in.Parliament"="repparl", "Population.with.Secondary.Education..Female."="edu2F", "Population.with.Secondary.Education..Male."="edu2M", "Labour.Force.Participation.Rate..Female."="labF", "Labour.Force.Participation.Rate..Male."="labM"))
names(giinew)

#mutate "Gender inequality" data by creating two new variables

giinew <- mutate(giinew, edu2FM = edu2F/edu2M, labFM = labF/labM)

#Join together the two datasets using the variable Country as the identifier
hd_gii <- inner_join(hdnew, giinew, by = "country")

human <- hd_gii

#save new data
setwd("C:/Users/Severi/Documents/Open Data/IODS-project/data")
write.table(human, file = "human.txt", sep = ";")


#Data Wrangling continued

#read the data

setwd("C:/Users/Severi/Documents/Open Data/IODS-project/data")
human <- read.table(file = "human.txt", sep = ";")

#check the structure
str(human)

#load packages
install.packages(tidyr)
library(tidyr)

install.packages(stringr)
library(stringr)

library(dplyr)

#mutate the data
#transform GNI variable to numeric (Using string manipulation)

str(human$gni)
str_replace(human$gni, pattern = ",", replace = "") %>% as.numeric

# columns to keep
keep <- c("country", "edu2FM", "labF", "lifeexp", "eduexp", "gni", "matmort", "adolbirth", "repparl")

# select the 'keep' columns
human <- dplyr::select(human, one_of(keep))

# print out a completeness indicator of the 'human' data
complete.cases(human)

# print out the data along with a completeness indicator as the last column
data.frame(human[-1], comp = complete.cases(human))

# filter out all rows with NA values
human_ <- filter(human, complete.cases(human))

# look at the last 10 observations of human
tail(human_, n=10)

# define the last indice we want to keep
last <- nrow(human_) - 7

# choose everything until the last 7 observations
human_ <- human_[1:last, ]

# add countries as rownames
rownames(human_) <- human_$country

# remove the Country variable
human_ <- dplyr::select(human_, -country)

#save new data
setwd("C:/Users/Severi/Documents/Open Data/IODS-project/data")
write.table(human, file = "human2.txt", sep = ";", row.names = TRUE)

