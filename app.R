library(shiny)
library(DT)

# Load your adsl dataset here
adsl <- dataADaM$ADSL
adsl <- adsl %>% select(c("USUBJID", "SEX", "RACE", "ETHNIC", "TRT01P", "TRT01A", "TRTSDT", "TRTEDT"))
adsl <- as.data.frame(unclass(adsl), stringsAsFactors = TRUE)
# Define UI for application
ui <- fluidPage(
  # Application title
  titlePanel("Demographic Table"),
  
  # Show a plot of the generated distribution
  mainPanel(
    DTOutput('dmtable')
  )
)

# Define server logic required
server <- function(input, output) {
  output$dmtable <- renderDT({
    datatable(adsl,
              extensions = 'Buttons',
              options = list(
                dom = 'Bfrtip',
                buttons = c('copy', 'csv', 'excel', 'pdf', 'print', 'colvis'),
                pageLength = 10,
                lengthMenu = c(10, 25, 50, 100),
                searchHighlight = TRUE,
                columnDefs = list(list(
                  targets = 1,
                  render = JS(
                    "function(data, type, row, meta) {
                    return '<a href=\"pdfs/subjectProfile-' + data + '.pdf\" download>' + data + '</a>';
                  }"
                  )
                ))
              ),
              filter = 'top', escape = FALSE) 
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
