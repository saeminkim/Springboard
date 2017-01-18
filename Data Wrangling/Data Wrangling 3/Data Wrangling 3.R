library(tidyr)
library(dplyr)

setwd("C:/Users/Andrew/Desktop/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/test/Inertial Signals")

dfiles <- list.files()

for (file in dfiles){
  if (!exists("testdf")){
    testdf <- read.table(file, header = FALSE)
  } else {
    testdf2 <- read.table(file, header = FALSE)
    testdf <- rbind(testdf, testdf2)
    rm(testdf2)
  }
}
 
setwd("C:/Users/Andrew/Desktop/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/train/Inertial Signals")

dfiles <- list.files()

for (file in dfiles){
  if (!exists("traindf")){
    traindf <- read.table(file, header = FALSE)
  } else {
    traindf2 <- read.table(file, header = FALSE)
    traindf <- rbind(traindf, traindf2)
    rm(traindf2)
  }
} 