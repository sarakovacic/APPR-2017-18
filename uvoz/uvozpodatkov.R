
#SARA KOVAČIČ, Gozdarstvo v Sloveniji in njenih sosednjih državah

# 2. faza: Uvoz podatkov

library(rvest)
library(gsubfn)
library(readr)
library(dplyr)

# Uvoz prve csv tabele iz eurostata

stolpci <- c("Leto","Država","enota","gozd", "Površina gozda", "zastava")
povrsina_gozda <- read_csv("podatki/forestarea.csv", locale = locale(encoding = "Windows-1250"), 
                           col_names = c("Leto","Drzava","enota","gozd","Povrsina gozda","Zastava"),
                           skip = 1)
                                   
povrsina_gozda$enota <- NULL
povrsina_gozda$gozd <- NULL
povrsina_gozda$Zastava <- NULL

#Uvoz druge csv tabele iz eurostata 

stolpci <- c("GEO","ISCED11","TIME","SEX","UNIT","WSTATUS","NACE_R2","Value","Flag and Footnotes")
zaposlitev <- read_csv("podatki/zaposlitev v gozdarstvu vse drzave.csv.csv", locale = locale(encoding = "Windows-1250"),
                       col_names = c("Država", "izobrazba", "leto", "spol", "enota", "status", "bv", "vrednost", "zastava"),
                       skip = 1,  na= c("",":") )

zaposlitev$zastava <- NULL
zaposlitev$enota <- NULL
zaposlitev$bv <- NULL
zaposlitev$status <- NULL
