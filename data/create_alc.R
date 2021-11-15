# Tuomas Keski-Kuha, 15.11.2021
# Week3 data wrangling exercise 

# data from https://archive.ics.uci.edu/ml/
# datasets/Student+Performance
# ---------------------------------------------


# Access the dplyr library
library(dplyr)

setwd("c:/Tuomas/Opiskelu/Open Data Science/IODS-project")

#  file reading 
data_demo <- read.csv(file = "data/asdf.csv", 
                      stringsAsFactors = TRUE)
