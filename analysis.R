#install.packages("readxl")   # run once
library(readxl)
data <- read_excel("C:/Users/CONNOLR3/DOWNLOADS/test.xlsx")
library(tidyverse)
library(ggpubr)
library(tidyr)
library(dplyr)

library(rstatix)

res.aov <- anova_test(data = data, dv = score, wid = id, within = time)
get_anova_table(res.aov)

data$p_reg <data$`PSIAL REGULAR`
data$p_snap <data$`PSIAL SNAP`
long <- long %>%
  gather(key = "id", value = "score", , t2, t3) %>%
  convert_as_factor(id, time)
head(selfesteem, 3)

shapiro.test(data$`PSIAL SNAP`)

shapiro.test(data$`PSIAL REGULAR`)
diff <- data$`PSIAL SNAP` - data$`PSIAL REGULAR`
shapiro.test(diff)

shapiro.test(data$adj_snap...21)
diff <- data$`PSIAL SNAP` - data$`PSIAL REGULAR`
shapiro.test(diff)




data_long <- data %>%
  rename(first_block = `first block`) %>%
  pivot_longer(
    cols = c(`PSIAL SNAP`, `PSIAL REGULAR`),
    names_to = "condition",
    values_to = "PSIAL"
  ) %>%
  mutate(
    condition = recode(
      condition,
      `PSIAL SNAP` = "SNAP",
      `PSIAL REGULAR` = "REGULAR"
    ),
    condition = factor(condition, levels = c("SNAP", "REGULAR")),
    first_block = factor(first_block)
  )


data_long %>%
  group_by(ID) %>%
  identify_outliers(PSIAL)


res.aov <- anova_test(data = data_long, dv = PSIAL, wid = ID, within = condition,between='first_block')
           
                      
      
        
get_anova_table(res.aov)
res.aov
summary(res.aov)


get_anova_table(res.aov, es = "pes")


anovamodel <- aov(
  PSIAL ~ first_block * condition + Error(ID / condition),
  data = data_long
)



## T TEST

t.test(data$falseipd, data$`IPD Preference...19`, paired = TRUE)

