#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinydashboard
#' @import shinythemes
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    shinyUI(
      navbarPage(
        windowTitle = "App Landing Page",
        title = div(img(src = "bftb_logo_v8_bare.png", height = "30px"), "Clinical Data Analysis"),
        theme = shinythemes::shinytheme("cerulean"),
        tabPanel("Toolbox", icon = icon("wrench"),
                 shinydashboard::dashboardPage(
                   skin = "black",
                   header = shinydashboard::dashboardHeader(title = "Clinical Data Analysis", titleWidth = 400),
                   shinydashboard::dashboardSidebar(
                     width = 300 ,
                     shinydashboard::sidebarMenu(
                       shinydashboard::menuItem(
                         "Import Data", tabName = "data_import", icon = icon("database")
                       ),
                       shinydashboard::menuItem("Data Analysis", tabName = "data_analysis", icon = icon("magnifying-glass-chart"),
                                                shinydashboard::menuSubItem("Exploratory Data Analysis",tabName = "ana_eda",icon = icon("fas fa-map-signs")),
                                                shinydashboard::menuSubItem("Propensity Score Matching",tabName = "ana_psm",icon = icon("equals")),
                                                shinydashboard::menuSubItem("Kaplan-Miere Analysis",tabName = "ana_km",icon = icon("stairs"))
                       ),
                       shinydashboard::menuItem(
                         "Data Visualization", tabName = "data_viz", icon = icon("chart-simple")
                       )
                     )
                   ),
                   shinydashboard::dashboardBody(
                     mod_data_import_ui("data_table"),
                     mod_km_plot_ui("km_plot")
                   )
                 ))
      )))
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "ClinicalDataAnalysis"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
