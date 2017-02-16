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
