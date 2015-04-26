App Description:

This webapp make use of pre-downloaded data from NOAA Storm Database to perform analysis on respective event-type impact on population health and also their respective economic consequences, according to on a set of user selected inputs. The analysis classify the events based on Section 2.1.1 Storm Data Event Table described in National Weather Service Storm Data Documentation (https://d396qusza40orc.cloudfront.net/repdata%2Fpeer2_doc%2Fpd01016005curr.pdf), although the raw data classify the events into finer resolution. The analysis seeks to identify the event type that causes the most fatalities and injuries respectively. The analysis also seeks to identify the event type that have the greatest economic consequences.

Webapp Use Instructions:

This webapp allow the user to select, using the input panel (sidebarPanel), whether to show impact result for Population Health or Economic Consequences, and the event types to consider. The result is automatically refreshed at the main panel (mainPanel) as soon as changes are made at the input panel.   

Also Note:

This application make use of raw data downloaded from the NOAA Storm Database. Pre-processing the raw data to extract required information takes up significant time. In this project, the raw data is pre-processed for used by the webapp such that the webapp do not take up significant amount of time to process the raw data each time the webapp is launched. While the the pre-processing code could have been included within the source codes for this particular webapp, the decision was made to intentionally exclude this portion of the code. Whether the raw data is pre-processed separately is irrelevant in this context of a course module project.

The R code for the pre-processing the raw data is shown in processData.R.