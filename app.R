install.packages("shiny") # once per machine
library("shiny")          # in each relevant script

# Define content for the First page
page_one <- tabPanel(
  "First Page", # label for the tab in the navbar
  # ...more content would go here...
  h1("Heading 1")
)

# Define content for the Second page
page_two <- tabPanel(
  "Second Page" # label for the tab in the navbar
  # ...more content would go here...
)

# Define content for the third page
page_three <- tabPanel(
  "Third Page" # label for the tab in the navbar
  # ...more content would go here...
)

my_ui <- navbarPage(
  "My Application",
  page_one,
  page_two,
  page_three
)

my_server <- function(input, output){
  
}

shinyApp(ui = my_ui, server = my_server)