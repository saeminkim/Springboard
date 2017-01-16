library(dplyr)
library(tidyr) 

## load refine_orignial.csv into R
mydf <- read.csv("C:/Users/Andrew/Desktop/refine_original.csv")

## 1. Clean up brand names
mydf[,1] <- tolower(mydf[,1])

## 2. Separate product code and number
mydf <- separate(mydf, Product.code...number, c("product_code","product_number"), sep = "-") ## breaks out Product.code...number field using tidyr separate() function

## 3. Add product categories
mydf<-mutate(mydf, product_category = if_else(product_code == "p", "Smartphone",if_else(product_code == "v", "TV",if_else(product_code == "x","Laptop",if_else(product_code == "q", "Tablet","Other"))))) ## creates product category field based on product code

## 4. Add full address for geocoding
mydf <- mutate(mydf, full_address = paste(mydf$address, mydf$city, mydf$country, sep = ", ")) ## concactenates address, city and county fields into full_address field

## 5. Create dummy variables for company and product category
mydf <- mutate(mydf, company_phillips = if_else(substr(mydf$ï..company,1,1)=="p",1,0))
mydf <- mutate(mydf, company_akzo = if_else(substr(mydf$ï..company,1,1)=="a",1,0))
mydf <- mutate(mydf, company_van_houten = if_else(substr(mydf$ï..company,1,1)=="v",1,0))
mydf <- mutate(mydf, company_unilever = if_else(substr(mydf$ï..company,1,1)=="u",1,0))
mydf <- mutate(mydf, product_smartphone = if_else(substr(mydf$product_code,1,1)=="p",1,0))
mydf <- mutate(mydf, product_tv = if_else(substr(mydf$product_code,1,1)=="v",1,0))
mydf <- mutate(mydf, product_laptop = if_else(substr(mydf$product_code,1,1)=="x",1,0))
mydf <- mutate(mydf, product_tablet = if_else(substr(mydf$product_code,1,1)=="q",1,0))

## export cleaned dataframe into new csv file
write.csv(mydf,"refine_clean.csv")
