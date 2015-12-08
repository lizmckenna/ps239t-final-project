---
title: "Final project: 03_clean_and_categorize"
author: "Liz McKenna"
date: "Fall 2015"
output: upload R script to github repo
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
protest_cities_full <- read.csv("Code/protest_cities3.csv", header=TRUE, encoding = "UTF-8")

# subset data to include only articles that were identified with one of the 10 cities; this is the number of "hits" per city
salvador <- subset(protest_cities_full, select=c(publication, date, title, length, text, salvador), salvador==1)
belo_horizonte <- subset(protest_cities_full, select=c(publication, date, title, length, text, belo_horizonte), belo_horizonte==1)
campinas <- subset(protest_cities_full, select=c(publication, date, title, length, text, campinas), campinas==1)
brasilia <- subset(protest_cities_full, select=c(publication, date, title, length, text, brasilia ), brasilia==1)
rio <- subset(protest_cities_full, select=c(publication, date, title, length, text, rio), rio==1)
fortaleza <- subset(protest_cities_full, select=c(publication, date, title, length, text), fortaleza==1)
são_paulo <- subset(protest_cities_full, select=c(publication, date, title, length, text, sao_paulo), sao_paulo==1)
curitiba <- subset(protest_cities_full, select=c(publication, date, title, length, text, curitiba), curitiba==1)
recife <- subset(protest_cities_full, select=c(publication, date, title, length, text, recife), recife==1)
porto_alegre <- subset(protest_cities_full, select=c(publication, date, title, length, text, porto_alegre), porto_alegre==1)

#use smartbind from the gtools library to put them all into one dataframe; allows for an efficient rbind of data frames even when column names don't match
protests <- smartbind(salvador, belo_horizonte, campinas, brasilia, rio, fortaleza, são_paulo, curitiba, recife, porto_alegre)

###############################
########## DATE ###############
###############################

#convert the factor variable "date" into a character variable to then be able to perform pattern matching & replacement of portuguese words for months
protests$date <- as.character(protests$date)

#tell the machine to find all instances of "Mar\xcd_o" which is the unicode version of Março, and replace with "March"
protests$date <-gsub("Mar\xcd_o", "March", protests$date)

#rinse and repeat for the other 6 months
protests$date <-gsub("Abril", "April", protests$date)
protests$date <-gsub("Maio", "May", protests$date)
protests$date <-gsub("Julho", "July", protests$date)
protests$date <-gsub("Junho", "June", protests$date)
protests$date <-gsub("Junho", "June", protests$date)
protests$date <-gsub("Agosto", "August", protests$date)

protests$date2 <- as.factor(protests$date)
summary(protests$date2)
summary(protests$date)

# convert date info in format 'mm/dd/yyyy'
protests$date <- c("01/05/1965", "08/16/1975")
protests$date <- as.Date(protests$date, "%m/%d/%Y")
