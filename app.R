library(shiny)              # untuk membuat shiny App
library(shinydashboard)     # untuk membuat dashboard
library(DT)                 # untuk membuat data table

# Define UI for application that draws a histogram
ui <- dashboardPage(title = "www.Students-Performance.com",
    
    # membuat header dashboard
    dashboardHeader(
        title = "Student Performance"
    ),
    
    # membuat sidebar
    dashboardSidebar(
        
        # membuat side menu
        sidebarMenu(
            
            
            # menu dashboard
            menuItem(text = "Dashboard",
                     icon = icon("dashboard"),
                     tabName = "dshbrd"),
            
            # menu tabel data
            menuItem(text = "Table",
                     icon = icon("table"),
                     tabName = "table"),
            
            # menu untuk referensi data
            menuItem(text="Reference",
                     icon = icon("link"),
                     href = "https://www.kaggle.com/spscientist/students-performance-in-exams")
        )
    ),
    
    # membuat body dashboard
    dashboardBody(
        tabItems(
            
            # tab item untuk menu utama
            tabItem(tabName = "dshbrd",
                    fluidRow(
                        valueBoxOutput("avg_mathscore",
                                       width = 4),
                        valueBoxOutput("avg_readscore",
                                       width = 4),
                        valueBoxOutput("avg_writescore",
                                       width = 4),
                        box(title = "Parental Level of Education",
                            solidHeader = F,
                            status = "primary",
                            width = 6,
                            plotOutput("parentedcplot")),
                        box(title = "Average of Exam Score by Gender",
                        solidHeader = F,
                        status = "primary",
                        width = 6,
                        plotOutput("avgplot"))
                    )),
            
            # tab item untuk table
            tabItem(tabName = "table",
                fluidRow(
                    box(status = "success",
                        solidHeader = T,
                        width = 12,
                        
                        # menampilkan output tabel
                        dataTableOutput("datatable"))
                )
            )
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    # menampilkan notifikasi pembuat dashboard
    showNotification("Created by Rizky Adi Pratama",
                     duration = 5,
                     closeButton = T,
                     type = "message")
    
    # output data table pada side menu "table"
    output$datatable <- renderDataTable({
        studentsPerf})
    
    # output value box
    # rata2 math score
    output$avg_mathscore <- renderValueBox({
        valueBox(value = mean(studentsPerf$Math_Score),
                 subtitle = "Average of Math score",icon = icon("divide"),color = "red",width = 4)
    })
    
    # rata rata reading score
    output$avg_readscore <- renderValueBox({
        valueBox(value = mean(studentsPerf$Reading_Score),
                 subtitle = "Average of Reading Score",icon = icon("book-open"),color = "yellow",width = 4)
    })
    
    # rata rata writing score
    output$avg_writescore <- renderValueBox({
        valueBox(value = mean(studentsPerf$Writing_Score),
                 subtitle = "Average of Writing Score",icon = icon("pencil-alt"),color = "teal",width = 4)
    })
    
    output$parentedcplot <- renderPlot({
        bar})
    

    output$avgplot <- renderPlot({
        bar_2
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
