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