# Analiza podatkov s programom R, 2017/18

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2017/18

## Gozdarstvo v Sloveniji in njenih sosednjih državah

Analizirala bom površino gozdov v Sloveniji skozi čas in podatke primerjala s sosednjimi državami (Avstrijo, Madžarsko, Hrvaško in Italijo). Za Slovenijo bom podrobneje analizirala posek, letni prirastek, zaloge lesa ter število gozdov (in ha) kmetijskih gospodarstev po slovenskih regijah. Med omenjenimi državami bom primerjala število zaposlenih v gozdarstvu skozi čas, glede na stopnjo izobrazbe in spol. V analizo bom vključila tudi tabelo, ki prikazuje delež zaščitenih gozdov v državah. 

Podatkovne vire sem pridobila iz spletnih strani SURS in EUROSTAT in se nahajajo v mapi podatki. Pridobila sem 4 csv tabele in eno oblike htm. 

**Zasnova TIDY DATA oblike:**

*1.tabela:* Stolpci: Leto, država, površina gozda

*2. tabela:* Stolpci: Leto, država, izobrazba, spol 

*3.tabela:* Stolpci: Leto, površina gozda, letni prirastek, posek lesa, lesna zaloga

*4.tabela:* Stolpci: Leto, regija, površina gozda, število kmetij

*5.tabela:* Stolpci: Leto, država, delež zaščitenega gozda

**Plan dela**  
- razvrščanje (iskanje skupin podatkov, ki so si podobni - npr. v državi, ki ima večji delež površine gozda, je več zaposlenih v gozdarstvu)
- predikcija (napovedovanje zaposljivosti v gozdarski panogi, glede na trende spreminjanja površine gozdov, napovedovanje spreminjanja površine gozdov glede na trende iz preteklosti)

## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`. Ko ga prevedemo,
se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`. Podatkovni
viri so v mapi `podatki/`. Zemljevidi v obliki SHP, ki jih program pobere, se
shranijo v mapo `../zemljevidi/` (torej izven mape projekta).

## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti sledeče pakete za R:

* `knitr` - za izdelovanje poročila
* `rmarkdown` - za prevajanje poročila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `DT` - za prikaz interaktivne tabele
* `maptools` - za uvoz zemljevidov
* `sp` - za delo z zemljevidi
* `digest` - za zgoščevalne funkcije (uporabljajo se za shranjevanje zemljevidov)
* `readr` - za branje podatkov
* `rvest` - za pobiranje spletnih strani
* `reshape2` - za preoblikovanje podatkov v obliko *tidy data*
* `dplyr` - za delo s podatki
* `gsubfn` - za delo z nizi (čiščenje podatkov)
* `ggplot2` - za izrisovanje grafov
* `extrafont` - za pravilen prikaz šumnikov (neobvezno)
