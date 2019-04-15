library(shiny)
library(ggplot2)
library(tidyr)

ui <- fluidPage(
   
   titlePanel("Investing Modalities"),
   
   fluidRow(
      column(4,
         sliderInput("amount",
                     "Initial Amount",
                     min = 1,
                     max = 100000,
                     value = 1000,
                     step = 500,
                     pre = '$')
      ),
      column(4,
             sliderInput("rate",
                         "Return Rate (in%)",
                         min = 0,
                         max = 20,
                         value = 5,
                         step = 0.1)
      ),
      column(4,
             sliderInput("years",
                         "Years",
                         min = 0,
                         max = 50,
                         value = 10,
                         step = 1)
      ),
      column(4,
             sliderInput("annual",
                         "Annual Contribution",
                         min = 0,
                         max = 50000,
                         value = 2000,
                         step = 500,
                         pre = '$')
      ),
      column(4,
             sliderInput("growth",
                         "Growth Rate (in%)",
                         min = 0,
                         max = 20,
                         value = 2,
                         step = 1)
      ),
      column(4,
             selectInput("facet",
                         "Facet?",
                         choices = list("Yes"=1,"No"=2),
                         selected = 2)
      ),
      column(12,
             h4("Timelines"),
             plotOutput("timelines")
      ),
      column(12,
             h4("Balances"),
             verbatimTextOutput("balances")
             )

   )
)

#' @title Future Value Function
#' @description computes the future value of an investment
#' @param amount initial invested amount
#' @param rate annual rate of return
#' @param years number of years
#' @return future value of an investment
future_value <- function(amount, rate, years){
  result <- amount*(1+rate)^years
  return(result)
}

#' @title Future Value of Annuity Function
#' @description computes the future value of annuity
#' @param contrib contributed amount 
#' @param rate annual rate of return
#' @param years number of years
#' @return future value of annuity
annuity <- function(contrib, rate, years){
  result <- contrib*((1+rate)^years-1)/rate
  return(result)
}

#' @title Future Value of Growing Annuity Function
#' @description computes the future value of growing annuity
#' @param contrib contributed amount 
#' @param rate annual rate of return
#' @param growth annual growth rate
#' @param years number of years
#' @return future value of annuity
growing_annuity <- function(contrib, rate, growth, years){
  result <- contrib*((1+rate)^years-(1+growth)^years)/(rate-growth)
  return(result)
}

server <- function(input, output) {
  
  modalities <- reactive({
    data.frame(years=0:input$years,
               no_contrib=future_value(input$amount, (input$rate)/100, 0:input$years),
               fixed_contrib=future_value(input$amount, (input$rate)/100, 0:input$years)+annuity(input$annual, (input$rate)/100, 0:input$years),
               growing_contrib=future_value(input$amount, (input$rate)/100, 0:input$years)+growing_annuity(input$annual, (input$rate)/100, (input$growth)/100, 0:input$years)
    )})
  modalities1 <- reactive({data.frame(years=0:input$years,
                                      variable='no_contrib',
                                      value=future_value(input$amount, (input$rate)/100, 0:input$years))})
  modalities2 <- reactive({data.frame(years=0:input$years,
                                      variable='fixed_contrib',
                                      value=future_value(input$amount, (input$rate)/100, 0:input$years)+annuity(input$annual, (input$rate)/100, 0:input$years))})
  modalities3 <- reactive({data.frame(years=0:input$years,
                                      variable='growing_contrib',
                                      value=future_value(input$amount, (input$rate)/100, 0:input$years)+growing_annuity(input$annual, (input$rate)/100, (input$growth)/100, 0:input$years))})

  modalities_facet <- reactive(rbind(modalities1(),modalities2(),modalities3()))
  
    output$timelines <- renderPlot({
      if (input$facet==2){
        ggplot(data=modalities())+
          geom_line(aes(x=years,y=no_contrib,colour="blue"))+
          geom_line(aes(x=years,y=fixed_contrib,colour="green"))+
          geom_line(aes(x=years,y=growing_contrib,colour="red"))+
          geom_point(aes(x=years,y=no_contrib,colour="blue"), size=0.5)+
          geom_point(aes(x=years,y=fixed_contrib,colour="green"), size=0.5)+
          geom_point(aes(x=years,y=growing_contrib,colour="red"), size=0.5)+
          labs(x='Year', y="Value($)",title="Three modes of investing")+
          scale_x_continuous(breaks = seq(0,input$years,1))+
          scale_color_manual(values=c("red","green","blue"),
                             labels=c("no_contrib","fixed_contrib","growing_contrib"),
                             name="variable")+
          theme(legend.text=element_text(family="Times",size=10))
      }else{
        ggplot(data=modalities_facet(), aes(x = years, y = value))+
          geom_line(aes(col = variable)) + 
          geom_area(aes(fill = variable), alpha=0.5) +
          theme_bw()+
          labs(x='Year', y="Value($)",title="Three modes of investing")+
          facet_wrap(~ variable)
        
      }
    })

    output$balances <- renderPrint({
      modalities()
      })


}

# Run the application 
shinyApp(ui = ui, server = server)

