library(tidyverse)
library(lubridate)
library(directlabels)

setwd("/Users/antoinegaudetchardonnet/Git/COVID-19/COVID-19/Base_DCJours")

DC03 <- as.data.frame(readLines("deces-2003.txt"))
colnames(DC20) <- "Date"

DC20 <- as.data.frame(readLines("deces-2020-t1.txt"))
colnames(DC20) <- "Date"

DC19 <- as.data.frame(readLines("deces-2019.txt"))
colnames(DC19) <- "Date"

DC18 <- as.data.frame(readLines("deces-2018.txt"))
colnames(DC18) <- "Date"

DC17 <- as.data.frame(readLines("deces-2017.txt"))
colnames(DC17) <- "Date"

base <- rbind(DC20,DC19, DC18, DC17)

base <- as.data.frame(str_sub(base[,1], 155,162))
colnames(base) <- "Date"
base$Date <-as.Date(base[,1], "%Y%m%d")

baseDCj <- as.data.frame(table(filter(base,Date >= "2017-01-01" & Date <= "2020-12-31")))

baseDCj$Var1 <- as.Date(baseDCj$Var1)
baseDCj$Freq <- as.numeric(baseDCj$Freq)
baseDCj <- data.frame(baseDCj, year(baseDCj$Var1))
baseDCj$Var1<- as.Date(format (baseDCj$Var1, "%b-%d"), "%b-%d")


colnames(baseDCj) <- c("Date","Deces","Annee")

setwd("/Users/antoinegaudetchardonnet/Git/COVID-19/COVID-19/Data")

write.csv(x = baseDCj, file = "DCjours_annuelV3.csv")

# Evaluation de la surmortalité

DCj <- ggplot (baseDCj, aes(x=Date, y=Deces, color=Annee)) +
ggtitle("Mortalité journalière toutes causes confondues en mars et avril selon les années en France") +

geom_line ()  +
theme_bw() +
scale_x_date(date_breaks = "week", date_labels = "%d %B", limits = c(as.Date("2020-01-01"),as.Date("2020-12-31"))) +
scale_y_continuous(name="Nombre de décès journaliers") +
theme(plot.title = element_text(, size=14, face="bold.italic")) 
direct.label(DCj, method="last.points") 