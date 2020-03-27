
library(directlabels)
library(ggplot2)

setwd("/Users/antoinegaudetchardonnet/Git/COVID-19")
download.file("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv", 
    destfile = "time_series_19-covid-Deaths.csv", method = "curl")

base <- read.csv("time_series_19-covid-Deaths.csv")

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
#  geom_bar(stat="identity", position=position_dodge()) +
geom_line(alpha=0.5) +
#geom_point () +
theme_bw() +
labs(x = "Jours depuis le 1er mars 2020", y = "Nombre de décès cumulés") +
scale_x_continuous(breaks=seq(0, x, 15),limits=c(0, (x+3))) + 
scale_y_continuous(breaks=c(dir[(x),1],duk[(x),1], dg[(x),1], dus[(x),1], di[(x),1], df[(x),1])) 
direct.label(FIG, method="last.points") 

# dc/ jours en France

dfj <- data.frame(dc = c(0,diff(df$dc)), jours = c(1:(x)), Pays = "Journaliers")
baseDCJ <- rbind (df,dfj)

ggplot(NULL, aes(jours, dc)) + 
geom_col(aes(fill = "France"), data = df, alpha = 0.1) +
geom_col(aes(fill = "Journaliers"), data = dfj, alpha = 1) +
scale_y_continuous(name="Nombre de décès journaliers", breaks = c(dfj[x,1], df[x,1], 500, 1500)) +
theme_bw() +
geom_text(aes(x = dfj$jours, y = (dfj$dc + 20), label = dfj$dc), color = "black", size = 2.5) +
labs(x = "Jours depuis le 1er mars 2020")


