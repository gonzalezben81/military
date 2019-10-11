#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

##Military map
library(shiny)
library(rgdal)
library(leaflet)
library(dplyr)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  leafletOutput("militarymap",width = "auto",height = "625px")))
