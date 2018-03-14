# 3. faza: Vizualizacija podatkov

library(ggplot2)
library(dplyr)
library(readr)
library(tibble)
library(shiny)
library(ggpubr)


#graf, ki prikazuje spreminjanje površine gozda skozi leta v državah

g0 <- ggplot(povrsina_gozda) + aes( x = leto, y = povrsina, color = drzava) +
              geom_line(size = 1) +
              geom_point(size= 1.4) +
              xlab("Leto") + ylab("Površina gozda") +
              theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
              ggtitle("Spreminjanje površine gozda skozi leta") +
              scale_color_discrete("Država")
#print(g0) 

g00 <- ggplot(povrsina_gozda %>% filter(drzava != "Italy",
                                        drzava != "Austria"), aes( x = leto, y = povrsina, color = drzava)) +
              geom_line(size = 1) +
              geom_point(size= 1.4) +
              xlab("Leto") + ylab("Površina gozda") +
              theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
              ggtitle("Spreminjanje površine gozda skozi leta") +
              scale_color_discrete("Država")

#graf, ki prikazuje spreminjanje deleža gozda v državah 
g000 <- ggplot(delez_povrsin) + aes(x = leto, y=delez, color = drzava)+ geom_line(size = 1) +
      geom_point(size= 1.4) +
      xlab("Leto") + ylab("Delež gozda % ") +
      theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
      ggtitle("Spreminjanje deleža gozda v državah skozi leta") +
      scale_color_discrete("Država")

# Graf, ki prikazuje delež zaščitenega gozda v državah

g1 <- ggplot(zascita) + aes(x = leto, y = procent, color = drzava) + geom_line()
#print(g1)

g11 <- ggplot(zascita %>% filter(drzava != "Italy"), 
                          aes(x = leto, y = procent, color = drzava)) + geom_line(size=1.1)
# ZAPOSLITEV v letu 2014


g2 <- ggplot(zaposlitev %>%
               filter(izobrazba == "All ISCED 2011 levels",
                      leto == "2014",
                      spol != "Total"),
             aes(x = Država, y = vrednost, fill = spol)) +
  geom_bar(stat = "identity", position = "dodge") +
  ggtitle("Število 1000 zaposlenih v gozdarski panogi") +
  xlab("Država") + ylab("število zaposlenih v 1000")+
  theme(plot.title = element_text(size = 10, face = "bold"))
#print(g2)

g22 <- ggplot(delez_zaposlenih %>%
                filter(izobrazba == "All ISCED 2011 levels",
                       leto == "2014",
                       spol != "Total"),
              aes(x = Država, y = delez, fill = spol)) +
  geom_bar(stat = "identity", position = "dodge") +
  ggtitle("Delež zaposlenih v gozdarski panogi") +
  xlab("Država") + ylab("Delež zaposlenih (%)") +
  theme(plot.title = element_text(size = 10, face = "bold"))

#GOZDOVI V SLOVENIJI

g3 <- ggplot(povrsina_gozda_slo) + aes(x= leto, y = povrsina, group = 1) +
  geom_line(size=1, color = 'darkgreen') +
  geom_point(size = 1.3) +
  xlab("Leto") + ylab("Površina gozda (Ha)" ) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
  ggtitle("Spreminjanje površine-SLOVENIJA") +
  theme(plot.title = element_text(size = 10, face = "bold"))

#print(g3)

g33 <- ggplot(gozd_slo %>% filter(meritev == "Letni prirastek (1000 m3)")) +
  aes(x = leto, y = kolicina, group = 1) +
  geom_line(color = 'green', position = "jitter", size = 1.2) +
  xlab("Leto") + ylab("1000 m3") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) 
  #ggtitle("Letni prirastek (1000 m3)") +
  #theme(plot.title = element_text(size = 10, face = "bold"))

gg33 <- ggplot(gozd_slo %>% filter(meritev == "Letni prirastek (1000 m3)")) +
  aes(x = leto, y = kolicina, group = 1) +
  geom_line(color = 'green', position = "jitter", size = 1.2) +
  xlab("Leto") + ylab("1000 m3") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
  ggtitle("Letni prirastek (1000 m3)") 


g333 <- ggplot(gozd_slo %>% filter(meritev == "Posek lesa (1000 m3)")) +
  aes(x = leto, y = kolicina, group = 1) +
  geom_line(color = 'brown', position = "jitter", size = 1.2) +
  xlab("Leto") + ylab("Posek") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
  ggtitle("Letni posek (1000 m3)") +
  theme(plot.title = element_text(size = 10, face = "bold"))

gg3 <- g33 + geom_line(data= (gozd_slo %>% filter(meritev == "Posek lesa (1000 m3)")),
                       color = 'brown', position = "jitter", size = 1.2) +
  ggtitle("Letni prirastek in posek (1000 m3)") + 
  scale_colour_manual("", values = c("green", "brown")) 
  
  
  

#ggarrange(g3, g33, ncol=2, font.label = list(size = 14, face = "bold", color ="red"))

###########################################
#ZEMLJEVID
library(sp)
library(maptools)
library(digest)
gpclibPermit()

zemljevid <- uvozi.zemljevid("http://biogeo.ucdavis.edu/data/gadm2.8/shp/SVN_adm_shp.zip",
                             "SVN_adm1", encoding = "UTF8") %>% pretvori.zemljevid()


levels(zemljevid$NAME_1)[levels(zemljevid$NAME_1) %in%
                           c("Notranjsko-kraška",
                             "Spodnjeposavska")] <- c("Primorsko-notranjska", "Posavska")
#========================================================================================================

povprecje <- regije.tidy %>% group_by(regija) %>% summarise(povrsina = mean(povrsina, na.rm = TRUE))


zemljevid.regije1 <- ggplot() +
  geom_polygon(data = povprecje %>% right_join(zemljevid, by = c("regija" = "NAME_1")),
               aes(x = long, y = lat, group = group, fill = povrsina))+
  xlab("") + ylab("") + ggtitle("Površina gozdov kmetijskih gospodarstev po regijah ")


zemljevid.regije1 <- zemljevid.regije1 + scale_fill_gradient(low = "lightgreen", high = "darkgreen", space = "Lab",
                                        na.value = "grey50", guide = "colourbar")

#print(zemljevid.regije1) 

povprecje2 <- delez_povrsin_regij %>% group_by(regija) %>% summarise(delez = mean(delez, na.rm = TRUE))

zemljevid.delez <- ggplot()+ 
  geom_polygon(data = povprecje2 %>% right_join(zemljevid, by = c("regija" = "NAME_1")),
                                          aes(x = long, y = lat, group = group, fill = delez))+
  xlab("") + ylab("") + ggtitle("Delež gozda kmetijskih gospodarstev v slovenskih regijah (%)")

zemljevid.delez <- zemljevid.delez + scale_fill_gradient(low = "lightgreen", high = "darkgreen", space = "Lab",
                                                             na.value = "grey50", guide = "colourbar")  

#Zemljevid, ki prikazuje povprečno število "gozdarskih kmetij" v regiji 

povprecjekmetij <- regije.tidy %>% group_by(regija) %>% summarise(stevilo = mean(stevilo, na.rm =TRUE))

zemljevid.regije2<-ggplot() +
  geom_polygon(data = povprecjekmetij %>% right_join(zemljevid, by = c("regija" = "NAME_1")),
               aes(x =long, y = lat, group = group, fill = stevilo))

zemljevid.regije2 <- zemljevid.regije2 + scale_fill_gradient2(low = "yellow", mid ="green", high = "darkgreen", space = "Lab",
                                                            na.value = "grey50", guide = "colourbar")
#print(zemljevid.regije2)