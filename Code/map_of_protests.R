#### Prepared for PS239T Final Project: Map of Protests in Brazil (March-August 2014)
#### Author: Liz McKenna

#prepare workspace
rm(list = ls())
setwd("/Users/lizmckenna/Desktop/PolSci-Fall_2015/PS239T2")          
getwd()

#install and call spatial data packages
library(maptools)
library(maps)
library(classInt)
library(RColorBrewer)
library(ggplot2)
library(maps)
library(ggmap)

#upload csv with lat/lon data of the 10 cities in question
cities <- read.csv("cities3.csv")
head(cities)
str(cities)

#make a black and white map with different colored dots for each city
brazil_map_bw <-get_map('Brazil',zoom=4,color="bw")
brazil_map_bw

cities_map_bw <- ggmap(brazil_map_bw) +
  geom_point(aes(x = long, y = lat, size = 4, color = I(city)), 
  data = cities, alpha = .9)    

cities_map_bw

#make a hybrid terrain/satellite map with different colored dots for each city \
#scaled by number of protests
brazil_map_hybrid <-get_map('Brazil',zoom=4, maptype = c("hybrid"))
brazil_map_hybrid

cities_map_hybrid <- ggmap(brazil_map_hybrid) +
  geom_point(aes(x = long, y = lat, size = protests, color = I(city)), 
             data = cities, alpha = .9)  

cities_map_hybrid

# adjust the size of proportional dots using scale_size_continuous
m1 <- ggmap(brazil_map_hybrid) +
      geom_point(aes(x = long, y = lat, size = protests, color = I(city)),
      data = cities, alpha = 1) +
      scale_size_continuous(range = c(5,20))
m1

#add a title
m2 <- m1 + labs(title = "Protests in Brazil, March-August 2014") + 
  theme(plot.title = element_text(family = "Times", color="black", face="bold", size=25, hjust=0))
m2

#do the same thing but in b/w
m3 <- ggmap(brazil_map_bw) + 
  geom_point(aes(x = long, y = lat, size = protests),
  color = "black", data = cities, alpha = 1) +
  scale_size_continuous(range = c(5,20))
m3

#add a title
m4 <- m3 + labs(title = "Protests in Brazil, March-August 2014") + 
  theme(plot.title = element_text(family = "Times",color="black", 
                                  face="bold", size=25, hjust=0))
m4
