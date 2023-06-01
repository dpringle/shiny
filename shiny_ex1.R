
# load shiny, create UI then the server, then run shinyApp()

source('context.R')
library(shiny)

# # Ex. 1
# ui <- fluidPage("Hello, world!")
# server <- function(input, output, session){}
# shinyApp(ui=ui, server=server)
# 
# # Ex. 2
# 
# ui <- fluidPage(
#   textInput("name", "What is your name?"),
#   # CODE BELOW: Display the text output, greeting
#   # Make sure to add a comma after textInput()
#   textOutput("greeting")
# )
# 
# server <- function(input, output) {
#   # CODE BELOW: Render a text output, greeting
#   output$greeting <- renderText(
#     paste("Hello, ", {input$name})
#   )
#   }
# 
# shinyApp(ui = ui, server = server)
# 
# Ex. 3

ui <- fluidPage(
  titlePanel("Baby Name Explorer"),
  sidebarLayout(
    sidebarPanel(textInput('name', 'Enter Name', 'David')),
    mainPanel(plotOutput('trend'))
  )
)

server <- function(input, output, session) {
  output$trend <- renderPlot({
    # CODE BELOW: Update to display a line plot of the input name
    ggplot(subset(babynames, name == input$name)) +
      geom_line(aes(x = year, y = prop, color = sex))
    
    
  })
}

shinyApp(ui = ui, server = server)
