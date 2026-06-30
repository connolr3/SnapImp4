#install.packages("readxl")   # run once
library(readxl)
data <- read_excel("C:/Users/rosie/downloads/test.xlsx")
library(tidyverse)
library(ggpubr)
library(tidyr)
library(dplyr)

library(rstatix)



data$p_reg <-data$`PSIAL REGULAR`
data$p_snap <-data$`PSIAL SNAP`

wilcox.test(data$adj_snap_av, data$adj_reg_av, paired=TRUE) 
#p=0.2

#0.008149


#there is a significant difference 


wilcox.test(
  data$adj_snap_av,   # adjusted teleport condition
  data$adj_reg_av,    # baseline condition
  paired = TRUE,
  alternative = "less",
  exact = FALSE
)
#not significant
#SIGNIFICANT



data<-data[1:20,0:36]

#Paired Samples T-TEST TO check for different in participants' preferred IPD and average IPD in baseline
data$`false ipd`<-as.numeric(data$`false ipd`)
data$`IPD Preference`<-as.numeric(data$`IPD Preference`)
data$IPDDIFFERENCE<-data$`IPD Preference`-data$`false ipd`
shapiro.test(data$IPDDIFFERENCE)
t.test(data$`IPD Preference`, data$'false ipd', paired = TRUE, alternative = "two.sided")
#SIGNIFICANT

t.test(data$`IPD Preference`, data$'false ipd',
       paired = TRUE,
       alternative = "less")


data$IPDDIFFERENCE<-data$`IPD Preference`-data$'false ipd'
shapiro.test(data$IPDDIFFERENCE)#NORMAL
t.test(data$`IPD Preference...19`, data$falseipd, paired = TRUE, alternative = "two.sided")


t.test(data$'false ipd',data$`IPD Preference`,
       paired = TRUE,
       alternative = "less")
#true mean difference is less than 0

