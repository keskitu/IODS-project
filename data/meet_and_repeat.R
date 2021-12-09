# Tuomas Keski-Kuha, 4.12.2021
# Week6 data wrangling exercise 

# data from https://raw.githubusercontent.com/
# KimmoVehkalahti/MABS/master/Examples/data/

# ---------------------------------------------

# Access the some libraries
library(dplyr)
library(tidyr)
library(ggplot2)

###################################
#### Exercise 1:###################
###################################
# Load the data sets (BPRS and RATS) into R 
#using as the source the GitHub repository of MABS, 
# where they are given in the wide form:

# Also, take a look at the data sets: 
# check their variable names, view the 
# data contents and structures, and create 
# some brief summaries of the variables , 
# so that you understand the point of the 
# wide form data. (1 point)

setwd("c:/Tuomas/Opiskelu/Open Data Science/IODS-project")

#  read BPRS data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
#  read RATS data
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep  ="\t", header = T)

# Look at the (column) names of BPRS
names(BPRS)

# Look at the structure of BPRS
str(BPRS)

# print out summaries of the variables
summary(BPRS)

# Look at the (column) names of rats
names(RATS)

# Look at the structure of rats
str(RATS)

# print out summaries of the variables
summary(RATS)

# brief summaries of the variables is done
# in exercise 5 where also long form variables
# are summarized

###################################
#### Exercise 2:###################
###################################

# 2. Convert the categorical variables of both 
# data sets to factors. (1 point)

BPRS <- within(BPRS, {
  treatment <- factor(treatment)
  subject <- factor(subject)
})

RATS <- within(RATS, {
  ID <- factor(ID)
  Group <- factor(Group)
})

###################################
#### Exercise 3:###################
###################################

# 3. Convert the data sets to long form.  
# Add a week variable to BPRS and a Time 
# variable to RATS. (1 point)

# changing from wide form to long form
BPRSL <- gather(BPRS, key = weeks, value = bprs, week0:week8) %>%
  mutate(week = as.integer(substr(weeks, 5, 5)))

# changing from wide form to long form
RATSL <- gather(RATS, key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4)))


###################################
#### Exercise 4:###################
###################################

# 4. Now, take a serious look at the new data sets and compare them with  
# their wide form versions: Check the variable names, view the data contents  
# and structures, and create some brief summaries of the variables. Make sure 
# that you understand the point of the long form data and the crucial 
# difference between the wide and the long forms before proceeding the to 
# Analysis exercise. (2 points)

str(BPRS)
head(BPRS, 10)
summary(BPRS)

# Brief summary of the variables:

str(BPRSL)
head(BPRSL, 10)
summary(BPRSL)

# Brief summary of the variables:

str(RATS)
head(RATS, 10)
summary(RATS)

# Brief summary of the variables:

str(RATSL)
head(RATSL, 10)
summary(RATSL)

# Brief summary of the variables:


# let's write long files to csv files for the analysis

write.csv(BPRSL, "data/BPRSL.csv", 
          row.names = FALSE)

write.csv(RATSL, "data/RATSL.csv", 
          row.names = FALSE)


