# Tuomas Keski-Kuha, 10.11.2021
# Week2 data wrangling exercise 

# data from http://www.helsinki.fi/~kvehkala/
# JYTmooc/JYTOPKYS3-data.txt

# reading the data
lrn_data <- 
  read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", 
             sep="\t", 
             header=TRUE) 

# exploring data structure, almost all columns are integers
# only gender is a character. Data has 183 rows 
# (183 observations) and 60 columns (60 variables)
str(lrn_data)
dim(lrn_data)
head(lrn_data)


