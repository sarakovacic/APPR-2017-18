# 3. faza: Vizualizacija podatkov

library(ggplot2)
library(dplyr)
library(readr)
library(tibble)
library(shiny)

# Uvozimo zemljevid.


  

# Graf, ki prikazuje delež zaščitenega gozda v državah

g1 <- ggplot(zascita) + aes(x = leto, y = Percentage, color = drzava) + geom_line()
print(g1)

