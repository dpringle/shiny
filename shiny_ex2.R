
# load shiny, create UI then the server, then run shinyApp()

source('context.R')

# Always define Inputs in ui
# Then refer to them in server
# Shiny provides a wide variety of inputs that allows users to provide:
# test (textInput, selectInput), 
# numbers (numericInput, sliderInput), 
# booleans (checkBoxInput, radioInput), and 
# dates (dateInput, dateRangeInput).


#Adding an input to a shiny app is a two step process, 
#where you first add an ___Input(“x”) function to the UI and 
#then access its value in the server using input$x.

#For example, if you want users to choose an animal from a list, 
#you can use a selectInput, and refer to the chosen value as input$animal:

# ui <- fluidPage(
#   titlePanel("What's in a Name?"),
#   # Add select input named "sex" to choose between "M" and "F"
#   selectInput('sex', 'Select Sex', choices = c("F", "M")),
#   # CODE BELOW: Add slider input named 'year' to select years  (1900 - 2010)
#   
#   # Add plot output to display top 10 most popular names
#   plotOutput('plot_top_10_names')
# )
# 
# server <- function(input, output, session){
#   # Render plot of top 10 most popular names
#   output$plot_top_10_names <- renderPlot({
#     # Get top 10 names by sex and year
#     top_10_names <- babynames %>% 
#       filter(sex == input$sex) %>% 
#       # MODIFY CODE BELOW: Filter for the selected year
#       filter(year == 1900) %>% 
#       slice_max(prop, n = 10)
#     # Plot top 10 names by sex and year
#     ggplot(top_10_names, aes(x = name, y = prop)) +
#       geom_col(fill = "#263e63")
#   })
# }
# 
# shinyApp(ui = ui, server = server)

# --

# ui <- fluidPage(
#   titlePanel("What's in a Name?"),
#   # Add select input named "sex" to choose between "M" and "F"
#   selectInput('sex', 'Select Sex', choices = c("F", "M")),
#   # Add slider input named "year" to select year between 1900 and 2010
#   sliderInput('year', 'Select Year', min = 1900, max = 2010, value = 1900),
#   # CODE BELOW: Add table output named "table_top_10_names"
#   tableOutput("table_top_10_names")
# )
# 
# server <- function(input, output, session){
#   # Function to create a data frame of top 10 names by sex and year 
#   top_10_names <- function(){
#     babynames %>% 
#       filter(sex == input$sex) %>% 
#       filter(year == input$year) %>% 
#       slice_max(prop, n = 10)
#   }
#   # CODE BELOW: Render a table output named "table_top_10_names"
#   output$table_top_10_names <- renderTable({
#     top_10_names()
#   })
# }
# 
# shinyApp(ui = ui, server = server)

# ui <- fluidPage(
#   titlePanel("What's in a Name?"),
#   # Add select input named "sex" to choose between "M" and "F"
#   selectInput('sex', 'Select Sex', choices = c("M", "F")),
#   # Add slider input named "year" to select year between 1900 and 2010
#   sliderInput('year', 'Select Year', min = 1900, max = 2010, value = 1900),
#   # MODIFY CODE BELOW: Add a DT output named "table_top_10_names"
#   DT::DTOutput('table_top_10_names')
# )
# 
# server <- function(input, output, session){
#   top_10_names <- function(){
#     babynames %>% 
#       filter(sex == input$sex) %>% 
#       filter(year == input$year) %>% 
#       slice_max(prop, n = 10) %>%
#       DT::datatable()
#   }
#   # MODIFY CODE BELOW: Render a DT output named "table_top_10_names"
#   output$table_top_10_names <- DT::renderDT({
#     top_10_names()
#   })
# }
# 
# shinyApp(ui = ui, server = server)

ui <- fluidPage(
  selectInput('name', 'Select Name', top_trendy_names$name),
  # CODE BELOW: Add a plotly output named 'plot_trendy_names'
  plotly::plotlyOutput('plot_trendy_names')
)
server <- function(input, output, session){
  # Function to plot trends in a name
  plot_trends <- function(){
    babynames %>% 
      filter(name == input$name) %>% 
      ggplot(aes(x = year, y = prop)) +
      geom_col()
  }
  # CODE BELOW: Render a plotly output named 'plot_trendy_names'
  output$plot_trendy_names <- plotly::renderPlotly({
    plot_trends()
  })
  
  
}
shinyApp(ui = ui, server = server)
