#install.packages("readxl")   # run once
library(readxl)
library(tidyverse)
library(ggpubr)
library(tidyr)
library(dplyr)
library(rstatix)
library(effsize)


data <- read.csv("C:/Users/connolr3/DOWNLOADS/paths.csv")
plot(data$z,data$x)


library(ggplot2)



library(dplyr)
library(ggplot2)


data <- data %>%
  group_by(`Participant.ID`, Teleport) %>%
  mutate(step = row_number())



data <- data %>%
  group_by(`Participant.ID`, Teleport) %>%
  mutate(
    final_teleport = row_number() == n()
  ) %>%
  ungroup()


data<-data[!data$IN.ZONE == "no", ]


ggplot(data,
       aes(x = x, y = z,
           group = interaction(`Participant.ID`, Teleport))) +
 # geom_path(alpha = 0.4) +
  geom_point(aes(x = 0, y = 10), colour = "black", size = 6) +
  scale_x_continuous(limits = c(-3, 3)) +
  scale_y_continuous(limits = c(0, 10)) +
  geom_point(aes(colour = IN.ZONE), size = 2) +
  coord_equal() +
  theme_minimal()


ggplot(data,
       aes(x = x, y = z,
           group = interaction(`Participant.ID`, Teleport))) +
  geom_point(aes(x = 0, y = 10), colour = "black", size = 6) +
  scale_x_continuous(limits = c(-3, 3)) +
  scale_y_continuous(limits = c(0, 10)) +
  
  # all teleport locations
  geom_point(aes(colour = IN.ZONE), size = 2) +
  
  # final teleport locations with black border
  geom_point(
    data = subset(data, final_teleport == TRUE),
    aes(x = x, y = z, fill = IN.ZONE),
    shape = 21,
    colour = "black",
    size = 2,
    stroke = 1
  ) +
  
  coord_equal() +
  theme_minimal()

