# Define content for the First page
# First page allows the user to select different meals, and we
# present a datatable on the emissions of each meal and where the emissions
# come from

page_one <- tabPanel(
  h1("Greenhouse Gas Emissions By Food. What's your carbon footprint?"),
  h4("As greenhouse gas emissions are on the rise and global temperatures with it,
     consumers are more and more likely to make decisions based on their carbon footprint. 
     Food production and agriculture contributes to a large share of these emissions,
     so it . We have borrowed this data from Stephen Clune et al to present an app
     in which consumers can make informed decisions about their diet.")
)
page_two <- tabPanel(
  "Emissions by Food",
  titlePanel("Emissions by Food"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "select",
        label = h3("Meal Choice"),
        choices = list("Hamburger", "burger")
      )
    ),
    mainPanel(
      imageOutput("image"), # picture of meal
      dataTableOutput("table") # datatable of meal
    )
  )
)


source("data_wrangling.R")
source("analysis.R")


#Define content for the Second page
page_three <- tabPanel(
  "Graphical Representations", # label for the tab in the navbar
  titlePanel("Graphical Representations"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "select3",
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
page_four <- tabPanel(
  "Third Page", 
  mainPanel(
    plotlyOutput("plot1")
  )
)

my_ui <- navbarPage(
  "My Application",
  page_one,
  page_two,
  page_three,
  page_four
)
