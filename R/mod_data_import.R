#' data_import UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_data_import_ui <- function(id){
  ns <- NS(id)
  tagList(
    fileInput(ns("file"), "Choose CSV File",
              multiple = FALSE,
              accept = c("text/csv",
                         "text/comma-separated-values,text/plain",
                         ".csv")),
    tableOutput(ns("contents"))
  )
}

#' data_import Server Functions
#'
#' @noRd
mod_data_import_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    data <- reactive({
      req(input$file$datapath)
      read.csv(input$file$datapath)
    })

    output$contents <- renderTable({
      data()
    })
      return(data)
  })
}

## To be copied in the UI
# mod_data_import_ui("data_import_1")

## To be copied in the server
# mod_data_import_server("data_import_1")
