# Kapittel 6 - Deskriptiv statistikk
 
# sentraltendens - aritmetisk gjennomsnitt

library(rnorsk)
data("olympic")

hoeyde <- filter(olympic, Sex=="F", !is.na(Height)) %>% 
  pull(Height)

sum(hoeyde)/length(hoeyde) # summerer alle høyder
# antall elementer i variabelen "hoeyde"
# Dette gir gjennomsnitt

# Enklere
mean(hoeyde)

# Lage histogram
ggplot(data.frame(hoeyde),aes(x=hoeyde)) + 
  geom_histogram(bins=15)+
  # beregn og vis gjennomsnitt som rød linje
  geom_vline(xintercept = mean(hoeyde), 
             color="red")      

# sentraltendens - median
median(hoeyde) # mer robust mot utliggere

#eks
hoeyde.med.utligger <- c(hoeyde, 160000) # feiltasting
mean(hoeyde.med.utligger) 
median(hoeyde.med.utligger) 

# sentraltendens - modus
# verdien som hyppisk forekommer i en variabels fordeling
# vil være det samme som den "høyeste" toppen i fordelingsplottet
library(modeest) # aktuell pakke
mlv(hoeyde) # funksjonen som beregner modus

# Spredning
# Varians
# Summen av kvadrete avvik fra gjennomsnittet delt på "n-1"
sum( ( hoeyde-mean(hoeyde) )^2 ) / (length(hoeyde)-1)
var(hoeyde)

# Standardavvik - kvadratroten til Variansen
sd(hoeyde) # forutsetter at dataene er tilnærmet normalfordelte
# Andre funksjoner
range(hoeyde) # avstanden mellom høyeste og laveste verdi
min(hoeyde)
max(hoeyde)
IQR(hoeyde) # interkvartilavstanden - tredje minus første kvantil
# bredden til intervallet som inneholder de midterste 50 % av dataene
quantile(hoeyde) # deler dataene i kvartiler som standard
quantile(hoeyde, probs=c(0.05, 0.10, 0.9, 0.95)) # tilleggsargument for å 
# bestemme hvilke kvantiler som skal beregnes

library(moments)
skewness(hoeyde)
# at en fordeling ikke er symmetrisk rundt gjennomsnittet. Negativ verdi betyr 
# en venstreskjev fordeling,og positiv at den er høyreskjev.

kurtosis(hoeyde)
# Tilstand når en fordeling er normalfordelt, men at halene har for lave eller 
# for høye verdier til å være normalfordelt("fat tails")
# kurtosis er et positivt tall
# for en normalfordelt variabel er verdien nær 3 - mesokurtic
# Mindre enn 3 - platykurtic - det finnes mindre ekstreme verdier enn forventet
# utfra normalfordelingen
# Større enn 3 - leptokurtic - det finnes flere ekstreme verdier enn forventet
# utfra normalfordelingen

# Eks tre forskjellige datasett
# normalfordelt - "hoeyde" høyde kvinnelige olympiadeltakere
# venstreskjev fordeling - "doede" dødsfall i Norge 2016
# høyreskjev fordeling - "leilighet" boligpriser i Trondheim
dodsalder <- doede %>% uncount(doede) %>% pull(alder)
pris <- leilighet %>% pull(pris)

tribble(
  ~dataset,    ~skewness,           ~kurtosis,
  "olympic",   skewness(hoeyde),    kurtosis(hoeyde),
  "doede",     skewness(dodsalder), kurtosis(dodsalder),
  "leilighet", skewness(pris),      kurtosis(pris)
)

# Diskrete fordelinger
# ikke mulig å beregne mean av en kategorisk variabel
# frekvenstabell
table(olympic$Sex)
table(olympic$Medal, useNA="always") # alle deltakerne tas med

# bruker dplyr
olympic %>% 
  group_by(Medal) %>% 
  summarise(antall=n()) # beregner antall obs i hvert deldatasett og lager en
# variabel antall som inneholder denne infoen

length( unique(olympic$Team) ) # teller antall land som var 
# unique angir alle unike verdier i datasettet
# length teller totalt antall verdier
