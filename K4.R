library(tidyverse)
ChickWeight
head(ChickWeight,3)
ChickWeight2<-mutate(ChickWeight,log_weight=log(weight)) # lager ny variabel med mutate
head(ChickWeight2)

ChickWeight2<-mutate(ChickWeight2,int_time_weight=Time*weight) # lager ny variabel
head(ChickWeight2)

# Rekoding
class(ChickWeight2$weight)

ChickWeight2<-
  mutate(ChickWeight,
         weight5 = case_when(weight <= 50 ~ 1,
                            weight > 50 & weight <= 100 ~ 2,
                            weight > 100 & weight <= 150 ~ 3,
                            weight > 150 & weight <= 200 ~ 4,
                            TRUE ~ 5))
head(ChickWeight2,5)

# Lage faktorvariabel
ChickWeight2<-
  mutate(ChickWeight2,
         weight5_2 =
           factor(weight5,
                  levels = c(1,2,3,4,5),
                  labels = c("veldig liten", "liten",
                             "medium", "stor",
                             "veldig stor")))

class(ChickWeight2$weight5_2)
head(ChickWeight2)

# Erstatte verdier i variabler
ChickWeight2<- mutate(ChickWeight2,
                      weight = replace(weight, weight==42, 144)) # erstatter verdien 42 med 144 i weight-variablen
head(ChickWeight2)

# Kan utvide denne funksjonen:
ChickWeight2<- mutate(ChickWeight2,
                      weight = replace(weight, weight==93, 555),
                      Time = replace(Time, Time ==0, 30),
                      Diet = replace(Diet, Diet ==1,2)) 
head(ChickWeight2)

# Kan erstatte verdier basert på betingelser. Anta at vi vil endre verdien i variablen weight til 2222
# for observasjoner/rader som har verdien 8 i variablen Time og verdien 2 i variablen Diet. Dette gir oss:

ChickWeight2<- mutate(ChickWeight2,
                      weight = replace(weight, Time==8 & Diet == 2,2222))
# Ett tilfelle, på rad 5
head(ChickWeight2)

# Erstatte flere verdier til manglende verider:
ChickWeight2<- mutate(ChickWeight2,
                      weight = replace(weight, weight< 60, NA),
                      Time = replace(Time, Time >= 10, NA))
head(ChickWeight2)

# Endre navn på variabler:
names(ChickWeight2)
ChickWeight2<- rename(ChickWeight2, Chick_number = Chick) # nytt navn først

head(ChickWeight2)
# Utvide dette:
ChickWeight2<- rename(ChickWeight2, weight_gr = weight,
                      days = Time,
                      diet_rec = Diet)
head(ChickWeight2)

# Manglende verdier:
colSums(is.na(ChickWeight2))

# Vi ser at weight_gr og days mangler hhv 111 og 381 verdier
# Hvilke observasjoner mangler verdier?
which(is.na(ChickWeight2$weight_gr))
# og for days
which(is.na(ChickWeight2$days))

# Motsatt - fullstendige verdier per variabel
colSums(!is.na(ChickWeight2)) # utropstegnet er negasjon

# Hvor mange komplette målinger er det i datasettet?
sum(complete.cases(ChickWeight2))

# Håndtering av manglende verdier
# 1. Fjerne  - listevis utelating


# 2. Erstatte dem med gjennomsnitt, nærmeste nabo-imputasjon eller multippel imputasjon

# fjerner manglende verdier underveis:
mean(ChickWeight2$weight_gr)
# får NA og fjerner derfor NA i datasettet
mean(ChickWeight2$weight_gr, na.rm = TRUE)

# Denne funksjonen utelater NA automatisk:
summary(ChickWeight2$weight_gr)

# brukt sammen med lm-funksjonen:
summary(lm(weight_gr ~ days, data=ChickWeight2)) 

# Anbefaler ikke å fjerne observasjoner listevis på forhånd.
ChickWeight3<- na.omit(ChickWeight2)
dim(ChickWeight3) # gir oss antall rader og kolonner

# generere dummy-variabel - inneholder to verdier, 0 og 1
# bruker variablen diet_rec som har 4 kategorier
# lager først et objekt som kan betraktes som et datasett:
dummy<- model.matrix(~ diet_rec + 0, data= ChickWeight2)
head(dummy)
# Dette må da legges inn i datasettet ChickWeight2

# Kunne også ha brukt mutate og if_else
ChickWeight2<- mutate(ChickWeight2,
                      diet_rec1=if_else(diet_rec==1, 1,0),
                      diet_rec2=if_else(diet_rec==2, 1,0),
                      diet_rec3=if_else(diet_rec==3, 1,0),
                      diet_rec4=if_else(diet_rec==4, 1,0) )
head(ChickWeight2)
# Vi ser at dummy-variablen kommer rett inn i datasettet her

# Endre datatyen til variabler:

