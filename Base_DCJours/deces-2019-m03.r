library(tidyverse)
library(lubridate)

setwd("/Users/antoinegaudetchardonnet/Git/COVID-19/COVID-19/Base_DCJours")



DC19 <- as.data.frame(readLines("deces-2019.txt"))
DC19 <- as.data.frame(str_sub(DC19[,1], 155,162))
colnames(DC19) <- "Date"
DC19$Date <-as.Date(DC19[,1], "%Y%m%d")
DC19_mars_avril <- as.data.frame(table(filter(DC19,Date > "2019-03-01" & Date <"2019-04-30")))
DC19_mars_avril$Var1 <- as.Date(DC19_mars_avril$Var1)
DC19_mars_avril$Freq <- as.numeric(DC19_mars_avril$Freq)
DC19_mars_avril$Var1<- as.Date(format (DC19_mars_avril$Var1, "%b-%d"), "%b-%d")
DC19_mars_avril <- data.frame(DC19_mars_avril, "2019")
colnames(DC19_mars_avril) <- c("Date","Deces","Annee")

DC18 <- as.data.frame(readLines("deces-2018.txt"))
DC18 <- as.data.frame(str_sub(DC18[,1], 155,162))
colnames(DC18) <- "Date"
DC18$Date <-as.Date(DC18[,1], "%Y%m%d")
DC18_mars_avril <- as.data.frame(table(filter(DC18,Date > "2018-03-01" & Date <"2018-04-30")))
DC18_mars_avril$Var1 <- as.Date(DC18_mars_avril$Var1)
DC18_mars_avril$Freq <- as.numeric(DC18_mars_avril$Freq)
DC18_mars_avril$Var1<- as.Date(format (DC18_mars_avril$Var1, "%b-%d"), "%b-%d")
DC18_mars_avril <- data.frame(DC18_mars_avril, "2018")
colnames(DC18_mars_avril) <- c("Date","Deces","Annee")

DC17 <- as.data.frame(readLines("deces-2017.txt"))
DC17 <- as.data.frame(str_sub(DC17[,1], 155,162))
colnames(DC17) <- "Date"
DC17$Date <-as.Date(DC17[,1], "%Y%m%d")
DC17_mars_avril <- as.data.frame(table(filter(DC17,Date > "2017-03-01" & Date <"2017-04-30")))
DC17_mars_avril$Var1 <- as.Date(DC17_mars_avril$Var1)
DC17_mars_avril$Freq <- as.numeric(DC17_mars_avril$Freq)
DC17_mars_avril$Var1<- as.Date(format (DC17_mars_avril$Var1, "%b-%d"), "%b-%d")
DC17_mars_avril <- data.frame(DC17_mars_avril, "2017")
colnames(DC17_mars_avril) <- c("Date","Deces","Annee")

baseDCj <- rbind(DC18_mars_avril,DC19_mars_avril,DC17_mars_avril)


setwd("/Users/antoinegaudetchardonnet/Git/COVID-19/COVID-19/")

write.csv(x = baseDCj, file = "Deces_jours_mars_avril_.csv")







