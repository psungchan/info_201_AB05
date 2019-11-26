source("data_wrangling.R")
source("analysis.R")

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
    } else if (input$select == "burger") {
      hamburger
    }
  })
  
  output$plot = renderPlot({
    if(input$select3 == "GHG vs Product") { # dont do this... if choice is select 
      ghg_vs_product(simple_df_ghg)
    } 
  })
  
  output$plot1 <- renderPlotly({
    water_usage
  })
}