# Tuomas Keski-Kuha, 24.11.2021
# Week4 data wrangling exercise 

# data from http://s3.amazonaws.com/assets.datacamp.com
# /production/course_2218/datasets/

# Metadata: http://hdr.undp.org/en/content/
# human-development-index-hdi
# ---------------------------------------------

# Access the dplyr library
library(dplyr)
library(tidyr)
library(ggplot2)


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

colnames(hd)
colnames(gii)

# new column names for gii data, from column 3
hd_new_names <- c("HDI", "Life.Exp", "Edu.Exp",
                   "Edu.Mean", "GNI", "GNI.Minus.Rank")

# new column names for gii data, from column 3
gii_new_names <- c("GII", "Mat.Mor", "Ado.Birth", 
                   "Parli.F", "Edu2.F", "Edu2.M", 
                   "Labo.F", "Labo.M")

colnames(hd)[3:8] <- hd_new_names

colnames(gii)[3:10] <- gii_new_names

