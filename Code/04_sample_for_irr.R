---
title: "Final project: 04_sample_for_irr"
author: "Liz McKenna"
date: "Fall 2015"
output: "upload R script to github repo"
---
  
### setup environment
setwd("/Users/lizmckenna/Desktop/ps239t-final-project")
getwd()
rm(list=ls())

#read in analysis dataset; complete list of protest events
irr_full <- read.csv("Data/analysis_dataset.csv", header=TRUE, encoding = "UTF-8")

#subset to a stratified sample of articles (weighted by city observations)


#here was my attempt to write a function to do this but alas, it didn't work
irr.sample <- function(x,y)
{
  city.subset <- subset(mydata, city=='x')
  city.irr <- city.subset[sample(1:nrow(city.subset), y, replace = TRUE)]
}

#...also not working
subset <- function(x){
  x.subset <- subset(irr_full, city =="x")
  return x.subset
  }

#subset by city
bh = subset(irr_full, city == 'belo_horizonte')
brasilia = subset(irr_full, city == 'brasilia')
sao_paulo = subset(irr_full, city == 'sao_paulo')
rio = subset(irr_full, city == 'rio')
campinas = subset(irr_full, city == 'campinas')
curitiba = subset(irr_full, city == 'curitiba')
fortaleza = subset(irr_full, city == 'fortaleza')
recife = subset(irr_full, city == 'recife')
porto_alegre = subset(irr_full, city == 'porto_alegre')
salvador = subset(irr_full, city == 'salvador')

dim(salvador)[1]/dim(irr_full)[1]*100

bh_irr <- bh[sample(1:nrow(bh), 3,replace=FALSE),]
bras_irr <- brasilia[sample(1:nrow(brasilia), 6,replace=FALSE),]
cur_irr <- curitiba[sample(1:nrow(curitiba), 2,replace=FALSE),]
camp_irr <- campinas[sample(1:nrow(campinas), 1,replace=FALSE),]
fort_irr <- fortaleza[sample(1:nrow(fortaleza), 2,replace=FALSE),]
pa_irr <- porto_alegre[sample(1:nrow(porto_alegre), 2,replace=FALSE),]
rec_irr <- recife[sample(1:nrow(recife), 2,replace=FALSE),]
rio_irr <- rio[sample(1:nrow(rio), 12,replace=FALSE),]
sal_irr <- salvador[sample(1:nrow(salvador), 2,replace=FALSE),]
sp_irr <- sao_paulo[sample(1:nrow(sao_paulo), 13,replace=FALSE),]

irr <- rbind(bh_irr, bras_irr, cur_irr, camp_irr, fort_irr, pa_irr, rec_irr, rio_irr, sal_irr, sp_irr)

#### write file to import to qualtrics for raters to process #####
write.csv(irr,"Data/irr_sample.csv",row.names = F) # write all
