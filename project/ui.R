library(shiny)

shinyUI(fluidPage(
  titlePanel("Weight Calculator"),

  sidebarLayout(
    sidebarPanel(
      h4("Summary"),
      p("This tool determines the estimated weight of an average American women given a specified height."),
      p("Select a women's height using the below sliderbar."),
      br(),
      sliderInput("height",
                  "Select Height:",
                  min = 25,
                  max = 210,
                  value = 60),
      br(),br(),
      h4("Description"),
      p("The estimated weight is derived from a simple linear regression from the R women dataset (World Almanac and Book of Facts, 1975) which specifies the average height of American women aged 30-39."),
      p("The red diamond in the plot signifies the specified height/weight on the regression fit."),
      br(),br(),
      h4("Display Units"),
      p("Select checkbox to display in metric units."),
      checkboxInput("cbMetric", label = "Metric Units", value = FALSE)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("weightPlot"),
      h4(textOutput("caption"))
    )

  )
))