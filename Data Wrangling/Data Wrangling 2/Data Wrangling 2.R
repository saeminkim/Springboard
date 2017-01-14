library(dplyr)

## load titanic3.csv into R
mydf <- read.csv("C:/Users/Andrew/Desktop/titanic3.csv")

## 1: Port of embarkation
mydf$embarked <- sub("^$|^ $","S",mydf$embarked) ## check for missing values in embarked field using regular expressions

## 2: Age
mydf$age[is.na(mydf$age)] = mean(mydf$age, trim = 0, na.rm = TRUE) ## replace missing age rows with mean of age field

## 3: Lifeboat
mydf$boat <- sub("^$|^ $","None",mydf$boat) ## substitute missing values in boat field with "None"

## 4: Cabin
mydf <- mutate(mydf, has_cabin_number = if_else(grepl("^[a-zA-Z][0-9]",mydf$cabin) == TRUE,1,0)) ## defining has_cabin_number field by using regular expressions on cabin field for rows beginning with character or numeric value

## export cleaned dataframe into new csv file
write.csv(mydf,"titanic_clean.csv")