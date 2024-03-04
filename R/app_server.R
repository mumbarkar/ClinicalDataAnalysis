#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic
  # mod_histogram_server("hist1")
  input_data <- mod_data_import_server("data_table")
  mod_km_plot_server("km_plot", data = input_data)
}
