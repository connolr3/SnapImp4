#install.packages("readxl")   # run once
library(readxl)
library(tidyverse)
library(ggpubr)
library(tidyr)
library(dplyr)
library(rstatix)
library(effsize)
library(polycor)

data <- read.csv("C:/Users/connolr3/DOWNLOADS/Data CHI2026 - TAP.csv")
data$e


data<-data[2:20,0:35]

data$p_reg <-data$`PSIAL REGULAR`
data$p_snap <-data$`PSIAL SNAP`
data$No..Corrections.3<-as.numeric(data$No..Corrections.3)
data$No..Corrections.2<-as.numeric(data$No..Corrections.2)
data$No..Corrections<-as.numeric(data$No..Corrections)
data$IPD.Preference<-as.numeric(data$IPD.Preference)


data$experience<-recode(data$experience,`1`="Novice (I have little to no experience with VR)",`2`= "Beginner (I have tried VR a few times but am not very familiar)",`3`="Intermediate (I use VR occasionally and feel somewhat comfortable)",`4`="Advanced (I use VR regularly and am confident navigating most experiences)",`5`="Expert (I have extensive experience, possibly including development or professional use)")
data$experience <- factor(
  data$experience,
  levels = c(
    "Novice (I have little to no experience with VR)",
    "Beginner (I have tried VR a few times but am not very familiar)",
    "Intermediate (I use VR occasionally and feel somewhat comfortable)",
    "Advanced (I use VR regularly and am confident navigating most experiences)",
    "Expert (I have extensive experience, possibly including development or professional use)"
  ),
  ordered = TRUE
)
data$experience
hetcor(data$experience,data$Snap.Magnitude)
hetcor(data$experience,data$Snap.Magnitude.1)
hetcor(data$experience,data$Snap.Magnitude.2)

data <- data %>%
  mutate(
    average_snap = rowMeans(across(c(Snap.Magnitude, Snap.Magnitude.1, Snap.Magnitude.2)), na.rm = TRUE)
  )

hetcor(data$experience,data$average_snap)

data <- data %>%
  mutate(
    average_Corrections_regular = rowMeans(across(c(No..Corrections.3, No..Corrections.4, No..Corrections.5)), na.rm = TRUE)
  )

data <- data %>%
  mutate(
    average_Corrections_snap = rowMeans(across(c(No..Corrections, No..Corrections.1, No..Corrections.2)), na.rm = TRUE)
  )


hetcor(data$experience,data$average_Corrections)
hetcor(data$experience,data$average_Corrections_snap)
plot(data$experience,data$average_Corrections)
plot(data$experience,data$average_Corrections_snap)

hetcor(data$experience,data$SNAP.Please.rate.the.extent.to.which.you.agree.with.the.following.statements...I.felt.in.control.of.where.I.teleported)
hetcor(data$experience,data$PSIAL.REGULAR)
hetcor(data$experience,data$PSIAL.SNAP)
hetcor(data$experience,data$Snap.Magnitude.2)#THE MORE EXPERIENCE THE LOWER THE ANXIETY LEVEL


newdf <- na.omit(data)
cor(data$SOT,data$average_Corrections)

cor(x=data$SOT,data$IPD.Preference)
plot(x=data$SOT,data$IPD.Preference)


t.test(average_Corrections_snap ~ expgorup, data = data)
t.test(average_Corrections_regular ~ expgorup, data = data)
by(data$average_Corrections_snap, data$expgroup, shapiro.test)



adjustments<-c(data$Snap.Magnitude,data$Snap.Magnitude.1,data$Snap.Magnitude.2)
hist(adjustments)
