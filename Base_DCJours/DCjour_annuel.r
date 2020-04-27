library(tidyverse)
library(lubridate)

setwd("/Users/antoinegaudetchardonnet/Git/COVID-19/COVID-19/Base_DCJours")

DC20 <- as.data.frame(readLines("deces-2020-t1.txt"))
DC20 <- as.data.frame(str_sub(DC20[,1], 155,162))
colnames(DC20) <- "Date"
DC20$Date <-as.Date(DC20[,1], "%Y%m%d")
DC20_mars_avril <- as.data.frame(table(filter(DC20,Date >= "2020-01-01" & Date <= "2020-12-31")))
DC20_mars_avril$Var1 <- as.Date(DC20_mars_avril$Var1)
DC20_mars_avril$Freq <- as.numeric(DC20_mars_avril$Freq)
DC20_mars_avril$Var1<- as.Date(format (DC20_mars_avril$Var1, "%b-%d"), "%b-%d")
DC20_mars_avril <- data.frame(DC20_mars_avril, "2020")
colnames(DC20_mars_avril) <- c("Date","Deces","Annee")

DC19 <- as.data.frame(readLines("deces-2019.txt"))
DC19 <- as.data.frame(str_sub(DC19[,1], 155,162))
colnames(DC19) <- "Date"
DC19$Date <-as.Date(DC19[,1], "%Y%m%d")
DC19_mars_avril <- as.data.frame(table(filter(DC19,Date >= "2019-01-01" & Date <= "2019-12-31")))
DC19_mars_avril$Var1 <- as.Date(DC19_mars_avril$Var1)
DC19_mars_avril$Freq <- as.numeric(DC19_mars_avril$Freq)
DC19_mars_avril$Var1<- as.Date(format (DC19_mars_avril$Var1, "%b-%d"), "%b-%d")
DC19_mars_avril <- data.frame(DC19_mars_avril, "2019")
colnames(DC19_mars_avril) <- c("Date","Deces","Annee")

DC18 <- as.data.frame(readLines("deces-2018.txt"))
DC18 <- as.data.frame(str_sub(DC18[,1], 155,162))
colnames(DC18) <- "Date"
DC18$Date <-as.Date(DC18[,1], "%Y%m%d")
DC18_mars_avril <- as.data.frame(table(filter(DC18,Date >= "2018-01-01" & Date <= "2018-12-31")))
DC18_mars_avril$Var1 <- as.Date(DC18_mars_avril$Var1)
DC18_mars_avril$Freq <- as.numeric(DC18_mars_avril$Freq)
DC18_mars_avril$Var1<- as.Date(format (DC18_mars_avril$Var1, "%b-%d"), "%b-%d")
DC18_mars_avril <- data.frame(DC18_mars_avril, "2018")
colnames(DC18_mars_avril) <- c("Date","Deces","Annee")

DC17 <- as.data.frame(readLines("deces-2017.txt"))
DC17 <- as.data.frame(str_sub(DC17[,1], 155,162))
colnames(DC17) <- "Date"
DC17$Date <-as.Date(DC17[,1], "%Y%m%d")
DC17_mars_avril <- as.data.frame(table(filter(DC17,Date >= "2017-01-01" & Date <"2017-12-31")))
DC17_mars_avril$Var1 <- as.Date(DC17_mars_avril$Var1)
DC17_mars_avril$Freq <- as.numeric(DC17_mars_avril$Freq)
DC17_mars_avril$Var1<- as.Date(format (DC17_mars_avril$Var1, "%b-%d"), "%b-%d")
DC17_mars_avril <- data.frame(DC17_mars_avril, "2017")
colnames(DC17_mars_avril) <- c("Date","Deces","Annee")

baseDCj <- rbind(DC18_mars_avril,DC19_mars_avril,DC17_mars_avril,DC20_mars_avril)


setwd("/Users/antoinegaudetchardonnet/Git/COVID-19/COVID-19/Data")

write.csv(x = baseDCj, file = "DCjours_annuel.csv")







