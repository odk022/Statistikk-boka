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