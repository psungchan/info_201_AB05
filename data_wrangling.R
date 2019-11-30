# Analysis of GHG emissions by meal

library(dplyr)

simple_df <- read.csv("./data/simple_ghg_food.csv")
global_df <- read.csv("./data/GHG_Foods_Global.csv")
by_food <- read.csv("./data/recipe_calculations.csv")

#----Works with larger df to simplify to ghg emissions by product----------------

global_df$Food.type = trimws(global_df$Food.type)

global_df$Food.type[global_df$Food.type == 'Ling Common'] <- 'Ling'

global_df_ghg <- global_df %>%
  rename(Product = Food.type) %>%
  group_by(Product) %>% 
  summarize(
    GHG.Emissions = sum(as.numeric(kg.CO2.eq.kg.produce..BFM.or.L.after.conversion), na.rm = TRUE) / n()
  ) %>% 
  arrange(-GHG.Emissions)

#write.csv(global_df_ghg)

#-----
global_df <- tail(global_df, -1)

simple_df_ghg <- simple_df %>%  # simplifies df to just ghg emissions
  select(Product, GHG.Emissions) %>% 
  arrange(-GHG.Emissions)

hamburger <- by_food %>% # creates a dataframe for hamburger
  select(Product, Product.Emissions, Hamburger.Meat,
         Hamburger.Veggies, Hamburger.Bun, Hamburger.Total, GHG.Emissions) %>% 
  filter(!is.na(GHG.Emissions))

#----Creates DF for user-input manipulation----------------

user_df <- global_df_ghg %>% 
  mutate(
    Weight = NA,
    Product.Emissions = NA
  )

k <- seq(1, 999)

a <- list()


