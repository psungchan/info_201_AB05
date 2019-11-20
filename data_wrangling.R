# Analysis of GHG emissions by meal

library(dplyr)

simple_df <- read.csv("~/documents/info201/final_proj/info_201_AB05/data/simple_ghg_food.csv")

global_df <- read.csv("~/Documents/info201/final_proj/info_201_AB05/data/GHG_Foods_Global.csv")

by_food <- read.csv("~/Documents/info201/final_proj/info_201_AB05/data/recipe_calculations.csv")

global_df_ghg <- global_df %>% # simplifies to just ghg emissions
  group_by(Food.type) %>% 
  summarize(
    GHG.Emissions = sum(as.numeric(kg.CO2.eq.kg.produce..BFM.or.L.after.conversion), na.rm = TRUE) / n()
  ) %>% 
  rename(Product = Food.type) %>% 
  arrange(-GHG.Emissions)

global_df <- tail(global_df, -1)

simple_df_ghg <- simple_df %>%  # simplifies df to just ghg emissions
  select(Product, GHG.Emissions) %>% 
  arrange(-GHG.Emissions)

hamburger <- by_food %>% # creates a dataframe for hamburger
  select(Product, Product.Emissions, Hamburger.Meat,
         Hamburger.Veggies, Hamburger.Bun, Hamburger.Total, GHG.Emissions) %>% 
  filter(!is.na(Hamburger.Total))





