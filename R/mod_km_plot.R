#' km_plot UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @import survival
mod_km_plot_ui <- function(id){
  ns <- NS(id)
  tagList(
    # Input for time and event status
    # numericInput("time", "Time:", value = 0, min = 0),
    # checkboxInput("status", "Event Status:", value = FALSE),
    # actionButton("add_data", "Add Data"),
    # Output for KM plot
    plotOutput(ns("km_plot"))
  )
}

#' km_plot Server Functions
#'
#' @noRd
mod_km_plot_server <- function(id, data){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    # Generate KM plot
    output$km_plot <- renderPlot({
      req(data())
      # Create survival object
      surv_obj <- Surv(data()[["time"]], data()[["status"]])
      # Create KM plot
      plot(survfit(surv_obj~ 1), xlab = "Time", ylab = "Survival Probability", main = "Kaplan-Meier Plot")
    })
  })
}

## To be copied in the UI
# mod_km_plot_ui("km_plot_1")

## To be copied in the server
# mod_km_plot_server("km_plot_1")
