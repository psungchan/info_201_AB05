library("shiny")          # in each relevant script
library("DT")

source("~/documents/info201/final_proj/info_201_AB05/data_wrangling.R")
source("~/documents/info201/final_proj/info_201_AB05/analysis.R")

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
        choices = list("Hamburger")
      )
    ),
    mainPanel(
      imageOutput("image"), # picture of meal
      dataTableOutput("table") # datatable of meal
    )
  )
)

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
      plotOutput("plot"), # plot
    )
  )
)

 #Define content for the third page
page_four <- tabPanel(
  "Third Page" # label for the tab in the navbar
)

my_ui <- navbarPage(
  "My Application",
  page_one,
  page_two,
  page_three,
  page_four
)

my_server <- function(input, output, session) {
  # Send a pre-rendered image, and don't delete the image after sending it
  output$image <- renderImage({
    #width  <- session$clientData$output_myImage_width
    #height <- session$clientData$output_myImage_height
    filename <- paste0("images/", tolower(input$select), ".png") # sets filename to send
                                                 # Note filename is dependent on what user
                                                 # selects
    list(src = filename,
           contentType = "image/png",
           width = 400,
           height = 300)
  }, deleteFile = FALSE)
  
  output$table = renderDataTable({
    if(input$select == "Hamburger") {
      hamburger
    }
  })
  
  output$plot = renderPlot({
    if(input$select3 == "GHG vs Product") {
      ghg_vs_product(simple_df_ghg)
    }
  })
}

shinyApp(ui = my_ui, server = my_server)