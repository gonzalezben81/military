
##Military map
library(shiny)
library(rgdal)
library(leaflet)
library(dplyr)

military <- readOGR(dsn = "/srv/shiny-server/apps/military/data",layer = "tl_2016_us_mil")
#military <- readOGR(dsn = "data",layer = "tl_2016_us_mil")

military@data
names(military)
militaryframe<-as.data.frame(military)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
  militarymap<- leaflet() %>%
    addTiles(group = "OSM (default)") %>%
    addProviderTiles("Stamen.Toner", group = "Toner") %>%
    addProviderTiles("Stamen.TonerLite", group = "Toner Lite") %>%
    addPolygons(data = military,popup = military$FULLNAME) %>%
    addMeasure() %>% 
    addMiniMap() %>% 
    addLayersControl(
      baseGroups = c("OSM (default)", "Toner", "Toner Lite"),
            options = layersControlOptions(collapsed = TRUE)
    ) %>% 
    addEasyButton(easyButton(
      icon="fa-globe", title="Zoom to Level 1",
      onClick=JS("function(btn, map){ map.setZoom(1); }"))) %>%
    addEasyButton(easyButton(
      icon="fa-crosshairs", title="Locate Me",
      onClick=JS("function(btn, map){ map.locate({setView: true}); }")))
  
  output$militarymap <-  renderLeaflet(militarymap)
  
}
