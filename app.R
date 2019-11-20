library("shiny")          # in each relevant script
library("DT")

source("~/documents/info201/final_proj/info_201_AB05/by_food_analysis.R")

# Define content for the First page
page_one <- tabPanel(
  "Emissions by Food",
  titlePanel("Emissions by Food"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "select",
        label = h3("Meal Choice"),
        choices = list("Hamburger")
      )
    ),
    mainPanel(
      imageOutput("image"),
      dataTableOutput("table")
    )
  )
)

 #Define content for the Second page
page_two <- tabPanel(
  "Second Page" # label for the tab in the navbar
)

 #Define content for the third page
page_three <- tabPanel(
  "Third Page" # label for the tab in the navbar
)

my_ui <- fluidPage(
  "My Application",
  page_one,
  page_two,
  page_three
)

my_server <- function(input, output, session) {
  # Send a pre-rendered image, and don't delete the image after sending it
  output$image <- renderImage({
    #width  <- session$clientData$output_myImage_width
    #height <- session$clientData$output_myImage_height
    filename <- paste0("images/", tolower(input$select), ".png")
    list(src = filename,
           contentType = "image/png",
           width = 400,
           height = 300)
  }, deleteFile = FALSE)
  
  output$table = renderDataTable({
    hamburger
  })
}

shinyApp(ui = my_ui, server = my_server)