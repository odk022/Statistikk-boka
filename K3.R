# Om funksjoner
var1<-c(5,3,NA,1,2,NA,3,1,2,4,3,4)
mean(var1,trim=0.1,na.rm=TRUE)
# trim=0.1 betyr ar 10 % av de høyeste og laveste verdiene er fjernet.
# na.rm=TRUE betyr at manglende verdier er fjernet

# For å ta vare på dette:
gjennomsnitt<-mean(var1,trim=0.1,na.rm=TRUE)

# Objekter
#eks:
timeloenn<-345
timeloenn_eur<-round(timeloenn/9.9)
timeloenn_eur

kjoenn<- "kvinne"
kjoenn

# Vektorer - kan betraktes som kolonner i et datasett
# et objekt som inneholder flere elementer av samme type(tall/tekst)
# bruker c-funksjonen for å lage et vektorobjekt med flere verdier

timeloenn <- c(270, 330, 655, 445, 150)
timeloenn

timeloenn1 <- c(270, 330, 655, 445, 150, 277, 338, 605, 
                415, 159, 279, 339, 555, 345, 450, 274, 
                630, 855, 745, 159, 278, 390, 855, 485, 750)
timeloenn1

# Samme med tekstvektor:
kjoenn <- c("mann", "kvinne", "mann", "mann", "kvinne")
kjoenn

# vektorisering - alle verdier omfattes av funksjonen
timeloenn_eur<-timeloenn/9.9
timeloenn_eur

log(timeloenn)

# Trekke ut elementer fra en vektor:
timeloenn3 <- c(270, 330, 655, 445, 150, 277, 338, 605, 415)
timeloenn3[4] # bruker hakeparentesen og angir leddnr.
# Trekke ut flere elementer:
timeloenn3[c(2,5)]

# ekskludere elementer: 
timeloenn3[-c(3,6)]

timeloenn3 # ser at opprinnelig vektor ikke endres

# Endre elementer i en vektor:
timeloenn4<-timeloenn3[-c(3,6)]
# Endre fjerde (150) og sjette (605) til hhv 555 og 444
timeloenn4[c(4,6)]<- c(555,444)
timeloenn4

# Datarammer - består av flere kolonner
# Eksempel:
# Lager vektorer:
timeloenn <- c(270, 330, 655, 445, 150)
respid <- c(1,2,3,4,5)
alder <- c(34, 46, 51, 39, 22)
kjoenn <- c("mann", "kvinne", "mann", "mann", "kvinne")
kjoenn<- factor(kjonn,levels = c("kvinne","mann"))
utdann <- c(10, 12, 15, 13, 8)

# Setter disse sammen i en dataframe:
data.frame(respid, timeloenn, alder, kjoenn, utdann)

# Lager et objekt
loenn_data<-data.frame(respid, timeloenn, alder, kjoenn, utdann) 
loenn_data

str(loenn_data) # gir info om datasettet

# trekke ut/endre i dataframe - bruke dplyr

# R-base
loenn_data$alder #trekker ut alder
# lagre dette
alder_fra_ld<-loenn_data$alder
alder_fra_ld

# bruke kolonneindeks:
alder_fra_ld<-loenn_data[,3] # tar alle verdiene i kolonne 3
alder_fra_ld 
# eller nav på variablen:
alder_fra_ld<-loenn_data[,"alder"] # tar alle verdiene i kolonne 3
alder_fra_ld 

# Hente flere variabler:
tlkjo_fra_ld<- loenn_data[,c("timeloenn","kjoenn")]
# eller
tlkjo_fra_ld<- loenn_data[,c(2,4)]
tlkjo_fra_ld

# Trekke fra rader:
loenn_data[4,]
loenn_data[2:4,]
loenn_data[c(1,4:5),]

mann<-loenn_data[,"kjoenn"]=="mann"
loenn_data[mann,]
mann
