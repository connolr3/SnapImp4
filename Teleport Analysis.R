library(corrplot)
library(ltm)
library(tidyr)
library(foreach)
library(dplyr)
library(rstatix)
library(psych)
library(nortest)
library(ggplot2)



#===================READ IN DATA====================
setwd('C:/Users/connolr3/Documents/GitHub/SnapImp4')
regData<-read.csv('regularteleportdata.csv')
snapData<-read.csv('snapteleportdata.csv')





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
    #print(mag)
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


teleport$teleportExcess<-teleport$pathmag-teleport$final
plot(teleport$teleportExcess)
plot(snapData$Excess)




#write.csv(teleport,"RegularteleportExcess.csv", row.names = FALSE)





test <- wilcox.test(snapData$TeleportExcess ~ teleport$teleportExcess)


hist(snapData$Excess)
shapiro.test(snapData$Excess)#fails test for normality
shapiro.test(teleport$teleportExcess)#fails test for normality




combinedTeleportData <- data.frame(
  Time = c(rep("regular", 60), rep("snap", 60)),
  Grade = c(teleport$teleportExcess, snapData$Excess)
)
combinedTeleportData



combinedTeleportData$Time <- factor(combinedTeleportData$Time,
                                    levels = c("regular", "snap")
)

ggplot(combinedTeleportData) +
  aes(x = Time, y = Grade) +
  geom_boxplot(fill = "#0c4c8a") +
  theme_minimal()


mean(snapData$Excess)
mean(teleport$teleportExcess)





# Testing our hypothesis
library(MASS)
wilcox.test(teleport$teleportExcess, snapData$Excess, paired=TRUE) 

boxplot(teleport$teleportExcess, snapData$Excess)






wilcox.test(teleport$teleportExcess, snapData$Excess, mu=0,alt="two.sided",conf.int=T, conf.level=0.99,paired=TRUE) 




regmeans<-teleport%>%
  group_by(id)%>%
  summarize(mean = mean(teleportExcess))
snapmeans<-snapData%>%
  group_by(id)%>%
  summarize(mean = mean(Excess))


wilcox.test(regmeans$mean, snapmeans$mean, mu=0,alt="two.sided",conf.int=T, conf.level=0.99,paired=TRUE) 



teleport$pathEfficiency<-teleport$final/teleport$pathmag

snapData$Path.Efficiency<-as.numeric(snapData$Path.Efficiency)
wilcox.test(teleport$pathEfficiency, as.numeric(snapData$Path.Efficiency), mu=0,alt="two.sided",conf.int=T, conf.level=0.99,paired=TRUE) 

boxplot(teleport$pathEfficiency, snapData$Path.Efficiency)


mean(teleport$pathEfficiency)
mean(snapData$Path.Efficiency)


