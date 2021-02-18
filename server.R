### Etablit, si elle(s) existe(nt), les gares de correspondance entre 2 villes

library("ggplot2") ; library(ggrepel) ; library(ggmap)
tabtot <- read.csv("tab_gares_main(wiki)_max.csv")[,c(2:5)]
world_map <- map_data("world",region="France")

tabtot[,1] <- as.character(tabtot[,1])
tabm <- read.csv("garesmaxnumber.csv") ; tabm[] <- lapply(tabm, as.character)

library(shiny)
server3 <- function(input, output, session) {
    output$plot1 <- renderPlot({
      ardep <- intersect(as.character(tabm[1,c(2:175)])[type.convert(unname(unlist(tabm[which(grepl(input$dep, tabm$X)),c(2:175)])))],
                         as.character(tabm[1,c(2:175)])[type.convert(unname(unlist(tabm[which(grepl(input$arriv, tabm$X)),c(2:175)])))])
      ggplot(world_map) +
        geom_polygon(aes(x = long, y = lat,group=group),fill="lightgray", colour = "white")+ geom_point(data=subset(tabtot,gare %in% c(input$dep,input$arriv)), aes(x=lon,y=lat), size=2, color="red")+
        geom_text_repel(data=subset(tabtot,gare %in% c(input$dep,input$arriv)),aes(x = lon, y = lat,label=gare),vjust=2,color="red")+
        geom_point(data=subset(tabtot,gare %in% ardep), aes(x=lon,y=lat), size=2, alpha=0.5)+
        geom_text_repel(data=subset(tabtot,gare %in% ardep),aes(x = lon, y = lat,label=gare),vjust=2) +
        xlab("") + ylab("") + theme(axis.ticks = element_blank(), axis.text = element_blank())
      
    })
    output$resume <- renderPrint({
      ardep <- intersect(as.character(tabm[1,c(2:175)])[type.convert(unname(unlist(tabm[which(grepl(input$dep, tabm$X)),c(2:175)])))],
                         as.character(tabm[1,c(2:175)])[type.convert(unname(unlist(tabm[which(grepl(input$arriv, tabm$X)),c(2:175)])))])
      if(length(ardep)==0){cat("Pas de gare de correspondance")}
      else{
        if (length(ardep)==1){cat("Gare de correspondance : \n")}
        else{cat("Gares de correspondance : \n")}
        cat(paste('-', ardep), sep = '\n') 
      }})
    output$tabm <- renderTable(tabm)
  }
