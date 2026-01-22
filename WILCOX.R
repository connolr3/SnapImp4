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





