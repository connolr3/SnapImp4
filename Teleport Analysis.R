library(corrplot)
library(ltm)
library(tidyr)
library(foreach)
library(dplyr)
library(rstatix)
library(psych)
library(nortest)
setwd('C:/Users/rosie/OneDrive/Documents/GitHub/SnapImp4')
regData<-read.csv('regularteleportdata.csv')




#==============CREATING THE DATAFRAME====================================
uniqueID<-unique(regData$Participant.ID)
uniqueTeleport<-unique(regData$Teleport)

foreach(i=0:length(uniqueID), .combine=c) %do%
  print(uniqueID[i])

# Create empty list
magnitudes <- list()
for (id in uniqueID) {
  for (teleport in uniqueTeleport) {
    print(teleport)
    print(id)
    print(mag)
    mag<-sum(regData[which(regData$Participant.ID == id & regData$Teleport == teleport ), 'distance.from.previous.with.begin'])
  
    magnitudes[[length(magnitudes)+1]] <- mag
  }
}


temp<- rep(uniqueID, each=3)
temp2<-rep(uniqueTeleport,times=20,each=1)
temp3<-regData$Final.IPD
IPD <- temp3[temp3 != -1]






#==============PATH EFFICIENCY====================================

teleport<-data.frame(temp,temp2,unlist(magnitudes),IPD)
names(teleport)<-c('id','teleport','pathmag','final')


teleport$teleportExcess<-teleport$final-teleport$pathmag
plot(teleport$teleportExcess)















