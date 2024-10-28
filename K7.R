# KAP 7 LINEÆR REGRESJONSANALYSE
## setup
library(tidyverse)
library(rnorsk)
theme_set(theme_rnorsk())
data("leilighet")
head(leilighet)

# pris som avhengig variabel y og stoerrelse som uavhengig variabel x

lm(pris ~ stoerrelse, leilighet)

model01 <- lm(pris ~ stoerrelse, leilighet)
summary(model01)
mean(leilighet$pris)

# Gjennomgang av resultatene:
# Residual standard error er 849800 betyr at observerte leiligheter i snitt er
# 849' kroner unna regresjonslinjen. 

# R_squared er 0.5989 som betyr at modellen forklarer ca 60 % av variasjonen i
# leilighetspriser

# konfidensintervallet
confint(model01)

# predikering
xvals <- data.frame(stoerrelse=c(60, 80, 100, 120, 140, 
                                 160, 180, 200, 220)) # verdiene som skal predikeres
predvals <- predict(model01, newdata = xvals, 
                    interval = "confidence", level = 0.95)
xvals_pvals <- cbind(xvals, predvals)
xvals_pvals

# grafisk
ggplot(xvals_pvals, aes(x=stoerrelse, y=fit)) +
  geom_smooth(aes(ymin = lwr, ymax = upr), 
              stat = "identity") 

# Multippel regresjonsanalyse

# Beta_0 angir gjennomsnittlig Y når alle de avhengige variablene er 0
# Regresjonskoeffisienten Beta_1 viser hvor mye Y endres som følge av en enhets 
# endring i X_1 ved å holde verdiene til de andre uavhengige variablene konstante.


# F-test
# Dersom p-verdien knyttet til vår F-verdi er lavere enn signifikansnivået, kan vi
# forkaste H_0 og støtte H_1.

# Justert R^2
# Justert R^2 vil synke dersom det legges til variabler som ikke har betydning for
# forklaringskraften til modellen.

# Partiell regresjonskoeffisient
# Alle regresjonskoeffisientene er gitt at de andre variablene holdes konstant.

# Eksempler
data(gave)
head(gave)
# lager multippel modell:
model02<- lm(gave_verdi ~ attraktiv + snill + alder,  data = gave)
summary(model02)
# konfidensintervallet
confint(model02)
sd(gave$gave_verdi)
# standardiserte koeffisienter:
library(lm.beta)
lm.beta(model02)

# standardisere alle variablene
gave_stand<- data.frame(scale(gave))
# lager ny modell med disse
model03<- lm(gave_verdi ~ attraktiv + snill + alder,  data = gave_stand)
summary(model03)
confint(model03)

# Tolkning av model02:
# - Residualt standardavvik er ca 763, dette tyde på at observerte gave-verdi i 
# snitt er 763 kroner unna estimert/predikert gave_verdi
# - Høy justert R^2 tilsier at modellen passer godt til dataene
# - F_testen. Vi ser at p-verdien er langt under sigifikansnivået på 5% 

# Verdien på de standariserte tilsier at de har stor effekt.
# sammenlikne størrelsen på disse ved å bruke glht():

library(multcomp)
comp1<- glht(model03,linfct = c("attraktiv - snill = 0"))
summary(comp1)

comp2<- glht(model03,linfct = c("attraktiv - alder = 0"))
summary(comp2)

comp3<- glht(model03,linfct = c("snill - alder = 0"))
summary(comp3)

# Kan bestemme den relative viktigheten til uavhengige variabler ved å bestemme den 
# kvadrerte semipartielle korrelasjon.
library(relaimpo)
calc.relimp(model02, type="last")
# Vi ser at de uavhengige variablene forklarer henholdsvis 11, 9 og 8 % av 
# variasjonen i den avhengige variablen 

# Prediksjoner
xsvals<- data.frame(attraktiv=7, snill=7, alder=50)# setter verdier på variablene
predval <- predict(model02, newdata = xsvals, 
                   interval = "confidence", level = 0.95)
xsvals_pval <- cbind(xsvals, predval)
xsvals_pval

# Se på hva skjer med en variabel når de andre holdes konstant:
xsvals2 <- data.frame(attraktiv=c(1,2,3,4,5,6,7), 
                      snill=mean(gave$snill), 
                      alder=mean(gave$alder))
predval2 <- predict(model02, newdata = xsvals2, 
                    interval = "confidence", 
                    level = 0.95)
xsvals_pval2 <- cbind(xsvals2, predval2)
xsvals_pval2

# Dette kan vi plotte:
ggplot(xsvals_pval2, aes(x=attraktiv, y=fit)) +
  geom_smooth(aes(ymin = lwr, ymax = upr), 
              stat = "identity") 

# Kan lage fine tabeller med stargazer:
library(stargazer)
stargazer(model02, type="text", 
          keep.stat=c("n", "rsq"),
          out="model.txt")

# Regresjonsdianostikk
# handler om hvorvidt en modell passer til dataene
# Forutsetningene:
# 1. additivitet og linearitet
# 2. uavhengighet mellom feilledd (hvis dataene dwlvis kommer fra samme person er dette brutt)
# 3. lik varians av feilleddet(homoskedastisitet) (lik for alle verdier av den uavhengige var)
# 4. normalfordeling av feilleddene
# viktist er linearitet

# sjekke utliggere og disse sin betydning for den avhengige variablen
# bruker plot()
plot(model02)
# Oversikt
regression.diagnostics(model02)

gave2 <- gave %>%
  add_row(gave_verdi=20000, attraktiv=1, snill=8, alder=2)
model02.utligger <- lm(gave_verdi ~ attraktiv + snill + alder, 
                       data=gave2)
regression.diagnostics(model02.utligger) 



