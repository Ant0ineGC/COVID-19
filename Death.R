library(directlabels)
library(ggplot2)


base <- read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv")

base <- base[base$"Province.State" == "",]

base2 <- base[base$Country.Region == "France" | base$Country.Region == "Italy" | base$Country.Region == "Germany" | base$Country.Region == "Iran" | base$Country.Region == "US" | base$Country.Region == "United Kingdom",]
base2 <- base2[,c(-1:-43)]

x <- ncol (base2)

baseGermany <- as.numeric (base2[2,])
baseItaly <- as.numeric (base2[4,])
baseFrance <- as.numeric (base2[1,])
baseIran <- as.numeric (base2[3,])
baseUS <- as.numeric (base2[6,])
baseUK <- as.numeric (base2[5,])

# ggplot

df <- data.frame(baseFrance, 1:(x),"France")
di <- data.frame(baseItaly,1:(x),"Italie")
dg <- data.frame(baseGermany,1:(x),"Allemagne")
dus <- data.frame(baseUS,1:(x),"US")
duk <- data.frame(baseUK,1:(x),"UK")
dir <- data.frame(baseIran,1:(x),"Iran")


colnames(df) <- c("dc","jours","Pays")
colnames(di) <- c("dc","jours","Pays")
colnames(dg) <- c("dc","jours","Pays")
colnames(dus) <- c("dc","jours","Pays")
colnames(duk) <- c("dc","jours","Pays")
colnames(dir) <- c("dc","jours","Pays")

baseIFG <- rbind(di,df,dg, dus, duk,dir)

FIG <- ggplot (baseIFG, aes(x=jours, y=dc, fill=Pays, colour=Pays)) +
ggtitle("Nombre de décès cumulés depuis le 1er mars 2020") +
#  geom_bar(stat="identity", position=position_dodge()) +
geom_line() +
#geom_point () +
theme_bw() +
labs(x = "Jours depuis le 1er mars 2020", y = "Nombre de décès cumulés") +
scale_x_continuous(breaks=seq(0, x, 15),limits=c(0, (x+3))) + 
scale_y_continuous(breaks=c(dir[(x),1],duk[(x),1], dg[(x),1], dus[(x),1], di[(x),1], df[(x),1])) 

FIG + theme(plot.title = element_text(, size=14, face="bold.italic"))
direct.label(FIG, method="last.points") 
# dc/ jours en France

dfj <- data.frame(dc = c(0,diff(df$dc)), jours = c(1:(x)), Pays = "Journaliers")
baseDCJ <- rbind (df,dfj)

p<- ggplot(NULL, aes(jours, dc)) + 
geom_col(aes(fill = "France"), data = df, alpha = 0.1) +
geom_col(aes(fill = "Journaliers"), data = dfj, alpha = 1) +
ggtitle("Nombre de décès journaliers en France") +
scale_y_continuous(name="Nombre de décès journaliers") +
theme_bw() +
theme(legend.position='none') +
geom_text(aes(x = dfj$jours, y = (dfj$dc + 25), label = dfj$dc), color = "black", size = 2.5) +
labs(x = "Jours depuis le 1er mars 2020")

p + theme(plot.title = element_text(, size=14, face="bold.italic")) 


# hospit COVID

hospit <- read.csv2("https://github.com/opencovid19-fr/data/raw/master/data-sources/sante-publique-france/covid_hospit.csv")

hospit <- hospit[hospit$sexe == "0",]
transform(hospit, dep = as.numeric(dep))
transform(hospit, jour = as.Date(jour))
hospitidf <- hospit[hospit$dep == 75 | hospit$dep == 91 |hospit$dep == 92 |hospit$dep == 93 |hospit$dep == 94 |hospit$dep == 95 |hospit$dep == 77 ,]

hosp <- data.frame(aggregate(hospit$hosp, by = list(typ2 = hospit$jour), sum),"France")
hospidf <- data.frame(aggregate(hospitidf$hosp, by = list(typ2 = hospitidf$jour), sum), "IdF")
colnames(hosp) <- c("jour","hosp","lieu")
colnames(hospidf) <- c("jour","hosp","lieu")


p<- ggplot(NULL, aes(jour, hosp)) + 
geom_col(aes(fill = "France"), data = hosp, alpha = 0.1) +
geom_col(aes(fill = "IdF"), data = hospidf, alpha = 1) +
ggtitle("Hospitalisations pour COVID-19 en Ile de France et en France") +
scale_y_continuous(name="Nombre de patients hospitalisés") +
theme_bw() +
theme(legend.position='none') +
geom_text(aes(x = hosp$jour, y = (hosp$hosp + 5), label = hosp$hosp), color = "black", size = 2.5) +
geom_text(aes(x = hospidf$jour, y = (hospidf$hosp + 5), label = hospidf$hosp), color = "black", size = 2.5) +
labs(x = "Date")

p + theme(plot.title = element_text(, size=14, face="bold.italic"))

# Rea COVID


rea <- data.frame(aggregate(hospit$rea, by = list(typ2 = hospit$jour), sum),"France")
reaidf <- data.frame(aggregate(hospitidf$rea, by = list(typ2 = hospitidf$jour), sum), "IdF")
colnames(rea) <- c("jour","rea","lieu")
colnames(reaidf) <- c("jour","rea","lieu")


p<- ggplot(NULL, aes(jour, rea)) + 
geom_col(aes(fill = "France"), data = rea, alpha = 0.1) +
geom_col(aes(fill = "IdF"), data = reaidf, alpha = 1) +
ggtitle("Hospitalisations en réanimation en Ile de France et en France") +
scale_y_continuous(name="Nombre de patients hospitalisés") +
theme_bw() +
theme(legend.position='none') +
geom_text(aes(x = rea$jour, y = (rea$rea + 50), label = rea$rea), color = "black", size = 2.5) +
geom_text(aes(x = reaidf$jour, y = (reaidf$rea + 50), label = reaidf$rea), color = "black", size = 2.5) +
labs(x = "Date")

p + theme(plot.title = element_text(, size=14, face="bold.italic"))


# dc/ jours en Italie

dij <- data.frame(dc = c(0,diff(di$dc)), jours = c(1:(x)), Pays = "Journaliers")

p<- ggplot(NULL, aes(jours, dc)) + 
geom_col(aes(fill = "Italie"), data = di, alpha = 0.1) +
geom_col(aes(fill = "Journaliers"), data = dij, alpha = 1) +
ggtitle("Nombre de décès journaliers en Italie") +
scale_y_continuous(name="Nombre de décès journaliers") +
theme_bw() +
theme(legend.position='none') +
geom_text(aes(x = dij$jours, y = (dij$dc + 85), label = dij$dc), color = "black", size = 2.5) +
labs(x = "Jours depuis le 1er mars 2020")

p + theme(plot.title = element_text(, size=14, face="bold.italic")) 

# dc/ jours en UK

dukj <- data.frame(dc = c(0,diff(duk$dc)), jours = c(1:(x)), Pays = "yJournaliers")

p<- ggplot(NULL, aes(jours, dc)) + 
geom_col(aes(fill = "yJournaliers"), data = dukj, alpha = 1) +
geom_col(aes(fill = "UK"), data = duk, alpha = 0.1) +
ggtitle("Nombre de décès journaliers en Angleterre") +
scale_y_continuous(name="Nombre de décès journaliers") +
theme_bw() +
theme(legend.position='none') +
geom_text(aes(x = dukj$jours, y = (dukj$dc + 15), label = dukj$dc), color = "black", size = 2.5) +
labs(x = "Jours depuis le 1er mars 2020")

p + theme(plot.title = element_text(, size=14, face="bold.italic")) 

# dc/ jours en US

dusj <- data.frame(dc = c(0,diff(dus$dc)), jours = c(1:(x)), Pays = "yJournaliers")

p<- ggplot(NULL, aes(jours, dc)) + 
geom_col(aes(fill = "yJournaliers"), data = dusj, alpha = 1) +
geom_col(aes(fill = "USA"), data = dus, alpha = 0.1) +
ggtitle("Nombre de décès journaliers au USA") +
scale_y_continuous(name="Nombre de décès journaliers") +
theme_bw() +
theme(legend.position='none') +
geom_text(aes(x = dusj$jours, y = (dusj$dc + 20), label = dusj$dc), color = "black", size = 2.5) +
labs(x = "Jours depuis le 1er mars 2020")

p + theme(plot.title = element_text(, size=14, face="bold.italic"))

# dc/ jours en Allemagne

dgj <- data.frame(dc = c(0,diff(dg$dc)), jours = c(1:(x)), Pays = "Journaliers")

p<- ggplot(NULL, aes(jours, dc)) + 
geom_col(aes(fill = "Allemagne"), data = dg, alpha = 0.1) +
geom_col(aes(fill = "Journaliers"), data = dgj, alpha = 1) +
ggtitle("Nombre de décès journaliers en Allemagne") +
scale_y_continuous(name="Nombre de décès journaliers") +
theme_bw() +
theme(legend.position='none') +
geom_text(aes(x = dgj$jours, y = (dgj$dc + 5), label = dgj$dc), color = "black", size = 2.5) +
labs(x = "Jours depuis le 1er mars 2020")

p + theme(plot.title = element_text(, size=14, face="bold.italic"))


sapply(hosp,mode)