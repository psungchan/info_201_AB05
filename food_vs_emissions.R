foods <- read.csv("data/simple_ghg_food.csv", stringsAsFactors = FALSE)
library(dplyr)
library(plotly)
library(stringr)
library(formattable)
library(ggplot2)
library(tidyr)

ggplot(data = foods, mapping = aes(x = GHG.Emissions, y = Freshwater.Withdrawals)) + 
  geom_point(alpha = 0.9)
