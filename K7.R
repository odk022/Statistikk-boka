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