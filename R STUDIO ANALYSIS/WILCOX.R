#install.packages("readxl")   # run once
library(readxl)
library(tidyverse)
library(ggpubr)
library(tidyr)
library(dplyr)
library(rstatix)
library(effsize)


#------------------------------------------------------------------------------------
#data prep
#----------------------------------------------------------------------------------------
#data <- read_excel("C:/Users/rosie/DOWNLOADS/test.xlsx")
data <- read_excel("C:/Users/connolr3/DOWNLOADS/test.xlsx")
data<-data[1:20,0:33]
data$p_reg <-data$`PSIAL REGULAR`
data$p_snap <-data$`PSIAL SNAP`
old_data<-data[0:10,]




#------------------------------------------------------------------------------------
#Wilcoxon test
#----------------------------------------------------------------------------------------
#basic
wilcox.test(data$adj_snap_av, data$adj_reg_av, paired=TRUE) #significant 0.008149
wilcox.test(data$adj_reg_av, data$adj_snap_av, paired=TRUE) #significant 0.008149
#note if you swapped the order the v would be different! you always take the smaller, i.e. 13
#the p is the same
wilcox.test(old_data$adj_snap_av, old_data$adj_reg_av, paired=TRUE) #Not sig p=0.2

#paired, directional
test<-wilcox.test(
  data$adj_snap_av,   # adjusted teleport condition
  data$adj_reg_av,    # baseline condition
  paired = TRUE,
  alternative = "less",
  exact = FALSE
)
#SIGNIFICANT
test
#notice the p value is halved from the basic non directional test






#------------------------------------------------------------------------------------
#Wilcoxon test STATISTICS
#----------------------------------------------------------------------------------------
V <- test$statistic
V#13 we know this as only correct answer no matter one or two tailed

n <- sum(!is.na(data$adj_snap_av))#the problemn is n could be 40....

mu <- n*(n+1)/4
sigma <- sqrt(n*(n+1)*(2*n+1)/24)

#Z SCORE
qnorm(test$p.value)#-2.64
Z <- (as.numeric(V) - mu) / sigma
Z

Za = qnorm(test$p.value)#divide by 2 if two sided see https://stats.stackexchange.com/questions/330129/how-to-get-the-z-score-in-wilcox-test-in-r

Za#-2.65

#Z IS

differences<-data$adj_reg_av-data$adj_snap_av
differences<-abs(differences)



#------------------------------------------------------------------------------------
#r, EFFECT SIZE
#----------------------------------------------------------------------------------------



#https://stats.stackexchange.com/questions/133077/effect-size-to-wilcoxon-signed-rank-test

#IT SAYS R CAN BE COMPUTED BY DIVIDED THE Z VALUE BY N WHERE N IS TOTAL NO OBSERVATIONS OVER THE 2 TIM POINTS NOT CASES
r <- Z / sqrt(n)
r#0.77


r <- Z / sqrt(40)
r#0.54

data_long <- data %>%
  dplyr::select(adj_snap_av, adj_reg_av) %>%
  tidyr::pivot_longer(
    cols = everything(),
    names_to = "condition",
    values_to = "score"
  ) %>%
  dplyr::mutate(condition = dplyr::recode(condition,
                                          adj_snap_av = "SNAP",
                                          adj_reg_av = "REGULAR"))

#https://rpkgs.datanovia.com/rstatix/reference/wilcox_effsize.html
wilcox_effsize(
  data_long,
  score ~ condition,
  paired = TRUE,
  alternative = "less"   # SNAP < REGULAR (your hypothesis)
)#0.59 effect size r 





#------------------------------------------------------------------------------------
#PAIRED SAMPLE T TEST
#----------------------------------------------------------------------------------------
#Paired Samples T-TEST TO check for different in participants' preferred IPD and average IPD in baseline
data$`false ipd`<-as.numeric(data$`false ipd`)
data$`IPD Preference`<-as.numeric(data$`IPD Preference`)
data$IPDDIFFERENCE<-data$`IPD Preference`-data$`false ipd`

#CHECK ASSUMPUMTONS
shapiro.test(data$IPDDIFFERENCE)
t.test(data$`IPD Preference`, data$'false ipd', paired = TRUE, alternative = "two.sided")
#SIGNIFICANT

t.test(data$`IPD Preference`, data$'false ipd',  paired = TRUE,    alternative = "less")


data$IPDDIFFERENCE<-data$`IPD Preference`-data$'false ipd'

t.test(data$`IPD Preference...19`, data$falseipd, paired = TRUE, alternative = "two.sided")


t.test(data$'false ipd',data$`IPD Preference`,
       paired = TRUE,
       alternative = "less")
#true mean difference is less than 0

t.test(data$`IPD Preference`, data$'false ipd', paired = TRUE, alternative = "two.sided")
mean(data$`IPD Preference`)
mean(data$`false ipd`)

sd(data$`IPD Preference`)
sd(data$`false ipd`)


cohen.d(data$`IPD Preference`,
        data$`false ipd`,
        paired = TRUE)

diff <- data$`IPD Preference` - data$`false ipd`



#------------------------------------------------------------------------------------
#effect size
#----------------------------------------------------------------------------------------
dz <- mean(diff, na.rm = TRUE) / sd(diff, na.rm = TRUE)
dz#0.52


tt <- t.test(data$`IPD Preference`,
             data$`false ipd`,
             paired = TRUE)

dz <- as.numeric(tt$statistic) / sqrt(length(na.omit(diff)))
dz#0.53


install.packages("effectsize")
library(effectsize)

effectsize::cohens_d(data$`IPD Preference`,
         data$`false ipd`,
         paired = TRUE)#0.52

#------------------------------------------------------------------------------------
#MEDIAN AND SPREAD
#----------------------------------------------------------------------------------------

median(data$adj_snap_av, na.rm = TRUE)
median(data$adj_reg_av, na.rm = TRUE)

IQR(data$adj_snap_av, na.rm = TRUE)
IQR(data$adj_reg_av, na.rm = TRUE)




library(rstatix)
library(coin)
test <- wilcox.test(data$adj_snap_av,
                    data$adj_reg_av,
                    paired = TRUE,
                    exact = FALSE,
                    correct = FALSE)

