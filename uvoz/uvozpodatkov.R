
#SARA KOVAČIČ, Gozdarstvo v Sloveniji in njenih sosednjih državah

# 2. faza: Uvoz podatkov

# Uvoz csv tabele iz eurostata


stolpci <- c("Leto","Država","enota","gozd", "Površina gozda", "zastava")
povrsina_gozda <- read_csv("podatki/forestarea.csv")
                                   
#povrsina_gozda$enota <- NULL
#povrsina_gozda$gozd <- NULL
#povrsina_gozda$zastava <- NULL

