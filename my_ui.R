# Define content for the First page
# First page allows the user to select different meals, and we
# present a datatable on the emissions of each meal and where the emissions
# come from


source("data_wrangling.R")
source("analysis.R")

intro <- tabPanel(
  h1("Greenhouse Gas Emissions By Food... What's your ''food'' print?"),
  h4("As greenhouse gas emissions are on the rise and global temperatures with it,
     consumers are more and more likely to make decisions based on their carbon footprint. 
     Food production and agriculture contributes to a large share of these emissions,
     so it . We have borrowed this data from Stephen Clune et al to present an app
     in which consumers can make informed decisions about their diet.")
)
emissions_by_meal <- tabPanel(
  "Emissions by Meal",
  titlePanel("Emissions by Meal"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "meal_select",
        label = h3("Meal Choice"),
        choices = list("Hamburger")
      ),
      imageOutput("meal_image"), # picture of meal
    ),
    mainPanel(
      h3(textOutput("meal_ghg_text")), #outputs the sum of ghg emissions
      dataTableOutput("meal_table") # datatable of meal
    )
  )
)

#Define content for the Second page
graphs <- tabPanel(
  "Graphical Representations", # label for the tab in the navbar
  titlePanel("Graphical Representations"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "graph_select",
        label = h3("Graph Choice"),
        choices = list("GHG vs Product")
      )
    ),
    mainPanel(
      plotOutput("plot") # plot
    )
  )
)

#Define content for the third page
water_usage <- tabPanel(
  "Water Usage", 
  mainPanel(
    plotlyOutput("plot1")
  )
)

# Define the fourth page
recipe_input <- tabPanel(
  "Input your recipe", 
  mainPanel(
    h1(id = "recipeheader", "Your Recipe"),
    uiOutput("newIngred")
  ),
  sidebarPanel(
    h3(textOutput("user_ghg")),
    actionButton("calculate", "Calculate GHG Emissions"),
    actionButton("add", "Add Ingredient")
  )
)

one_ingredient <- fluidRow(
  id = "ingred",
  column(6,
         selectInput(
           inputId = paste0("ingredient", 1),
           label = h3("Ingredient Choice"),
           choices = sort(user_df$Product)
         )
  ),
  column(6,
         numericInput(
           inputId = "weight",
           label = h3("Amount (kg or L)"),
           value = NA
         )
  )
)

my_ui <- navbarPage(
  "Greenhouse Emissions by Food",
  intro,
  emissions_by_meal,
  graphs,
  water_usage,
  recipe_input
)
