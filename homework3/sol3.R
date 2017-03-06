library(XML)
library(httr)

options(digits = 5)

tables <-  GET("https://en.wikipedia.org/wiki/List_of_countries_and_dependencies_by_population")

poptable <- readHTMLTable(rawToChar(tables$content),which = 2)

str(poptable)

poptable[,5] <- gsub("%", "", poptable[,5])

poptable[,5] <-  as.numeric(poptable[,5])

poptable[,3] <- gsub(",", "", poptable[,3])

poptable[,3] <-  as.numeric(poptable[,3])

poptable[,1] <-  as.numeric(levels(poptable[,1]))[poptable[,1]]

mean(poptable$Population)

#Answers

# 1. convert "Date" column (factor) into date
# Please find date formats in r here: PO

poptable$Date <- as.Date(poptable$Date, format = "%B %d, %Y")

# 2. CHANGE THE COLUMN NAMES AS: "Rank","Country", "Population", "Date",   "% of world", "Source" 

colnames(poptable)[2] <- "Country"
colnames(poptable)[5] <- "% of world"

# 3.There are some strings btw [] in country names column. get rid of those:

poptable[,2] <- gsub("\\[.*\\]", "", poptable[,2])

# 4. Show that you can get the difference btw two dates. Choose two dates by yourself
difftime(subset(poptable, Country =="China")$Date,subset(poptable, Country =="Turkey")$Date)

# 5. Get the difference btw the population of some countries you choose: ex.China-USA,  Turkey-USA:
subset(poptable, Country =="China")$Population-subset(poptable, Country =="Turkey")$Population
subset(poptable, Country =="Brazil")$Population-subset(poptable, Country =="Russia")$Population

# 6. Find the most crowded country
max_pop <- max(poptable$Population)
subset(poptable, Population==max_pop)$Country
#which.max(poptable$Population)


# 7. Extract the countries whose population is greater than 100000000 and assign it to 
#    a new data frame called"pop_crowded"
pop_crowded <-subset(poptable, Population>10^8)

# 8. Draw the barplot of these countries (pop_crowded) such that:
#    Y axis is the population, and X axis indicates the countries
#    You can google search or go to http://www.theanalysisfactor.com/r-11-bar-charts/  for help
barplot(pop_crowded$Population, xlab="COUNTRY", ylab="POPULATION", names.arg=pop_crowded$Country) 
