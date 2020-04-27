# Courbe surmortalité
#    temporaire car le fichier des décès n est pas à jour

# Library 

library(directlabels)
library(ggplot2)
library(lubridate)
library(tidyverse)

# Data

setwd("/Users/antoinegaudetchardonnet/Git/COVID-19/COVID-19/Data")

baseDCj <- read.csv ("DCjours_annuelV2.csv")
baseDCj$Date <- as.Date (baseDCj$Date)
baseDCj$Deces <- as.numeric (baseDCj$Deces)
baseDCj$Annee <- as.factor (baseDCj$Annee)
baseDCj <- baseDCj[,-1]

# Evaluation de la surmortalité

DCj <- ggplot (baseDCj, aes(x=Date, y=Deces, color=Annee)) +
ggtitle("Mortalité journalière toutes causes confondues selon les années en France") +
geom_line ()  +
theme_bw() +
scale_x_date(date_breaks = "month", date_labels = "%B", limits = c(as.Date("2020-01-01"),as.Date("2020-12-31"))) +
scale_y_continuous(name="Nombre de décès journaliers") +
theme(plot.title = element_text(, size=14, face="bold.italic")) 
direct.label(DCj, method="last.points") 