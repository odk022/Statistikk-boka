# KAPITTEL 8 ANOVA/ANCOVA
# Lager dummy-variabler
library(dplyr)
library(rnorsk)
leilighet <- mutate(leilighet,
                    sentrum = if_else(beliggenhet==1, 1, 0),
                    soer    = if_else(beliggenhet==2, 1, 0),
                    vest    = if_else(beliggenhet==3, 1, 0),
                    oest    = if_else(beliggenhet==4, 1, 0)
)
names(leilighet)

# Kan også brukke pakken fastdummies
library(fastDummies)
leilighet <- dummy_cols(leilighet, select_columns="beliggenhet")
names(leilighet)

# eller bruke funksjonen model.matrix(se kap 4)

# en dummy variabel
library(rnorsk)
leilighet <- mutate(leilighet,
                    sentrum_lei = if_else(beliggenhet==1, 1, 0)) # endrer datasettet

model1 <- lm(pris ~ sentrum_lei, data = leilighet)
summary(model1)

# Kan også gjøre det direkte:
model2 <- lm(pris ~ (beliggenhet==1), data = leilighet)
summary(model2) # tolkning side 229

# legger til kontrollvariablen størrelse:
model3 <- lm(pris ~ (beliggenhet==1) + stoerrelse, 
             data = leilighet)
summary(model3) # tolkning side 231

# Flere dummy
# sammenlikne med ulike deler av byen jf datasettet
leilighet <- mutate(leilighet, 
                    beliggenhet = 
                      factor(beliggenhet,
                             levels = c(1, 2, 3, 4),
                             labels = c("sentrum", "soer",
                                        "vest", "oest")))

model4 <- lm(pris ~ beliggenhet, data = leilighet)
summary(model4) # tolkning side 231

# Kan også endre referansekategori
leilighet$beliggenhet <- relevel(leilighet$beliggenhet, 
                                 ref="soer") 
model5 <- lm(pris ~ beliggenhet, data = leilighet)
summary(model5)

leilighet$beliggenhet <- relevel(leilighet$beliggenhet, 
                                 ref="vest") 
model6 <- lm(pris ~ beliggenhet, data = leilighet)
summary(model6)

# Sammenlikning av leilighetspriser
library(multcomp)
soerVSvest <- glht(model4, linfct = 
                     c("beliggenhetsoer - beliggenhetvest = 0"))
summary(soerVSvest)

soerVSoest <- glht(model4, linfct = 
                     c("beliggenhetsoer - beliggenhetoest = 0"))
summary(soerVSoest)

vestVSoest <- glht(model4, linfct = 
                     c("beliggenhetvest - beliggenhetoest = 0"))
summary(vestVSoest)

# Endre rekkefølgen til det opprinnelige
leilighet <- 
  leilighet %>% 
  mutate(beliggenhet = factor(beliggenhet, 
                              levels = c("sentrum", "soer", 
                                         "vest", "oest")))
# Gruppevis oversikt
leilighet %>% 
  group_by(beliggenhet) %>% 
  summarize(mean(pris))

# Figur
library(ggplot2)
ggplot(leilighet, aes(x=beliggenhet, y=pris, 
                      colour=beliggenhet)) +
  geom_boxplot() +
  stat_summary(fun.data=mean_cl_normal, geom="pointrange", 
               colour="blue", width=0.1) +
  stat_summary(fun.y=mean, geom="line", 
               colour="black", aes(group=1)) +
  geom_jitter(size=0.1)

# Justering for parvise sammenlikninger(se tekst side 239)
library(multcomp)
library(sandwich)
compTukey <- glht(model4, linfct=mcp(beliggenhet="Tukey"),
                  vcov=sandwich)
summary(compTukey)
# Den eneste forskjellen som er signifikant er mellom soer og sentrum

