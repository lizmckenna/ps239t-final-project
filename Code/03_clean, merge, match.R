---
title: "Final project: 03_clean_and_categorize"
author: "Liz McKenna"
date: "Fall 2015"
output: "upload R script to github repo"
---
  
### setup environment
setwd("/Users/lizmckenna/Desktop/ps239t-final-project")
getwd()
rm(list=ls())


### load packages
library(tm) # framework for text mining
library(RTextTools) # a machine learning package for text classification written in R
library(qdap) # Quantiative discourse analysis of transcripts
library(qdapDictionaries)
library(dplyr) # Data preparation and pipes $>$
library(ggplot2) # for plotting word frequencies
library(SnowballC) # for stemming
library(utils)
library(gtools)


###############################
########## LOAD DATA ##########
###############################

## read in data from city_query.py result
protest_cities_full <- read.csv("Data/protest_cities.csv", header=TRUE, encoding = "UTF-8")

# subset data to include only articles that were identified with one of the 10 cities; this is the number of "hits" per city
salvador <- subset(protest_cities_full, select=c(publication, date, title, length, text, salvador), salvador==1)

#replace 1s with the name of the city; rename column to "city" so that we can rbind 'em all later.
#there is most definitely a way to do this with a function/for loop...here's my old-fashioned way:
salvador$salvador <-gsub("1", "salvador", salvador$salvador)
colnames(salvador)[6] <- "city" 

#rinse and repeat
belo_horizonte <- subset(protest_cities_full, select=c(publication, date, title, length, text, belo_horizonte), belo_horizonte==1)
belo_horizonte$belo_horizonte <-gsub("1", "belo_horizonte", belo_horizonte$belo_horizonte)
colnames(belo_horizonte)[6] <- "city" 

campinas <- subset(protest_cities_full, select=c(publication, date, title, length, text, campinas), campinas==1)
campinas$campinas <-gsub("1", "campinas", campinas$campinas)
colnames(campinas)[6] <- "city" 

brasilia <- subset(protest_cities_full, select=c(publication, date, title, length, text, brasilia ), brasilia==1)
brasilia$brasilia <-gsub("1", "brasilia", brasilia$brasilia)
colnames(brasilia)[6] <- "city" 

rio <- subset(protest_cities_full, select=c(publication, date, title, length, text, rio), rio==1)
rio$rio <-gsub("1", "rio", rio$rio)
colnames(rio)[6] <- "city" 

fortaleza <- subset(protest_cities_full, select=c(publication, date, title, length, text, fortaleza), fortaleza==1)
fortaleza$fortaleza <-gsub("1", "fortaleza", fortaleza$fortaleza)
colnames(fortaleza)[6] <- "city" 

sao_paulo <- subset(protest_cities_full, select=c(publication, date, title, length, text, sao_paulo), sao_paulo==1)
sao_paulo$sao_paulo <-gsub("1", "sao_paulo", sao_paulo$sao_paulo)
colnames(sao_paulo)[6] <- "city" 

curitiba <- subset(protest_cities_full, select=c(publication, date, title, length, text, curitiba), curitiba==1)
curitiba$curitiba <-gsub("1", "curitiba", curitiba$curitiba)
colnames(curitiba)[6] <- "city" 

recife <- subset(protest_cities_full, select=c(publication, date, title, length, text, recife), recife==1)
recife$recife <-gsub("1", "recife", recife$recife)
colnames(recife)[6] <- "city" 

porto_alegre <- subset(protest_cities_full, select=c(publication, date, title, length, text, porto_alegre), porto_alegre==1)
porto_alegre$porto_alegre <-gsub("1", "porto_alegre", porto_alegre$porto_alegre)
colnames(porto_alegre)[6] <- "city" 


#use smartbind from the gtools library to put them all into one dataframe; allows for an efficient rbind of data frames even when column names don't match
protests <- smartbind(salvador, belo_horizonte, campinas, brasilia, rio, fortaleza, sao_paulo, curitiba, recife, porto_alegre)
sum(is.na(protests$city)) #0

###############################
########## DATE ###############
###############################

#convert the factor variable "date" into a character variable to then be able to perform pattern matching & replacement of portuguese words for months
protests$date <- as.character(protests$date)

#tell the machine to find all instances of "Mar\xcd_o" which is the unicode version of Março, and replace with "March"
protests$date <-gsub("Mar\xcd_o", "March", protests$date)

#rinse and repeat for the other 6 months and problematic variants thereof
protests$date <-gsub("Maio", "May", protests$date)
protests$date <-gsub("Julho", "July", protests$date)
protests$date <-gsub("Junho", "June", protests$date)
protests$date <-gsub("Junho", "June", protests$date)
protests$date <-gsub("Agosto", "August", protests$date)
protests$date <-gsub("-14", "", protests$date)
protests$date <-gsub("-", " ", protests$date)
protests$date <-gsub("Mar", "March", protests$date)
protests$date <-gsub("Marchch", "March", protests$date)
protests$date <-gsub("Apr", "April", protests$date)
protests$date <-gsub("Aprilil", "April", protests$date)
protests$date <-gsub("Abril", "April", protests$date)
protests$date <-gsub("Jun", "June", protests$date)
protests$date <-gsub("Junee", "June", protests$date)
protests$date <-gsub("Jul", "July", protests$date)
protests$date <-gsub("Julyy", "July", protests$date)
protests$date <-gsub(" 2014", "", protests$date)

protests$date
summary(protests$date)


# re-code all blanks in date column as NA
protests$date[protests$date==""] = NA 
sum(is.na(protests$date)) #82; gonna keep these around for now


#R kept crashing when I toggled over to the full df of metadata + articles; so I'll start by
#subetting to clean *only* the date column sch that i can convert it into a julian date
date_only <- subset(protests, select=c(date))

date_only$date <- gsub("March","Mar14",date_only$date)
date_only$date <- gsub("April","Apr14",date_only$date)
date_only$date <- gsub("May","May14",date_only$date)
date_only$date <- gsub("June","Jun14",date_only$date)
date_only$date <- gsub("July","Jul14",date_only$date)
date_only$date <- gsub("August","Aug14",date_only$date)
date_only$date <- gsub("1414","14",date_only$date)
date_only$date <- gsub(" ","",date_only$date)

#reassign cleaned observations back to the original df
protests$date <- date_only$date

protests["julian_date"] <- NA # create a new column filled with NA
protests$julian_date <- as.date(protests$date)


###
folha$date <- gsub("Apr", "Apr14", folha$date)
folha$date <- gsub("May", "May14", folha$date)
folha$date <- gsub("Jun", "Jun14", folha$date)
folha$date <- gsub("Jul", "Jul14", folha$date)
folha$date <- gsub("Aug", "Aug14", folha$date)
folha$date <- gsub(" ", "", folha$date)



#load second dataframe (folha protests) with which lexisnexis articles will be matched
folha <- read.csv("Data/folha.csv", header=TRUE, encoding = "UTF-8")
folha$date <- as.character(folha$date)
folha$date <-gsub("-", "", folha$date)
folha$city <- as.character(folha$city)


folha$date <- gsub("Mar","Mar14",folha$date)
folha$date <- gsub("Apr", "Apr14", folha$date)
folha$date <- gsub("May", "May14", folha$date)
folha$date <- gsub("Jun", "Jun14", folha$date)
folha$date <- gsub("Jul", "Jul14", folha$date)
folha$date <- gsub("Aug", "Aug14", folha$date)
folha$date <- gsub(" ", "", folha$date)

folha["julian_date"] <- NA # create a new column filled with NA
folha$julian_date <- as.date(folha$date)


mydata <- merge(folha, protests, by=c("city","date")) 
all_protests <- smartbind(folha, protests) #1,428 observations of 6 variables
all_protests$date <-gsub(" March", "Mar14", all_protests$date)
all_protests$date <-gsub(" Apr", "Apr14", all_protests$date)
all_protests$date <-gsub(" May", "May14", all_protests$date)
all_protests$date <-gsub(" Jun", "Jun14", all_protests$date)
all_protests$date <-gsub(" Jul", "Jul14", all_protests$date)
all_protests$date <-gsub(" August", "Aug14", all_protests$date)
all_protests$date <-gsub("4e", "4", all_protests$date)
all_protests$date <-gsub("4y", "4", all_protests$date)
all_protests$date <-gsub("4il", "4", all_protests$date)

all_protests["julian_date"] <- NA # create a new column filled with NA
all_protests$julian_date <- as.date(all_protests$date)

write.csv(all_protests,"Data/all_protests.csv",row.names = F) # write all

#############################
######### DETOUR ############
#############################

##conversion to Julian dates was not working on whole dataframe.
#subsetting to one city to see what the problem was:

test.df <- all_protests
salvador2 <- subset(test.df, select=c(date, publication, city), city=="salvador")
sum(is.na(salvador2$date))

#this was the problem: errant letters after the year:
salvador2$date <-gsub("4e", "4", salvador2$date)
salvador2$date <-gsub("4y", "4", salvador2$date)
salvador2$date <-gsub("4il", "4", salvador2$date)

#now add a new column with the julian date version
library(date)
salvador2["julian_date"] <- NA # create a new column filled with NA
salvador2$julian_date <- as.date(salvador2$date)


library(plyr)
n.protests <- ddply(.data=all_protests, .variables=.(city),count = summarize(date, na.rm=T))
n.protests
which(is.na(merged$region))



#### WRITE FILES #####
write.csv(all_protests,"Data/all_protests.csv",row.names = F) # write all
