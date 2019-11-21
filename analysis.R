# Analysis and Plots

library(dplyr)
library(plotly)
library(ggplot2)
library(leaflet)

<<<<<<< HEAD
source("./data_wrangling.R")
=======
source("./info_201_AB05/data_wrangling.R")
>>>>>>> 60da63752a54692b3a2e82752b4d1ee6ab8b0e2b

ghg_vs_product <- function(df) {
  bar <- qplot(
    reorder(Product, -GHG.Emissions),
    GHG.Emissions,
    data = df,
    geom = "col",
    xlab = "Product",
    ylab = "GHG Emissions (kg CO2 / FU)"
  )
  bar <- bar + theme(axis.text.x = element_text(angle = 90, hjust = 1))
  return(bar)
}

ghg_vs_product(simple_df_ghg)

water_usage <- function(){
  plot <- plot_ly(simple_df, x = ~Freshwater.Withdrawals, 
               y = ~Product, type = 'bar', 
               name = 'water Usage')
  return(plot)
}
