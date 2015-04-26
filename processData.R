eventtype <- toupper(c("LOW TIDE", "AVALANCHE", "Blizzard", "Coastal Flood","Cold/Wind","Debris Flow","Dense Fog", "Dense Smoke", "Drought", "Dust Devil", "Dust Storm", "Excessive Heat","Extreme Cold/Wind", "Flash Flood", "Flood","Frost/Freeze", "Funnel Cloud", "Freezing Fog", "Hail", "Heat", "Heavy Rain", "Heavy Snow", "High Surf", "High Wind", "Hurricane|Typhoon", "Ice Storm", "Lake-Effect Snow", "Lakeshore Flood", "Lightning", "Marine Hail", "Marine High Wind", "Marine Strong Wind", "Marine Thunderstorm Wind", "Rip Current", "Seiche", "Sleet", "Storm Surge/Tide", "Strong Wind", "Thunderstorm Wind", "Tornado", "Tropical Depression", "Tropical Storm", "Tsunami", "Volcanic Ash", "Waterspout", "Wildfire", "Winter Storm", "Winter Weather"))
##Load the data
## Download data file if unavailable
if (!file.exists("./repdata-data-StormData.csv.bz2"))
{
  setInternet2(use = TRUE)
  download.file("https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2", "./repdata-data-StormData.csv.bz2", "auto")
}
##Load the data
data <- read.csv(bzfile("./repdata-data-StormData.csv.bz2"), colClasses = "character", header = TRUE)
result <- NULL
for(n in 1:length(eventtype))
{
  ###select data which match the event type
  selected_data <- data[grep(eventtype[n], toupper(data$EVTYPE)),]
  
  ###get death count
  sum_death <- sum(as.numeric(selected_data$FATALITIES))
  
  ###get injury count
  sum_injuries <- sum(as.numeric(selected_data$INJURIES))
  
  ###get property damage
  ####select data from data that match the event type where property damage is in units of h
  prop_h <-selected_data[grep("H", toupper(selected_data$PROPDMGEXP)),]
  ####select data from data that match the event type where property damage is in units of k
  prop_k <-selected_data[grep("K", toupper(selected_data$PROPDMGEXP)),]
  ####select data from data that match the event type where property damage is in units of m
  prop_m <-selected_data[grep("M", toupper(selected_data$PROPDMGEXP)),]
  ####select data from data that match the event type where property damage is in units of b
  prop_b <-selected_data[grep("B", toupper(selected_data$PROPDMGEXP)),]
  ####select data from data that match the event type where property damage is in base unit (i.e. not h, k, m or b)
  prop_norm <-selected_data[grep("H|K|M|B", toupper(selected_data$PROPDMGEXP), invert = TRUE),]
  
  ####calculate the sum of damage for each type of units and convert all to base unit
  sum_prop_h <- sum(as.numeric(prop_h$PROPDMG)) * 100
  sum_prop_k <- sum(as.numeric(prop_k$PROPDMG)) * 1000
  sum_prop_m <- sum(as.numeric(prop_m$PROPDMG)) * 1000000
  sum_prop_b <- sum(as.numeric(prop_b$PROPDMG)) * 1000000000
  sum_prop_norm <- sum(as.numeric(prop_norm$PROPDMG))
  sum_propdmg <- sum_prop_h + sum_prop_k + sum_prop_m + sum_prop_b + sum_prop_norm 
  
  ###get crop damage
  ####select data from data that match the event type where property damage is in units of h
  crop_h <-selected_data[grep("H", toupper(selected_data$CROPDMGEXP)),]
  ####select data from data that match the event type where property damage is in units of k
  crop_k <-selected_data[grep("K", toupper(selected_data$CROPDMGEXP)),]
  ####select data from data that match the event type where property damage is in units of m
  crop_m <-selected_data[grep("M", toupper(selected_data$CROPDMGEXP)),]
  ####select data from data that match the event type where property damage is in units of b
  crop_b <-selected_data[grep("B", toupper(selected_data$CROPDMGEXP)),]
  ####select data from data that match the event type where property damage is in base unit (i.e. not h, k, m or b)
  crop_norm <-selected_data[grep("H|K|M|B", toupper(selected_data$CROPDMGEXP), invert = TRUE),]
  
  ####calculate the sum of damage for each type of units and convert all to base unit
  sum_crop_h <- sum(as.numeric(crop_h$CROPDMG)) * 100
  sum_crop_k <- sum(as.numeric(crop_k$CROPDMG)) * 1000
  sum_crop_m <- sum(as.numeric(crop_m$CROPDMG)) * 1000000
  sum_crop_b <- sum(as.numeric(crop_b$CROPDMG)) * 1000000000
  sum_crop_norm <- sum(as.numeric(crop_norm$CROPDMG))
  sum_cropdmg <- sum_crop_h + sum_crop_k + sum_crop_m + sum_crop_b + sum_crop_norm
  
  ####consolidate result
  result <- rbind (result, c(eventtype[n], sum_death, sum_injuries, sum_propdmg, sum_cropdmg, sum_propdmg + sum_cropdmg)) 
}
result <- data.frame(result, stringsAsFactors = FALSE)
name_list <- c("eventtype", "sum_death", "sum_injuries", "sum_propdmg", "sum_cropdmg", "economic_consequences")
names(result) <- name_list
write.csv(result,"processedData.csv")