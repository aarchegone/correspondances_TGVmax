### Etablit, si elle(s) existe(nt), les gares de correspondance entre 2 villes
tabtot <- read.csv("tab_gares_main(wiki)_max.csv")[,c(2:5)]
library("ggplot2") ; library(ggrepel) ; library(ggmap) ; library(maps)
world_map <- map_data("world",region="France")

tabtot[,1] <- as.character(tabtot[,1])
tabm <- read.csv("garesmaxnumber.csv") ; tabm[] <- lapply(tabm, as.character)
library("ggplot2") ; library(ggrepel) ; library(ggmap)
library(shiny)
ui3 <- fluidPage(titlePanel("Gare(s) TGVMax de correspondance"),
    sidebarLayout(
      sidebarPanel(
        fluidRow(
          selectInput('dep', 'Départ',tabm[,1], selected = tabm[130,1]),
          selectInput('arriv', 'Arrivée', tabm[,1], selected = tabm[120,1]),
          #selectInput('ncorr', 'Nombre de correspondances', c(1:3)),
          br()),
        hr(),
        fluidRow(verbatimTextOutput("resume"))),
      mainPanel(
        plotOutput('plot1',width = "100%", height = "800px"),
        hr())))

