data <- read.csv("./processedData.csv", colClasses = "character", header = TRUE)
data <- data[,2:ncol(data)]

shinyServer(
  function(input, output) {    
    output$event <- renderPrint({input$Event})
    output$impact <- renderPrint({input$Result})
    output$result <-renderTable({
    ##filterdata
    result <- data[NULL,]        
    for (n in 1:length(input$Event)){
      result <- rbind(result, data[data[,1] == input$Event[n],])
    }
    result    
    })
    output$resultText <- renderPrint({
      result <- data[NULL,]
      resultText <- NULL
      for (n in 1:length(input$Event)){
        result <- rbind(result, data[data[,1] == input$Event[n],])
      }
      if (length(input$Event) >0 ){
        if (input$Result == "Population Health"){
          ##get result for event that cause the most fatalities
          max_death <- subset(result, result[,2] == as.character(max(as.numeric(result[,2]))))[,1]
          
          ##get result for event that cause the most injuries
          max_injuries <- subset(result, result[,3] == as.character(max(as.numeric(result[,3]))))[,1]
          resultText <- paste('The event type that causes most deaths and most injuries are <<', max_death, '>> and <<', max_injuries, '>> respectively.', collapse = '')
        }
        if (input$Result == "Economic Consequences"){
          ##get result for event that has the greatest economic consequences
          max_dmg <- subset(result, result[,6] == as.character(max(as.numeric(result[,6]))))[,1]
          resultText <- paste('The event type that causes the most economic damage is <<', max_dmg, '>>.', collapse = '')
        }  
      }
      resultText
    })
    output$impactPlot1 <- renderPlot({
      eventtype <- input$Event
      result <- data[NULL,]        
      ##filterdata      
      if (length(input$Event) >0){
        for (n in 1:length(input$Event)){
          result <- rbind(result, data[data[,1] == input$Event[n],])
        }
        
        if (input$Result == "Population Health"){
          ##plot the graphs that answer which type of event is most harmful to population health
          plot(x = 1:length(eventtype), y=result[,2], pch=17, type = "h", col = "blue", main = "Fatalities by Event Type", ylab = "Fatalities", xaxt = "n", xlab = "")
          axis(1, at = 1:length(eventtype), labels = result[,1], las = 2, cex.axis = 0.5)
        }
        if (input$Result == "Economic Consequences")
        {
          par(mfrow = c(1,1), mar = c(6, 4, 4, 2) + 0.1, bg = "transparent")
          plot(x = 1:length(eventtype), y= as.numeric(result[,6])/1000000, pch=17, type = "h", col = "blue", main = "Damages Event Type", ylab = "Damages (millions of dollars)", xaxt = "n", xlab = "")
          axis(1, at = 1:length(eventtype), labels = result[,1], las = 2, cex.axis = 0.5)
        }
        
      }      
    })
    output$impactPlot2 <- renderPlot({
      eventtype <- input$Event
      result <- data[NULL,]        
      ##filterdata      
      if (length(input$Event) >0){
        for (n in 1:length(input$Event)){
          result <- rbind(result, data[data[,1] == input$Event[n],])
        }
        
        if (input$Result == "Population Health"){
          ##plot the graphs that answer which type of event is most harmful to population health
          plot(x = 1:nrow(result), y=as.numeric(result[,3])/1000, pch=17, type = "h", col = "blue", main = "Injuries by Event Type", ylab = "Injuries (cases in thousands)", xaxt = "n", xlab = "")
          axis(1, at = 1:length(eventtype), labels = result[,1], las = 2, cex.axis = 0.5)
        }
      }
      
    })
    
    
  }
)
