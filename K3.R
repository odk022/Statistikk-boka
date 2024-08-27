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
# lager eget datasett:
loenn_data2<-loenn_data[mann,]
# Endrer på dette:


# Tilføye observasjoner og variabler
# rbind() - tilføye rekker(rowbind)(observasjoner) og cbind - tilføye kolonner(variabler)

print(loenn_data)
print(loenn_data2)

# Slår sammen datasettene
loenn_data_m<-rbind(loenn_data,loenn_data2)
loenn_data_m

# legger til variabler(utvide datasettet:
# Vil legge til sivstatus til datasettet
sivstat <- c("single","gift","gift","gift","single")
sivstat

loenn_data_siv <- cbind(loenn_data, sivstat)
loenn_data_siv

# Endre variabel- og kolonnenavn:
#colnames()

colnames(loenn_data)
colnames(loenn_data)[3]<- "age" # endrer overskrift kolonne 3
head(loenn_data,3) # 3 her betyr at bare tre rader vises

# Endre alle:
colnames(loenn_data) <- c("respid","wage","age","gender","educ")
head(loenn_data)

# Matriser
# alle elementer i en matrise må være av samme datatype

mat1<- matrix(1:9, ncol=3)
mat1

#radvis:
mat2<- matrix(1:9, ncol=3, byrow=TRUE) 
mat2

# bruker samme funksjoner ved endring som for datarammer

# Lister:
# Har ingen restriksjoner i forhold til datatyper
# Eksempel:
v <- c(200, 345, 500, 100, 444) # en vektor
d <- data.frame(x1=c(1:5), x2=c(6:10)) # en dataramme
m <- matrix(1:9, ncol=3) # matrise

# Vi slår dette sammen til en liste:
minliste <- list(v, d, m)
minliste

minliste[3] # bruker 3 fordi matrisen er element 3 i listen. Er listeelement 
minliste[[3]] # dobbel hakeparentes gir tilbake matrisen

# anta at vi vil trekke ut verdien 8 fra matrisen
m1<- minliste[3]
m1
#Indeksen til m1 er [[1]]
m1[[1]][8]

# Kan også bruke dobbelt hakeparentes
m2<-minliste[[3]] # henter listeelement 3 som er en matrise
m2
m2[8]
# eller
m2[2,3]
