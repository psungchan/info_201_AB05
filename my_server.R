source("data_wrangling.R")
source("analysis.R")
library("dplyr")

my_server <- function(input, output, session) {
  
  #----------Server for first page, meal output-----------------------------
  
  # Send a pre-rendered image, and don't delete the image after sending it
  output$meal_image <- renderImage({
    filename <- paste0("images/", tolower(input$meal_select), ".png") # sets filename to send
    # Note filename is dependent on what user selects
    list(src = filename,
         contentType = "image/png",
         width = 220,
         height = 170)
  }, deleteFile = FALSE)
  
  output$meal_table = renderDataTable({
    tot_weight <- paste0(input$meal_select, ".Total")
    tot_emissions <- paste0(input$meal_select, ".Emissions")
    df <- by_food[, c("Product", "Product.Emissions", tot_weight, "GHG.Emissions")]
    df <- df %>% filter(!is.na(GHG.Emissions))
    DT::datatable(df, options = list(paging = FALSE))
  })
  
  output$meal_ghg_text = renderText({
    tot_weight <- paste0(input$meal_select, ".Total")
    tot_emissions <- paste0("GHG", ".Emissions")
    df <- by_food[tot_emissions]
    df <- na.omit(df)
    ghg_tot = round(sum(df[tot_emissions]), 1)
    message_str <- paste(ghg_tot, "kg CO2 Equivalents")
    message_str
  })
    
  #----Server for plot outputs------------------------------------------
  
  output$plot = renderPlot({
    if(input$graph_select == "GHG vs Product") { # dont do this... if choice is select 
      ghg_vs_product(simple_df_ghg)
    }
  })
  
  output$plot1 <- renderPlotly({
    water_usage
  })
  
  #------Server for user input meal----------------------------------------
  
  observeEvent(input$add, {
    insertUI(
      selector = "#ingred",
      where = "afterEnd",
      ui = one_ingredient
    )
  })
  
  output$user_ghg = renderText({
    emission <- user_df[user_df$Product == input$ingredient, "GHG.Emissions" ]
    weight <- input$weight
    a <-append(a, emission*weight)
    user_tot_emissions <- sum(a)
    str <- paste(user_tot_emissions, "kg CO2")
  })
  
}