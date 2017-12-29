
#SARA KOVAČIČ, Gozdarstvo v Sloveniji in njenih sosednjih državah

# 2. faza: Uvoz podatkov

library(rvest)
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

#Uvoz tretje csv tabele iz SURS-a
 
gozd_slo <- read_csv2("podatki/gozdvslo.csv", locale = locale(encoding = "Windows-1250"),
                     skip = 1)
gozd_slo <- gozd_slo[-c(1, 6, 7, 8, 9, 10), ]
gozd_slo2 <- as.data.frame(t(gozd_slo))

names(gozd_slo2) <- c("povrsina gozda", "letni prirastek","lesna zaloga ", "posek lesa")
gozd_slo2 <- cbind(leto = rownames(gozd_slo2), gozd_slo2) #imena vrstic v nov stolpec "leto"

gozd_slo2 <- gozd_slo2[-c(1), ] #izbris 1.vrstice
rownames(gozd_slo2) <- c()  #izbris imena vrstic

#Uvoz cetrte tabele (.htm)

# rawHTML <- paste(readLines("podatki/regije.htm")) ???

#Uvoz pete csv tabele iz EUROSTATA

zascita <- read_csv("podatki/zascita gozdov.csv.csv", 
                    locale = locale(encoding = "Windows-1250"),
                    col_names = c("leto", "enota", "drzava", "nekaj", "vrednost", "zastava"),
                    skip = 1, na= c("",":"))
zascita$nekaj <- NULL
zascita$zastava <- NULL
                    
                    

