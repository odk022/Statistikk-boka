# VISUALISERING

library(rnorsk)
ggplot(nyeStudenter, aes(x=aar, y=studenter,color=alder, shape=kjoenn)) +
  geom_point() +
  geom_line(aes(group=interaction(kjoenn,alder)))

# Histogram
ggplot(nyeStudenter, aes(x=studenter)) +
  geom_histogram(bins=20)

ggplot(nyeStudenter, aes(x=studenter, fill=alder)) +
  geom_histogram(bins=20)

p1<- ggplot(studentHeights, aes(x=hoeyde)) +
  geom_histogram(binwidth=2)
p1
p2<- ggplot(studentHeights, aes(x=hoeyde)) +
  geom_histogram(binwidth=5)
p2
p3<- ggplot(studentHeights, aes(x=hoeyde)) +
  geom_histogram(binwidth=10)
p3
# Vi ser at jo høyere binwidth, jo mer detaljer viskes ut

# diskret variabel - bruk geom_bar
# Eks
library(psych)
ggplot(sat.act, aes(x=education)) +
  geom_bar()

#dotplot
ggplot(studentHeights, aes(x=hoeyde)) +
  geom_dotplot()
ggplot(studentHeights, aes(x=hoeyde)) +
  geom_dotplot(stackdir = "center")
ggplot(studentHeights, aes(x=hoeyde,fill = kjoenn)) +
  geom_dotplot(binpositions = "all",stackgroups = T)

# Glattede tetthetsestimater
# Eks
ggplot(studentHeights, aes(x=hoeyde)) +
  geom_density()
ggplot(studentHeights, aes(x=hoeyde)) +
  geom_histogram(aes(y=stat(density)),binwidth=5) +
  geom_density(color="red")
ggplot(studentHeights, aes(x=hoeyde,fill=kjoenn)) +
  geom_density(alpha=0.4)

ggplot(studentHeights, aes(x=hoeyde)) +
  geom_density(kernel="gaussian", color="blue") +
  geom_density(kernel="triangular", color="red") +
  geom_density(kernel="rectangular", color="green") 

ggplot(studentHeights, aes(x=hoeyde)) +
  geom_density(bw=1, color="blue") +
  geom_density(bw=2, color="red") +
  geom_density(bw=10, color="green") 

ggplot(studentHeights, aes(x=hoeyde)) +
  geom_density(bw="nrd", color="blue") +
  geom_density(bw="SJ", color="red") +
  geom_density(bw="bcv", color="green") 

##
ggplot(nyeStudenter, aes(x=studenter)) +
  geom_density() +
  geom_rug()

# QQ-plott
# sjekke antakelsen om normalfordeling
ggplot(studentHeights, aes(sample=hoeyde)) +
  geom_qq() +
  geom_qq_line()
# Små avvik

ggplot(nyeStudenter, aes(sample=studenter)) +
  geom_qq() +
  geom_qq_line()
# betydelige avvik
# sjekker om dataene innenfor hver gruppe er normalfordelte
ggplot(nyeStudenter, aes(sample=studenter,color=interaction(kjoenn,alder))) +
  geom_qq() +
  geom_qq_line()

# Visualisering av to eller flere variabler
# Spredningsplott
ggplot(sat.act, aes(x=ACT,y=SATQ)) +
  geom_point()

# Tar bort utliggere:
sat.act2<- filter(sat.act, ACT>10, SATQ>300) # tar med ACT>10 og SATQ>300
ggplot(sat.act2, aes(x=ACT,y=SATQ)) +
  geom_point()

# Bruke jitter for å få fram verdier som ligger skjult bak andre
ggplot(sat.act2, aes(x=jitter(ACT),y=jitter(SATQ))) +
  geom_point()

# eller
ggplot(sat.act2, aes(x=ACT,y=SATQ)) +
  geom_jitter()

# Trender

ggplot(sat.act2, aes(x=ACT,y=SATQ)) +
  geom_point(color="grey") +
  geom_smooth() # estimerer trend utfra data

ggplot(sat.act2, aes(x=ACT,y=SATQ)) +
  geom_point(color="grey") +
  geom_smooth(method = "lm") # estimerer lineær trend utfra data

# hypotese om at skåren er moderert av utdanningsnivået, lager om utdanning til factor
sat.act3<- filter(sat.act, education==1 | education==5) %>% 
  mutate(education=factor(education, labels = c("low", "high")))

ggplot(sat.act3, aes(x=ACT,y=SATQ,colour = education)) +
  geom_point() +
  geom_smooth(method = "lm", se=F) # estimerer trend utfra data

# Sammenheng mellom flere variabler
library(GGally) # lager spredningsplottmatrise
ggpairs(sat.act, columns = c("age","ACT","SATV" ,"SATQ"))

# se hvordan prestasjonskåren utvikler seg med alder
# lager langt datasett
sat.act.long<-gather(sat.act,prestasjonsmaal, skaare,ACT,SATQ,SATV) 
head(sat.act.long,5)
# laget to nye variabler:
# prestasjonsmaal er en diskret variabel som inneholder navnet til prestasjonsmålet
# i hver rad
# skaare inneholder verdiene som før var fordelt på tre kolonner
# bruker facets for å lage underfigurer

ggplot(sat.act.long, aes(x=age,y=skaare))+
  geom_point() +
  geom_smooth() +
  facet_wrap(~prestasjonsmaal)

# legger til scales="free_y" slik at første figur er lesbar
ggplot(sat.act.long, aes(x=age,y=skaare))+
  geom_point() +
  geom_smooth() +
  facet_wrap(~prestasjonsmaal,scales="free_y")

# lager fasetter både for presisjonsmål og kjønn
ggplot(sat.act.long, aes(x=age,y=skaare))+
  geom_point() +
  geom_smooth() +
  facet_wrap( gender~prestasjonsmaal,scales="free_y")
# Vi får to sett menn = 1, kvinner = 2

# Gruppeforskjeller - bruke boxplot
ggplot(studentHeights, aes(x=kjoenn, y=hoeyde)) +
  geom_boxplot()

# forbedring:
ggplot(studentHeights, aes(x=kjoenn, y=hoeyde)) +
  geom_boxplot() +
  geom_dotplot(binaxis = "y", stackdir = "center",
               fill="grey", alpha=0.3)

ggplot(studentHeights, aes(x=interaction(kjoenn,aar), y=hoeyde,fill = kjoenn)) +
  geom_boxplot() +
  geom_dotplot(binaxis = "y", stackdir = "center",
               fill="grey", alpha=0.3) +
  coord_flip()

# viser gjennomsnittshøyden(mean) i hver gruppe, kan også bruke andre, f.eks. median
ggplot(studentHeights, aes(x=aar, y=hoeyde,fill = kjoenn)) +
  stat_summary(fun.y = mean, geom = "bar", # gjennomsnitt og søyler
               position=position_dodge())# setter søylene ved siden av hverandre

# viser med feilmarginer
ggplot(studentHeights, aes(x=aar, y=hoeyde,fill = kjoenn)) +
  stat_summary(fun.data = mean_se, geom = "errorbar",# lager feilstrekene på toppen 
               width=0.3,
               position=position_dodge(width = 0.9)) +
  stat_summary(fun.y = mean, geom = "bar", # gjennomsnitt og søyler
               position=position_dodge()) +
  coord_cartesian(ylim = c(150,185)) # endrer y-aksen

# klassisk interaksjonsplott
ggplot(studentHeights, aes(x=factor(aar), y=hoeyde,
                           color = kjoenn)) +
  stat_summary(fun.data = mean_se, geom = "pointrange") + #lager feilstrekene
  stat_summary(fun.y = mean, aes(group = kjoenn), geom = "line") #tegner linjene
# som binder sammen gruppene basert på kjønn

# 5.6 Modifisering av figurer
# mange ulike temaer
ggplot(nyeStudenter, aes(x=studenter, fill=alder)) +
  geom_histogram(bins=20) +
  theme_dark()
               
ggplot(nyeStudenter, aes(x=studenter, fill=alder)) +
  geom_histogram(bins=20) +
  theme_bw() +
  theme(axis.text.x = element_text(size = 18)) # endrer størrelsen på fonten

# Mange mulige endringer
ggplot(nyeStudenter, aes(x=studenter, fill=alder)) +
  geom_histogram(bins=20) +
  theme_bw() +
  theme(axis.text.x = element_text(face = "bold", # tykkelse uthevet
                                   size = 18, # fontstørrelse
                                   colour = "red", # farge
                                   angle = 45, # vinkel på skrift
                                   hjust = 1)) + 
  theme(axis.text.y = element_text(face = "italic",
                                   size = 10,
                                   colour = "green",
                                   angle = 90,
                                   hjust = 0.5))

# Bruk help(element_text)

ggplot(nyeStudenter, aes(x=studenter, fill=alder)) +
  geom_histogram(bins=20) +
  theme(panel.background = element_rect(fill="lightblue"),
        legend.background = element_rect(fill="orange"),
        axis.line = element_line(size = 1, arrow = arrow()),
        panel.grid = element_line(size = 0))

# skalaer