foods <- read.csv("data/simple_ghg_food.csv", stringsAsFactors = FALSE)
library(dplyr)
library(plotly)
library(stringr)
library(formattable)
library(ggplot2)
library(tidyr)

ggplot(data = foods, mapping = aes(x = GHG.Emissions, y = Freshwater.Withdrawals)) + 
  geom_point(alpha = 0.9) + 
  ggtitle("Food emissions") 
  add_markers(
    text = ~paste("State: ", product, "<br />",
    symbol = I("circle"), hoverinfo = "text",
    marker = list(size = ~num_impacted))
  )

# how to hover and have txt show up? 
  
