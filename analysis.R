# Analysis and Plots

library(dplyr)
library(plotly)
library(ggplot2)
library(leaflet)

source("./info_201_AB05/data_wrangling.R")

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

