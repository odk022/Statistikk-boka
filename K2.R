library(rnorsk)

# laste ned tekst-filer
semicol_sep_data <- read.table("semicol_sep_data.txt", 
                               header=TRUE, sep=";")

# header = true betyr overskrift, sep er semikolon
View(semicol_sep_data)

# laste ned csv-filer
csv_data<- read.table("csv_data.csv", header=TRUE, sep=",")

# laste ned Excel-filer
library(readxl)
excel_data<-read_excel("excel_data.xlsx")

# laste ned spss-filer
library(haven)
spss_data<- read_spss("spss_data.sav")

# laste ned stata-filer
stata_data<- read_stata("stata_data.dta")

# Kan bruke direkte-funksjonene på menyene til å gjøre det samme "Import Dataset"

# Finner ikke fila "loenn"

#loenn_data<- read_stata("loenn.dta")

#save(loenn_kvinne, file="mydata.Rdata")

# Legge inn data:
# Lager en tom tabell:
loenn_data<- data.frame(respid=numeric(0),
                        tloenn=numeric(0),
                        alder=numeric(0),
                        kjonn=character(0),
                        utdann=numeric(0))
fix(loenn_data)

# Legger inn data:
respid<- c(1,2,3,4,6)
tloenn<-c(270,330,655,455,150)
alder<-c(34,46,51,39,22)
kjonn<-c("mann","kvinne","mann","mann","kvinne")
utdann<-c(10,12,15,13,8)
loenn_data<- data.frame(respid,tloenn,alder,kjonn,utdann)
View(loenn_data)

# Enklere måte:
loenn_data<- data.frame(
  respid=c(1,2,3,4,6),
  tloenn=c(270,330,655,455,150),
  alder=c(34,46,51,39,22),
  kjonn=c("mann","kvinne","mann","mann","kvinne"),
  utdann=c(10,12,15,13,8)
)
loenn_data
save(loenn_data, file = "loenn_data.Rdata")
load(file = "loenn_data.Rdata")
