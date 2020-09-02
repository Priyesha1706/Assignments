
library(shiny)
library(shinydashboard)
library(ggplot2)
library(ggthemes)
library(party)
library(caret)
library(plotly)
library(curl)
library(RCurl)
library(e1071)
library(rpart)
library(ranger)
library(glmnet)
library(mlbench)
library(psych)
library(dplyr)
library(lattice)
credit_data <- read.csv("C:\\Priyesha Data Science\\Project\\P28_balance\\data.csv")

median_impute_model = preProcess(credit_data[names(credit_data)],method="medianImpute")
credit_data = predict(median_impute_model,credit_data)
sort(sapply(credit_data, function(x) sum(length(which(is.na(x)))))/nrow(credit_data),decreasing = TRUE)

attach(credit_data)


ui <- dashboardPage(skin = "yellow",
  dashboardHeader(title = "Dashboard"
                    ),
                    dashboardSidebar(
                      sidebarMenu(
                        menuItem("Input", tabName = "Input", icon = icon("dashboard")),
                        menuItem("Summary", tabName = "Summary", icon = icon("th")),
                        menuItem("Visualizations", icon = icon("th"),
                                 menuSubItem("BarPlot", tabName = "BarPlot"),
                                 menuSubItem("ScatterPlot", tabName = "ScatterPlot"),
                                 menuSubItem("Histogram", tabName = "Histogram"),
                                 menuSubItem("Model", tabName = "Model")),
                        menuItem("Results", tabName = "Results", icon = icon("th"))
                      )
                    ),
                    dashboardBody( 
                      # Boxes need to be put in a row (or column)
                      tabItems(
                        # First tab content
                        
                        tabItem(tabName = "Input",
                                h2("Input Details"),
                                fluidRow(
                                  box(title = "Model Parameters",
                                      width = 3, background = "purple",
                                      radioButtons(inputId = "model",label=h5(" Revolving Balance Prediction Model"),
                                                   choices = c("Lasso","Ridge","Linear"),selected = "Lasso"),
                                      numericInput("cv", label = h5("Cross Validations"), value = 3),
                                      numericInput("tl", label = h5("tuneLength"), value = 3)
                                  ),
                                  box(title = "Enter Loan Amount",
                                      height = 130,width = 3, background = "lime",
                                      numericInput("loan_amnt", label = h6(""), value = 14350)
                                  ),
                                  box(title = "Select Intrest Rate Category",
                                      height = 130,width = 3, background = "olive",
                                      numericInput("Rate_of_intrst",label=h6(""),
                                                  value = 8)
                                  ),
                                  box(title = "Select  Grade",
                                      height = 130,width = 3, background = "blue",
                                      selectInput(inputId = "grade",label=h6(""),
                                                  choices = c("A","B","C","D","E",
                                                              "F","G"),selected = "C")
                                  ),
                                  box(title = "Select Employment Length",
                                      height = 130,width = 3, background = "lime",
                                      selectInput(inputId = "Experience",label=h6(""),
                                                  choices = c("0-2","2-4","4-6","6-10",
                                                              "10-15","15-30","30-45",
                                                              "45+","Missing"),selected = 6-10)
                                  ),
                                  box(title = "Select Home Ownership Type",
                                      height = 130,width = 3, background = "olive",
                                      selectInput(inputId = "home_ownership",label=h6(""),
                                                  choices = c("MORTGAGE","OTHER","OWN","RENT"),selected = "MORTGAGE")
                                  ),
                                  box(title = "Enter Annual Income",
                                      height = 130,width = 3, background = "blue",
                                      numericInput("annual_inc", label = h6(""), value = 105000)
                                  ),
                                  box(title = "Submission",
                                      height = 90,width = 3, background = "red",
                                      actionButton("submit","Submit")
                                  )
                                )
                        ),
                        
                        tabItem(tabName = "BarPlot",
                                h2("Barplots"),
                                fluidRow(
                                  box(title = "Bar Plots",  width = 9,  background = "red",
                                      status = "primary", solidHeader = TRUE, collapsible = TRUE,
                                      plotlyOutput("view1")
                                  ),
                                  box(title = "X-Axis Variable",  background = "black", width = 3, height=120,
                                      status = "warning", solidHeader = TRUE, collapsible = TRUE,
                                      selectInput(inputId = "two",label=h6(""),
                                                  choices = c("Rate_of_intrst","Experience","home_ownership","loan_status","grade"),selected = "grade")
                                  ),
                                  box(title = "Fill Variable",  width = 3,  background = "red", height=120,
                                      status = "primary", solidHeader = TRUE, collapsible = TRUE,
                                      selectInput(inputId = "one",label=h6(""),
                                                  choices = c("Rate_of_intrst","Experience","home_ownership","grade"),selected = "grade")
                                  ),
                                  box(title = "Opacity Control",  background = "black", width = 3,  height=140,
                                      status = "warning", solidHeader = TRUE, collapsible = TRUE,
                                      sliderInput("slider1", "Opacity:", 0, 1, 0.85)
                                  )
                                )
                        ),
                        
                        tabItem(tabName = "ScatterPlot",
                                h2("ScatterPlots"),
                                fluidRow(
                                  box(title = "Scatter Plots",  width = 9,  background = "red",
                                      status = "primary", solidHeader = TRUE, collapsible = TRUE,
                                      plotlyOutput("view2")
                                  ),
                                  box(title = "X Axis Variable",  width = 3,  background = "red", height=110,
                                      status = "primary", solidHeader = TRUE, collapsible = TRUE,
                                      selectInput(inputId = "three",label=h6(""),
                                                  choices = c("loan_amnt","annual_inc"),selected = "loan_amnt")
                                  ),
                                  box(title = "Y Axis Variable",  width = 3,  background = "red", height=110,
                                      status = "primary", solidHeader = TRUE, collapsible = TRUE,
                                      selectInput(inputId = "four",label=h6(""),
                                                  choices = c("loan_amnt","annual_inc","Rate_of_intrst",
                                                              "Experience","home_ownership","grade"),selected = "annual_inc")
                                  ),
                                  box(title = "Fill Variables",  width = 3,  background = "red", height=120,
                                      status = "primary", solidHeader = TRUE, collapsible = TRUE,
                                      selectInput(inputId = "five",label=h6(""),
                                                  choices = c("Rate_of_intrst","Experience","home_ownership","grade"),selected = "ir_cat")
                                  ),
                                  box(title = "Control",  background = "black", width = 3, height=270,
                                      status = "warning", solidHeader = TRUE, collapsible = TRUE,
                                      sliderInput("slider4", label=h5("Dataset Length"), 0, 29091, 4500),
                                      sliderInput("slider2", label=h5("Opacity"), 0, 1, 0.85)
                                  )
                                )
                        ),
                        
                        tabItem(tabName = "Histogram",
                                h2("Histograms"),
                                fluidRow(
                                  box(title = "Histogram",  width = 9,  background = "red",
                                      status = "primary", solidHeader = TRUE, collapsible = TRUE,
                                      plotlyOutput("view3")
                                  ),
                                  box(title = "X Axis Variable",  width = 3,  background = "red", height=120,
                                      status = "primary", solidHeader = TRUE, collapsible = TRUE,
                                      selectInput(inputId = "six",label=h6(""),
                                                  choices = c("loan_amnt","annual_inc"),selected = "loan_amnt")
                                  ),
                                  box(title = "Opacity Control",  background = "black", width = 3, height=135,
                                      status = "warning", solidHeader = TRUE, collapsible = TRUE,
                                      sliderInput("slider3", "Opacity:", 0, 1, 0.85)
                                  ),
                                  box(title = "Fill Variable",  width = 3,  background = "red", height=120,
                                      status = "primary", solidHeader = TRUE, collapsible = TRUE,
                                      selectInput(inputId = "seven",label=h6(""),
                                                  choices = c("Rate_of_intrst","Experience","home_ownership","grade"),selected = "home_ownership")
                                  )
                                )
                        ),
                        tabItem(tabName = "Model",
                                h2("Model"),
                                fluidRow(
                                  box(title = "Bar Plots",  width = 9,  background = "red",
                                      status = "primary", solidHeader = TRUE, collapsible = TRUE,
                                      plotOutput("view4")
                                  )
                                )
                        ),
                        
                        # Second tab content
                        tabItem(tabName = "Summary",
                                h2("Summary"),
                                fluidRow(
                                  box(title = "Dataset Summary", background = "purple",
                                      width = 10,
                                      status = "primary", solidHeader = TRUE, collapsible = TRUE,
                                      verbatimTextOutput("summary1")
                                  ),
                                  box(title = "Model Summary", background = "purple",width = 7, 
                                      status = "primary",solidHeader = TRUE, collapsible = TRUE,
                                      verbatimTextOutput("summary")
                                  )
                                )
                        ),
                        tabItem(tabName = "Results",
                                h2("Prediction"),
                                fluidRow(
                                  box(title = "Entered Observation", background = "orange",width = 12,
                                      status = "primary", solidHeader = TRUE, collapsible = TRUE,
                                      tableOutput("table")
                                  ),
                                  box(title = "Revolving Balance Prediction", background = "red", 
                                      status = "primary",  solidHeader = TRUE, collapsible = TRUE,
                                      verbatimTextOutput("predt")
                                  )
                                )
                        )
                      )
                    )
)


server <- function(input, output) {
  datainput = reactive({
    
    credit_data <- read.csv("C:\\Priyesha Data Science\\Project\\P28_balance\\data.csv")
    
    median_impute_model = preProcess(credit_data[names(credit_data)],method="medianImpute")
    credit_data = predict(median_impute_model,credit_data)
    sort(sapply(credit_data, function(x) sum(length(which(is.na(x)))))/nrow(credit_data),decreasing = TRUE)
    
    
    credit_data$emp_cat <- rep(NA, length(credit_data$Experience))
    credit_data$emp_cat[which(credit_data$Experience <= 2)] <- "0-2"
    credit_data$emp_cat[which(credit_data$Experience > 2 & credit_data$Experience <= 4)] <- "2-4"
    credit_data$emp_cat[which(credit_data$Experience > 4 & credit_data$Experience <= 6)] <- "4-6"
    credit_data$emp_cat[which(credit_data$Experience > 6 & credit_data$Experience <= 10)] <- "6-10"
    credit_data$emp_cat[which(credit_data$Experience > 10 & credit_data$Experience <= 15)] <- "10-15"
    credit_data$emp_cat[which(credit_data$Experience > 15 & credit_data$Experience <= 30)] <- "15-30"
    credit_data$emp_cat[which(credit_data$Experience > 30 & credit_data$Experience <= 45)] <- "30-45"
    credit_data$emp_cat[which(credit_data$Experience> 45)] <- "45+"
    credit_data$emp_cat[which(is.na(credit_data$Experience))] <- "Missing"
    credit_data$emp_cat <- as.factor(credit_data$Experience)
    credit_data$Experience=NULL
    credit_data$ir_cat <- rep(NA, length(credit_data$Rate_of_intrst))
    credit_data$ir_cat[which(credit_data$Rate_of_intrst <= 8)] <- "0-8"
    credit_data$ir_cat[which(credit_data$Rate_of_intrst > 8 & credit_data$Rate_of_intrst <= 11)] <- "8-11"
    credit_data$ir_cat[which(credit_data$Rate_of_intrst > 11 & credit_data$Rate_of_intrst <= 13.5)] <- "11-13.5"
    credit_data$ir_cat[which(credit_data$Rate_of_intrst > 13.5)] <- "13.5+"
    credit_data$ir_cat[which(is.na(credit_data$Rate_of_intrst))] <- "Missing"
    credit_data$ir_cat <- as.factor(credit_data$ir_cat) 
    credit_data$Rate_of_intrst=NULL
    
    credit_data$total.revol_bal = as.factor(credit_data$total.revol_balance)
    
  })
  
  test = reactive({
    if (input$submit > 0) {
      df <- data.frame(loan_amnt = (input$loan_amnt),Rate_of_intrst = (input$Rate_of_intrst),grade = (input$grade),
                       Experience = (input$Experience), home_ownership = (input$home_ownership),
                       annual_inc = (input$annual_inc))
                       
      
      return(list(df=df))
    }
  })
  
  
  fn2 = reactive({
    credit_data <- read.csv("C:\\Priyesha Data Science\\Project\\P28_balance\\data.csv")
    new_data <- credit_data %>% select(loan_amnt,Rate_of_intrst,annual_inc,grade,total.revol_bal,home_ownership,Experience)
    new_data <- new_data %>% mutate(Rate_of_intrst = as.numeric(sub("%","", Rate_of_intrst)),
                                    total.revol_bal = as.numeric(total.revol_bal),
                                    loan_amnt = as.numeric(loan_amnt),annual_inc = as.numeric(annual_inc))
    
    # imputing na values
    
    median_impute_model = preProcess(new_data[names(new_data)],method="medianImpute")
    newdata = predict(median_impute_model,new_data)
    sort(sapply(newdata, function(x) sum(length(which(is.na(x)))))/nrow(newdata),decreasing = TRUE)
    
    
    
    # Data Partition
    set.seed(222)
    ind <- sample(2, nrow(newdata), replace = T, prob = c(0.7, 0.3))
    loan_train <- newdata[ind==1,]
    loan_test <- newdata[ind==2,]
    
    
    
    # Custom Control Parameters
    custom <- trainControl(method = "cv",
                           number = 5,
                           repeats = 3,
                           verboseIter = T)
    
    
    set.seed(1234)
    model <- train(total.revol_bal~.,
                   loan_train,
                   method='glmnet',
                   tuneGrid= expand.grid(alpha=1, lambda= seq(0.001,1, length=5)),
                   trControl=custom)
    
    # Plot Results
    plot(model)
    plot(model$finalModel, xvar = 'lambda', label=T)
    
    model
  })
  
  new_theme = theme(panel.background = element_blank(),
                    axis.line.x   = element_line(color='black'),
                    axis.line.y   = element_line(color='black'),
                    axis.ticks    = element_line(color='black'),
                    axis.title.x  = element_text(family="Times",face = "bold", size = 12),
                    axis.title.y  = element_text(family="Times",face = "bold", size = 12),
                    axis.text     = element_text(family="Trebuchet MS",face = "italic", size = 10),
                    legend.title  = element_text(family="Times",face = "bold", size = 8),
                    legend.text   = element_text(family="Trebuchet MS",face = "italic", size = 8))
  
  
  output$view1 = renderPlotly({
    if (input$submit > 0) {
      p1 = ggplot(data = credit_data, aes_string(x = input$two, fill = input$one)) +
        geom_bar(alpha = input$slider1) + theme_igray()+ new_theme
      ggplotly(p1) 
    }
    else{
      NULL
    }
  })
  
  output$view2 = renderPlotly({
    if (input$submit > 0) {
      data = credit_data
      data = data[1:input$slider4, ]
      p2 = ggplot(data = credit_data, aes_string(x = input$three,y =input$four,  col = input$five)) +
        geom_point(alpha = input$slider2) + theme_igray()+ new_theme
      ggplotly(p2) 
    }
    else{
      NULL
    }
  })
  
  output$view3 = renderPlotly({
    if (input$submit > 0) {
      #barplot(table(datainput()$Sex), main="BarPlot - Sex Distribution", names.arg = c("Female","Male"),col="grey")
      p3 = ggplot(data = credit_data, aes_string(x = input$six, fill = input$seven)) +
        geom_histogram(alpha = input$slider3) + theme_igray()+ new_theme
      ggplotly(p3) 
    }
    else{
      NULL
    }
  })
  
  output$view4 = renderPlot({
    if (input$submit > 0) {
      model = fn2()
      plot(model)
    }
    else{
      NULL
    }
  })
  
  
  output$summary1 = renderPrint({
    if (input$submit > 0) {
      summary(credit_data)
    }
    else{
      NULL
    }
  })
  
  output$table = renderTable({
    if (input$submit > 0) {
      test()$df
    }
    else{
      NULL
    }
  })
  
  output$predt <- renderText({
    if (input$submit > 0) {
      test = test()$df
      #credit_data = datainput()
      credit_data_1 = credit_data[ ,c(2,5,6,9,10,11)]
      ww =(rbind(credit_data_1,test))
      test = ww[29092, ]
      model = fn2()
      pred = predict(model,test)
      
      if(pred>0) {
        print(paste('Revolving Balance', toString(pred)))
      }
      else{
        print("null")
      }
    }
    else{
      NULL
    }
  })
  
  output$summary <- renderPrint({
    if (input$submit > 0) {
      (fn2())
    }
    
    else{
      NULL
    }
    
  })
}


shinyApp(ui, server)
