# Tuomas Keski-Kuha, 25.11.2021
# Week4 data wrangling exercise 

# data from http://s3.amazonaws.com/assets.datacamp.com
# /production/course_2218/datasets/

# Metadata: http://hdr.undp.org/en/content/
# human-development-index-hdi
# ---------------------------------------------

# Access the some libraries
library(dplyr)
library(tidyr)
library(ggplot2)
library(stringr)

# setwd("c:/Tuomas/Opiskelu/Open Data Science/IODS-project")

#  read Human development data
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

#  read Gender inequality data
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# look at the structure and dimensions of human development data (hd)
str(hd)
dim(hd)
# print out summaries of the variables of hd
summary(hd)

# look at the structure and dimensions of gender inequality data (gii)
str(gii)
dim(gii)

# print out summaries of the variables if gii
summary(gii)

# new column names for gii data, from column 3
hd_new_names <- c("HDI", "Life.Exp", "Edu.Exp",
                   "Edu.Mean", "GNI", "GNI.Minus.Rank")
# changing names (hd)
colnames(hd)[3:8] <- hd_new_names

# new column names for gii data, from column 3
gii_new_names <- c("GII", "Mat.Mor", "Ado.Birth", 
                   "Parli.F", "Edu2.F", "Edu2.M", 
                   "Labo.F", "Labo.M")

# changing names (gii)
colnames(gii)[3:10] <- gii_new_names

# Create GII: 
# "Edu2.FM" = Edu2.F / Edu2.M
# "Labo.FM" = Labo2.F / Labo2.M

gii$Edu2.FM <- gii$Edu2.F/gii$Edu2.M
gii$Labo.FM <- gii$Labo.F/gii$Labo.M

human <- inner_join(hd, gii, by = "Country")

# set the working directory to iods project folder
setwd("c:/Tuomas/Opiskelu/Open Data Science/IODS-project")

# saving the human data to data folder
# set row.names to false, ohtervise 1, 2, ... , 166 (row numbers) 
# will be the first column in the written file 
write.csv(human, "data/human.csv", 
          row.names = FALSE)

# look at the (column) names of human
names(human)

# look at the structure of human
str(human)

# print out summaries of the variables
summary(human)

#The human data originates from the United Nations  
#Development Programme. See their 
#data page (http://hdr.undp.org/en/content/human-
#development-index-hdi)  for more information. 
#For a nice overview see also the calculating 
#the human development indices pdf 
# (http://hdr.undp.org/sites/default/files/
#hdr2015_technical_notes.pdf).

#In the data we have countries and their 
#ranking based on Human Development Index (*HDI*) 
#and Gender Inequality Index (*GII*). Both of 
#them are aggregated indexes constructed from 
#other measures.

# in the data there's qualities of the countries 
# which should affect to for example HDI and GII ranks
# and also to GNI (gross national income)

# here (https://raw.githubusercontent.com/
# TuomoNieminen/Helsinki-Open-Data-Science
# /master/datasets/human_meta.txt)
# you can get more information on the data

###################################
# Week 5 DATA WRANGLING EXERCISES #
###################################

###################################
#### Exercise 1:###################
###################################

# look at the structure of the GNI column in 'human'
str(human$GNI)

# we see that it's chr, so we'll change it to numeric value
# and take off the comma separator
human$GNI <- str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric()

###################################
#### Exercise 2:###################
###################################

# columns to keep
keep <- c("Country", "Edu2.FM", "Labo.FM", 
          "Life.Exp", "Edu.Exp", "GNI", 
          "Mat.Mor", "Ado.Birth", "Parli.F")

# select the 'keep' columns
human <-human[, keep]

###################################
#### Exercise 3:###################
###################################

# filter out all rows with NA values complete cases
# function is true when there is no NA in the data
# and false otherwise
human <- filter(human, complete.cases(human))

###################################
#### Exercise 4:###################
###################################

# look at the last 10 observations, there are
# regions in the last 7 of the observations
# like world south asia etc.
tail(human, 10)

# last indice we want to keep, 
last <- nrow(human) - 7

# choose everything until the last 7 observations
# so we'll drop all the regions
human <- human[1:last, ]

###################################
#### Exercise 5:###################
###################################

# add countries as rownames
rownames(human) <- human$Country

# remove the Country variable which is the 
#first column
human <- human[, -1]

str(human)

write.csv(human, "data/human.csv", 
          row.names = TRUE)
