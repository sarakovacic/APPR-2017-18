# 4. faza: Analiza podatkov
library(ggplot2)
library(dplyr)
library(readr)
library(tibble)
library(shiny)

#predvidevanje gibanja površine gozda v Sloveniji
nekaj <- g3 + geom_smooth(method = "loess")
lin <- lm(data = povrsina_gozda_slo ,  povrsina ~ leto )
predict(lin, data.frame(leto=seq(2017,2025)))

#izris napovedi
nova <- data.frame(leto=seq(2017,2025))
napoved <- nova %>% mutate(povrsina=predict(lin,.))


napovedni_graf <- ggplot(povrsina_gozda_slo, aes(x = leto, y = povrsina)) + 
      geom_point(shape=1) + 
      geom_smooth(method=lm) +
      geom_point(data=napoved, aes(x = leto, y = povrsina), color='green', size=2)

# predvidevanje gibanja letnega prirastka površine gozda - Slovenija

nekaj1 <- g33 + geom_smooth(method = "loess")
lin2 <- lm(data = prirastek,  kolicina ~ leto )
predict(lin2, data.frame(leto=seq(2017,2025)))

#izris napovedi
nova2 <- data.frame(leto=seq(2017,2025))
napoved_prirastek <- nova2 %>% mutate(kolicina=predict(lin2,.))


napovedni_graf_prirastek <- g33 + geom_smooth(method=lm) + geom_point(data=napoved_prirastek, aes(x = leto, y = kolicina), color='green', size=2)


