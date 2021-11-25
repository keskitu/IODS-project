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
