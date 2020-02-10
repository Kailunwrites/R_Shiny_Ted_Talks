library(DT)
library(shiny)
library(googleVis)


shinyServer(function(input, output){
    
    # show bar plot or scatter plot using googleVis or ggplot
    ###CODE HERE
    # output$bar <- renderPlot({
    # bar_data() %>%
    #         ggplot(aes(reorder(event, input$selected), input$selected, fill = name)) +
    #         geom_bar(stat = "identity", position = position_dodge()) + theme(
    #             legend.position = "none",
    #             axis.text.x = element_text(angle = 90),
    #             plot.title = element_text(size = 15, hjust = 0.5)
    #         ) + labs(x = "Event", y = "Views in Million", title = "Top 10 Most Viewed talks") +
    #         coord_flip() + geom_label_repel(
    #             aes(label = name, fill = factor(event)),
    #             fontface = "bold",
    #             color = "white",
    #             box.padding = 0.30
    #         )
    # })
    
    bar_data <- reactive({
        selected <- sym(input$selected)
        out_bar <- ted_df_bar %>% select(event, input$selected)
        
        out2_bar <-  out_bar %>%
            group_by(event) %>%
            summarise(sum = sum(!!selected)) %>% 
            arrange(desc(sum)) %>% 
            top_n(n = 10)
        out2_bar
    })
    
    output$bar <- renderGvis({
        gvisBarChart(bar_data(),options=list(
            width=600, height=280))
    })
    
    # this is a function 
    hist_data <- reactive({ 
        out <- ted_df %>% select(input$selected) 
        out2 <- out[(out[, 1] < input$num_high) &
                        (out[, 1] > input$num_low), ] %>% 
            as.data.frame()
        out2
    })
    
    # show histogram using googleVis
    output$hist <- renderGvis({
        gvisHistogram(hist_data(), options=list(
            width=600, height=280) )
    })
    
    output$hist_2 <- renderGvis({
        gvisHistogram(ted_df2[,input$selected2, drop=FALSE])
    })
    
    output$bar_2 <- renderGvis({
        gvisBarChart(ted_theme,options=list(
            width=600, height=280))
    })
    
    # show data using DataTable
    output$table <- DT::renderDataTable({
        datatable(ted_df_display, rownames=FALSE) %>% 
            formatStyle(input$selected, background="skyblue", fontWeight='bold')
    })
    
    # show statistics using infoBox
    output$maxBox <- renderInfoBox({
        max_value <- max(ted_df[,input$selected])
        max_talk <- 
            ted_df$name[ted_df[,input$selected] == max_value]
        infoBox("Most Popular", max_talk, icon = icon("thumbs-up"))
    })
    
    output$maxBox2 <- renderInfoBox({
        max_value2 <- max(ted_df2[,input$selected2])
        max_talk2 <-
            ted_df2$name[ted_df2[,input$selected2] == max_value2]
        infoBox(paste("Most", input$selected2), max_talk2, icon = icon("hand-o-up"))
    })
    
    output$minBox <- renderInfoBox({
        min_value <- min(ted_df[,input$selected])
        min_talk <- 
            ted_df$name[ted_df[,input$selected] == min_value]
        infoBox("Least Popular", min_talk, icon = icon("thumbs-down"))
    })
    

    
    
    # output$avgBox <- renderInfoBox(
    #     infoBox(paste("AVG.", input$selected),
    #             mean(ted_df[,input$selected]), 
    #             icon = icon("calculator"), fill = TRUE))
    
    # output$avgBox2 <- renderInfoBox(
    #     infoBox(paste("AVG.", input$selected2),
    #             mean(ted_df2[,input$selected2]),
    #             icon = icon("calculator"), fill = TRUE))
})

