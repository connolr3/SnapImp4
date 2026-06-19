#install.packages("readxl")   # run once
library(readxl)
data <- read_excel("C:/Users/CONNOLR3/DOWNLOADS/test.xlsx")
library(tidyverse)
library(ggpubr)
library(tidyr)
library(dplyr)

library(rstatix)



data$p_reg <data$`PSIAL REGULAR`
data$p_snap <data$`PSIAL SNAP`

wilcox.test(data$adj_snap_av, data$adj_reg_av, paired=TRUE) 
#p=0.2


wilcox.test(
  data$adj_snap_av,   # adjusted teleport condition
  data$adj_reg_av,    # baseline condition
  paired = TRUE,
  alternative = "less",
  exact = FALSE
)
#not significant






#Paired Samples T-TEST TO check for different in participants' preferred IPD and average IPD in baseline
data$IPDDIFFERENCE<-data$`IPD Preference...19`-data$falseipd
shapiro.test(data$IPDDIFFERENCE)
t.test(data$`IPD Preference...19`, data$falseipd, paired = TRUE, alternative = "two.sided")


t.test(data$`IPD Preference...19`, data$falseipd,
       paired = TRUE,
       alternative = "less")


data$IPDDIFFERENCE<-data$`IPD Preference...19`-data$falseipd
shapiro.test(data$IPDDIFFERENCE)
t.test(data$`IPD Preference...19`, data$falseipd, paired = TRUE, alternative = "two.sided")


t.test(data$falseipd,data$`IPD Preference...19`,
       paired = TRUE,
       alternative = "less")


