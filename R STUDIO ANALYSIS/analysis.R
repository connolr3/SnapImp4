#install.packages("readxl")   # run once
library(readxl)
library(tidyverse)
library(ggpubr)
library(tidyr)
library(dplyr)
library(ggplot2)
library(rstatix)


#data <- read_excel("C:/Users/rosie/DOWNLOADS/test.xlsx")
data <- read_excel("C:/Users/connolr3/DOWNLOADS/test.xlsx")


#COMPARING  THE PSIAL SCORES with teleport type as within subject factor
#block order as between subjects factor

#res.aov <- anova_test(data = data, dv = score, wid = id, within = time)
#get_anova_table(res.aov)
data<-data[1:20,0:32]
data$p_reg <-data$`PSIAL REGULAR`
data$p_snap <-data$`PSIAL SNAP`




#A p-value above 0.05 means the data are CONSISTENT with normal
shapiro.test(data$`PSIAL SNAP`)#normal  (not significant, cannot reject normality

shapiro.test(data$`PSIAL REGULAR`)#normal


diff <- data$`PSIAL SNAP` - data$`PSIAL REGULAR`
shapiro.test(diff)#normal

shapiro.test(data$adj_snap...21)



data_long <- data %>%
  rename(first_block = `first block...8`) %>%
  pivot_longer(
    cols = c(`PSIAL SNAP`, `PSIAL REGULAR`),
    names_to = "condition",
    values_to = "PSIAL"
  ) %>%
  mutate(
    condition = dplyr::recode(
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

#no outliers
res.aov <- anova_test(data = data_long, dv = PSIAL, wid = ID, within = condition,between='first_block')
           
                      
      
        
get_anova_table(res.aov)
res.aov
summary(res.aov)


get_anova_table(res.aov)

#Eta squared = SSeffect / SStotal


anovamodel <- aov(
  PSIAL ~ first_block * condition + Error(ID / condition),
  data = data_long
)


#AVERAGES
mean(data$`PSIAL SNAP`)
mean(data$`PSIAL REGULAR`)
#summary(data)
sd(data$`PSIAL SNAP`)
sd(data$`PSIAL REGULAR`)

## T TEST
data$`false ipd`<-as.numeric(data$`false ipd`)
data$`IPD Preference`<-as.numeric(data$`IPD Preference`)
t.test(data$`false ipd`, data$`IPD Preference`, paired = TRUE)#SIGNIFICANT







data_long <- data %>%
  rename(first_block = `first block`) %>%   # standardize name
  pivot_longer(
    cols = c(`PSIAL SNAP`, `PSIAL REGULAR`),  # columns to pivot
    names_to = "condition",
    values_to = "PSIAL"
  ) %>%
  mutate(
    condition = recode(condition,
                       `PSIAL SNAP` = "SNAP",
                       `PSIAL REGULAR` = "REGULAR"),
    condition = factor(condition, levels = c("SNAP", "REGULAR")),
    first_block = factor(first_block),
    ID = factor(ID)   # make sure ID is a factor
  )

# Quick check
head(data_long)





ggplot(data_long, aes(x = condition, y = PSIAL, fill = condition)) +
  geom_violin(trim = FALSE, alpha = 0.4) +        # violin to show distribution
  geom_boxplot(width = 0.2, outlier.shape = NA) + # boxplot inside
  geom_jitter(width = 0.1, size = 2, alpha = 0.6) + # individual points
  stat_summary(fun = mean, geom = "point", shape = 23, size = 3, fill = "white") + # mean marker
  labs(
    title = "PSIAL Scores by Condition",
    x = "Condition",
    y = "PSIAL Score"
  ) +
  theme_minimal(base_size = 14) +
  scale_fill_brewer(palette = "Set2") +
  theme(
    legend.position = "none",
    plot.title = element_text(face = "bold", hjust = 0.5)
  )


ggplot(data_long, aes(x = condition, y = PSIAL, fill = condition)) +
  geom_boxplot(width = 0.2, outlier.shape = NA) + # boxplot inside
  geom_jitter(width = 0.1, size = 2, alpha = 0.6) + # individual points
  stat_summary(fun = mean, geom = "point", shape = 23, size = 3, fill = "white") + # mean marker
  labs(
    title = "PSIAL Scores by Condition",
    x = "Condition",
    y = "PSIAL Score"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    legend.position = "none",
    plot.title = element_text(face = "bold", hjust = 0.5)
  )+
  theme(
    legend.position = "none",
    plot.background = element_rect(fill = "#f5faff", color = NA),
    panel.background = element_rect(fill = "#f5faff", color = NA),
    plot.title = element_text(face = "bold", hjust = 0.5)
  )


























#OLD DATA
old_data<-data[0:10,]


old_data_long <- old_data %>%
  rename(first_block = `first block...8`) %>%
  pivot_longer(
    cols = c(`PSIAL SNAP`, `PSIAL REGULAR`),
    names_to = "condition",
    values_to = "PSIAL"
  ) %>%
  mutate(
    condition = dplyr::recode(
      condition,
      `PSIAL SNAP` = "SNAP",
      `PSIAL REGULAR` = "REGULAR"
    ),
    condition = factor(condition, levels = c("SNAP", "REGULAR")),
    first_block = factor(first_block)
  )


old_data_long %>%
  group_by(ID) %>%
  identify_outliers(PSIAL)

#no outliers
old.res.aov <- anova_test(data = old_data_long, dv = PSIAL, wid = ID, within = condition,between='first_block')




get_anova_table(old.res.aov)
old.res.aov
summary(old.res.aov)













#SPATIAL ABILITU

library(psych )
corr.test(data$SBSOD, data$adj_reg_av)
cor(data$SBSOD, data$adj_reg_av)

cor.test(data$SBSOD, data$adj_reg_av)#not significant
cor.test(data$SBSOD, data$adj_snap_av)#not significant

cor.test(data$SBSOD, data$`PSIAL SNAP`)#not significant
cor.test(data$SBSOD, data$`PSIAL REGULAR`)#not significant


cor.test(data$SBSOD, data$`IPD Preference`)#not significant

cor.test(data$SBSOD, data$`Snap Magnitude...9`)#SIGNIFICANT
cor.test(data$SBSOD, data$`Snap Magnitude...13`)#not significant
cor.test(data$SBSOD, data$`Snap Magnitude...11`)#not significant


cor.test(data$SBSOD, data$`AVERAGE ADJUSTMENT MAG`)#not significant


