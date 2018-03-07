
#SARA KOVAČIČ, Gozdarstvo v Sloveniji in njenih sosednjih državah

# 2. faza: Uvoz podatkov

library(rvest)
library(readr)
library(dplyr)
library(tidyr)
library(XML)
library(reshape2)

# Uvoz prve csv tabele iz eurostata

povrsina_gozda <- read_csv("podatki/forestarea.csv", locale = locale(encoding = "Windows-1250"), 
                           col_names = c("leto","drzava","enota","gozd","povrsina","zastava"),
                           skip = 1)
                                   
povrsina_gozda$enota <- NULL
povrsina_gozda$gozd <- NULL
povrsina_gozda$zastava <- NULL

povrsina_drzav <- matrix(c("Croatia", 5659.4, "Italy", 30133.8, "Hungary", 9303, "Austria", 8387.9 , "Slovenia", 2027.3), ncol = 2, byrow=TRUE)
colnames(povrsina_drzav) <- c("drzava","velikostdrzave")

nova <-  merge(povrsina_gozda, povrsina_drzav)
nova$velikostdrzave = as.factor(nova$velikostdrzave)


delez_povrsin <- mutate(nova, delez=(povrsina/velikostdrzave)*100)
View(delez_povrsin)

#Uvoz druge csv tabele iz eurostata 

stolpci <- c("GEO","ISCED11","TIME","SEX","UNIT","WSTATUS","NACE_R2","Value","Flag and Footnotes")
zaposlitev <- read_csv("podatki/zaposlitev v gozdarstvu vse drzave.csv.csv", locale = locale(encoding = "Windows-1250"),
                       col_names = c("Država", "izobrazba", "leto", "spol", "enota", "status", "bv", "vrednost", "zastava"),
                       skip = 1,  na = c("",":") )

zaposlitev$zastava <- NULL
zaposlitev$enota <- NULL
zaposlitev$bv <- NULL
zaposlitev$status <- NULL

#Uvoz tretje csv tabele iz SURS-a (nastaneta 2)

gozd_slo <- read_csv2("podatki/gozdvslo.csv", locale = locale(encoding = "Windows-1250"),
                      skip = 2, n_max = 4) %>%
  melt(id.vars = 1, variable.name = "leto", value.name = "kolicina") %>%
  mutate(leto = parse_number(leto))
colnames(gozd_slo)[1] <- "meritev"

povrsina_gozda_slo <- gozd_slo %>% filter(meritev == "Površina gozda (ha)") %>%
  select(leto, povrsina = kolicina)

gozd_slo <- gozd_slo %>% filter(meritev != "Površina gozda (ha)")
 


#Uvoz cetrte tabele (.htm)

regije <- read_html("podatki/regije.htm", encoding = "Windows-1250") %>%
  html_node(xpath="//table") %>% html_table(fill = TRUE)
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

regije.tidy <- regije.tidy[-c(1, 14, 27, 40, 53, 66), ]

#Uvoz pete csv tabele iz EUROSTATA

zascita <- read_csv("podatki/zascita gozdov.csv.csv", 
                    locale = locale(encoding = "Windows-1250"),
                    col_names = c("leto", "enota", "drzava", "nekaj", "vrednost", "zastava"),
                    skip = 1, na= c("",":")) %>% spread(enota, vrednost)   
zascita$nekaj <- NULL
zascita$zastava <- NULL
colnames(zascita)[colnames(zascita)=="Percentage"] <- "procent" 
colnames(zascita)[colnames(zascita)=="Thousand hectares"] <- "1000 Ha"

                  

