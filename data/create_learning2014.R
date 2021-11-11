# Tuomas Keski-Kuha, 10.11.2021
# Week2 data wrangling exercise 

# data from http://www.helsinki.fi/~kvehkala/
# JYTmooc/JYTOPKYS3-data.txt
# Meta data from
# . http://www.helsinki.fi/~kvehkala/
# JYTmooc/JYTOPKYS2-meta.txt

# ---------------------------------------------

# installing few packages
install.packages("dplyr")
install.packages("ggplot2")
install.packages("GGally")

# Access the dplyr library
library(dplyr)

# reading the learning data
lrn_data <- 
  read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", 
             sep="\t", 
             header=TRUE) 

# exploring data structure, 
str(lrn_data)
dim(lrn_data)
head(lrn_data)

# almost all columns are integers
# only gender is a character. Data has 183 rows 
# (183 observations) and 60 columns (60 variables)
# it seems that we have grades from the students
# from various courses and in addition to that
# some information from the students lie age, attitude
# points and gender 

lrn14 <- lrn_data
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

# choose a handful of columns to keep
keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
learning2014 <- select(lrn14, one_of(keep_columns))

# change the name of the second column
colnames(learning2014)[2] <- "age"

# change the name of "Points" to "points"
colnames(learning2014)[7] <- "points"

# change the name of "Attitude" to "attitude"
colnames(learning2014)[3] <- "attitude"

# select rows where points is greater than zero
learning2014 <- filter(learning2014, points>0)
head(learning2014)

# set the working directory to iods project folder
setwd("c:/Tuomas/Opiskelu/Open Data Science/IODS-project")

# saving the learning data to data folder
# set row.names to false, ohtervise 1, 2, ... , 166 (row numbers) 
# will be the first column in the written file 
write.csv(learning2014, "data/learning2014.csv", 
          row.names = FALSE)

# demonstrating file reading 
data_demo <- read.csv(file = "data/learning2014.csv", 
                      stringsAsFactors = FALSE)
str(data_demo)
head(data_demo)
