## 1- Set working directory
setwd(/your_working_directory/)
## To check your working directory
# getwd()
## 2- Install new packages
install.packages(c("tidyverse", "stringr"))
## Check packages installed or not
# search()
## To load library
library(tidyverse); library(stringr)
## 3- Read data
baby_names <- read_csv ("http://tutorials.iq.harvard.edu/R/Rintro/dataSets/babyNames.csv")
## 1- Add "Proportion" column which is equal to Percent divided by 100
baby_names[, "Proportion"] <- baby_names[, "Percent"] / 100
## 2- Filter by year that are given in 2015 and save data as "baby_names_2015"
baby_names_2015 <- subset(baby_names, Year==2015)
## 3- Count and filter by location and year that in Massachusetts ("MA") and 2015
baby_names_MA <- subset(baby_names, Location=="MA")
baby_names_MA_2015_count <- subset(baby_names_MA$Count,baby_names_MA$Year==2015)
sum(baby_names_MA_2015_count)
## 4- Filter names to at least 5 percent in 2015
unique_names <- aggregate(Proportion~Year+Name,baby_names,sum)
popular_names_15 <-  subset(unique_names[,c("Name","Proportion")], unique_names$Year==2015 & unique_names$Proportion>=0.5)
## 5- Save data frame as csv file
write.csv(popular_names_2015, file = "popular_names_20151.csv", row.names=FALSE)
## 6- Total number in 2015
sum(baby_names_2015$Count)
## 7- Total number of babies that name as zeynep in all years.
sum(subset(baby_names, Name=="zeynep")$Count)
## 8- New column called "name_length"
baby_names$name_length <- nchar(baby_names$Name)
## 9- Average length of names and plot
length_by_year <- aggregate(Count~Year + name_length, data=baby_names, FUN=sum, na.rm=TRUE)
length_by_year$lengthCount <-length_by_year$name_length * length_by_year$Count
mean_length_by_year <- aggregate(.  ~Year ,data=length_by_year,  FUN=sum, na.rm=TRUE)
mean_length_by_year$average_length <- mean_length_by_year$lengthCount / mean_length_by_year$Count
plot(mean_length_by_year$Year, mean_length_by_year$average_length, type="l", xlab= "Years", ylab="Average Name Length")
