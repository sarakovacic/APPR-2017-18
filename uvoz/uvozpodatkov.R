
#SARA KOVAČIČ, Gozdarstvo v Sloveniji in njenih sosednjih državah

# 2. faza: Uvoz podatkov

library(rvest)
library(readr)
library(dplyr)
library(tidyr)

# Uvoz prve csv tabele iz eurostata

povrsina_gozda <- read_csv("podatki/forestarea.csv", locale = locale(encoding = "Windows-1250"), 
                           col_names = c("leto","drzava","enota","gozd","Povrsina gozda","zastava"),
                           skip = 1)
                                   
povrsina_gozda$enota <- NULL
povrsina_gozda$gozd <- NULL
povrsina_gozda$zastava <- NULL

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

regije <- read_html("podatki/regije.htm", encoding = "Windows-1250") %>%
  html_node(xpath="//table") %>% html_table()
leta <- regije[1, ] %>% unlist()
stolpci <- regije[2, ] %>% unlist()
stolpci.povrsina <- grep("ha", stolpci)
stolpci.stevilo <- grep("kmetijskih", stolpci)
regije.povrsina <- regije[regije[, 1] == "Gozd", c(2, stolpci.povrsina)]
regije.stevilo <- regije[regije[, 1] == "Gozd", c(2, stolpci.stevilo)]
colnames(regije.povrsina) <- c("regija", leta[stolpci.povrsina])
colnames(regije.stevilo) <- c("regija", leta[stolpci.stevilo])
regije.tidy <- inner_join(melt(regije.povrsina, id.vars = "regija",
                               variable.name = "leto", value.name = "povrsina"),
                          melt(regije.stevilo, id.vars = "regija",
                               variable.name = "leto", value.name = "stevilo")) %>%
  mutate(leto = parse_number(leto),
         povrsina = parse_number(povrsina, na = "N"),
         stevilo = parse_number(stevilo, na = "N"))
Encoding(regije.tidy$regija) <- "UTF-8"

#Uvoz pete csv tabele iz EUROSTATA

zascita <- read_csv("podatki/zascita gozdov.csv.csv", 
                    locale = locale(encoding = "Windows-1250"),
                    col_names = c("leto", "enota", "drzava", "nekaj", "vrednost", "zastava"),
                    skip = 1, na= c("",":"))
zascita$nekaj <- NULL
zascita$zastava <- NULL
                    
                    

