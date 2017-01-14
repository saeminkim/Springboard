library(dplyr)
library(stringr) 

## load refine_orignial.csv into R
mydf <- read.csv("C:/Users/Andrew/Desktop/refine_original.csv")

## 1. Clean up brand names
mydf[,1] <- tolower(mydf[,1])

## 2. Separate product code and number
list<-str_split_fixed(mydf$Product.code...number, "-", n = 2) ## delimits on "-" into list vector
mydf$product_code <- as.character(list[,1]) ## adds product_code field to mydf dataframe
mydf$product_number <- as.numeric(list[,2]) ## adds product_number field to mydf dataframe
mydf$Product.code...number <- NULL ## drops product field

## 3. Add product categories
mydf<-mutate(mydf, product_category = if_else(product_code == "p", "Smartphone",if_else(product_code == "v", "TV",if_else(product_code == "x","Laptop",if_else(product_code == "q", "Tablet","Other"))))) ## creates product category field based on product code

## 4. Add full address for geocoding
mydf <- mutate(mydf, full_address = paste(mydf$address, mydf$city, mydf$country, sep = ", ")) ## concactenates address, city and county fields into full_address field

## 5. Create dummy variables for company and product category
mydf <- mutate(mydf, company_phillips = if_else(substr(mydf[,1],1,1)=="p",1,0))
mydf <- mutate(mydf, company_akzo = if_else(substr(mydf[,1],1,1)=="a",1,0))
mydf <- mutate(mydf, company_van_houten = if_else(substr(mydf[,1],1,1)=="v",1,0))
mydf <- mutate(mydf, company_unilever = if_else(substr(mydf[,1],1,1)=="u",1,0))
mydf <- mutate(mydf, product_smartphone = if_else(substr(mydf[,6],1,1)=="p",1,0))
mydf <- mutate(mydf, product_tv = if_else(substr(mydf[,6],1,1)=="v",1,0))
mydf <- mutate(mydf, product_laptop = if_else(substr(mydf[,6],1,1)=="x",1,0))
mydf <- mutate(mydf, product_tablet = if_else(substr(mydf[,6],1,1)=="q",1,0))

## export cleaned dataframe into new csv file
write.csv(mydf,"refine_clean.csv")
