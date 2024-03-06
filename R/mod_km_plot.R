#' km_plot UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @import survival survminer
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
      fit <- survfit(Surv(data()[["time"]], data()[["status"]]) ~ data() [["sex"]], data = data())

      # Create KM plot
      ggsurvplot(
        fit,                      # Survival object
        data = data(),
        risk.table = "abs_pct",        # Add number of subjects at risk
        # pval = TRUE,              # Show p-value of the log-rank test
        conf.int = TRUE,          # Show confidence intervals
        # palette = c("#E7B800", "#2E9FDF", "#FC4E07"),
        xlab = "Time",
        ylab = "Probability of Overall Survival",
        break.time.by = 90,        # Setting break points for the x axis
        risk.table.y.text.col = T, # Color code the text in the risk table
        risk.table.y.text = FALSE,  # Disable row names in the risk table
        risk.table.height = 0.3,  # Adjust this value as needed
        ncensor.plot.height = 0.2
      )
      # plot(fit, xlab = "Time", ylab = "Survival Probability", main = "Kaplan-Meier Plot")
    })
  })
}

## To be copied in the UI
# mod_km_plot_ui("km_plot_1")

## To be copied in the server
# mod_km_plot_server("km_plot_1")
