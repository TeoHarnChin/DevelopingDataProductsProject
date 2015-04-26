eventtype <- toupper(c("LOW TIDE", "AVALANCHE", "Blizzard", "Coastal Flood","Cold/Wind","Debris Flow","Dense Fog", "Dense Smoke", "Drought", "Dust Devil", "Dust Storm", "Excessive Heat","Extreme Cold/Wind", "Flash Flood", "Flood","Frost/Freeze", "Funnel Cloud", "Freezing Fog", "Hail", "Heat", "Heavy Rain", "Heavy Snow", "High Surf", "High Wind", "Hurricane|Typhoon", "Ice Storm", "Lake-Effect Snow", "Lakeshore Flood", "Lightning", "Marine Hail", "Marine High Wind", "Marine Strong Wind", "Marine Thunderstorm Wind", "Rip Current", "Seiche", "Sleet", "Storm Surge/Tide", "Strong Wind", "Thunderstorm Wind", "Tornado", "Tropical Depression", "Tropical Storm", "Tsunami", "Volcanic Ash", "Waterspout", "Wildfire", "Winter Storm", "Winter Weather"))


shinyUI(pageWithSidebar(
  headerPanel("Impact of natural events"),
  sidebarPanel(  
    selectInput("Result", "Select Impact", c("Population Health", "Economic Consequences")),
    checkboxGroupInput("Event", "Interested Event Type", eventtype)
  ),
  mainPanel(
    h4(''),
    h3('Introduction'),
    h6('This webapp make use of pre-downloaded data from NOAA Storm Database to perform analysis on respective event-type impact on population health and also their respective economic consequences, according to on a set of user selected inputs. The analysis classify the events based on Section 2.1.1 Storm Data Event Table described in National Weather Service Storm Data Documentation (https://d396qusza40orc.cloudfront.net/repdata%2Fpeer2_doc%2Fpd01016005curr.pdf), although the raw data classify the events into finer resolution. The analysis seeks to identify the event type that causes the most fatalities and injuries respectively. The analysis also seeks to identify the event type that have the greatest economic consequences.'),
    h4(''),
    h3('Selected Inputs'),
    h4(''),
    h4('Interested Result Type'),
    verbatimTextOutput('impact'),
    h4('Selected Event Type'),
    verbatimTextOutput('event'),
    h3('Results'),
    h4(''),
    h4('Data Summary'),
    tableOutput('result'),
    verbatimTextOutput('resultText'),
    plotOutput('impactPlot1'),
    plotOutput('impactPlot2')
  )
))
