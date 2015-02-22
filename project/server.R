library(shiny)

# setup data
dEng <- women
dMetric <- women
dMetric$height <- dMetric$height*2.54
dMetric$weight <- dMetric$weight*.453592

fitEng <- lm(weight~height-1, data=dEng)
B1Eng <- coefficients(fitEng)

fitMetric <- lm(weight~height-1, data=dMetric)
B1Metric <- coefficients(fitMetric)

shinyServer(function(input, output) {

  text <- reactive({
    if (input$cbMetric==FALSE) {
      estWeight <- round(B1Eng*input$height,0)
      paste("For height of ", input$height,
            " inches the estimated weight is ", estWeight, " pounds")
    } else {
      estWeight <- round(B1Metric*input$height,0)
      paste("For height of ", input$height,
            " cm the estimated weight is ", estWeight, " kg")
    }
  })
  
  output$caption <- renderText({
    text()
  })
  
  output$weightPlot <- renderPlot({
    if (input$cbMetric==FALSE) {
      estWeight <- B1Eng*input$height
      plot(weight~height, data=dEng, xlim=c(24, 90), ylim=c(20,200),
           main="Women Average Weight vs Height",
           ylab="Weight (lbs)", xlab="Height (in)")
      abline(fitEng)
      points(y=estWeight,x=input$height, pch=5,col="red")
    } else {
      estWeight <- B1Metric*input$height
      plot(weight~height, data=dMetric, xlim=c(24, 210), ylim=c(20,200),
           main="Women Average Weight vs Height",
           ylab="Weight (kg)", xlab="Height (cm)")
      abline(fitMetric)
      points(y=estWeight,x=input$height, pch=5,col="red")
    }
  })
  
})