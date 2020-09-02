install.packages("tidyverse")
install.packages("matrix")
install.packages("recommenderlab")
install.packages("kableExtra")
install.packages("gridExtra")
library(tidyverse)
library(Matrix)
library(recommenderlab)
library(kableExtra)
library(gridExtra)

Book_rate_data <- read.csv("C:\\Users\\nitin\\Desktop\\priyesha assignment\\Recommended system\\Book.csv")
# table dimensions
dim(book_ratings)
#metadata about the variable
str(Book_rate_data1)
#rating distribution
hist(Book_rate_data$Book.Rating)
#the datatype should be realRatingMatrix inorder to build recommendation engine
Book_rate_data_matrix <- as(Book_rate_data, 'realRatingMatrix')
#Popularity based 

Book_recomm_model1 <- Recommender(Book_rate_data_matrix, method="POPULAR")

#Predictions for two users 
recommended_items1 <- predict(Book_recomm_model1, Book_rate_data_matrix[1000:1001], n=5)
as(recommended_items1, "list")


## Popularity model recommends the same movies for all users , we need to improve our model using # # Collaborative Filtering

#User Based Collaborative Filtering
Book_recomm_model2 <- Recommender(Book_rate_data_matrix, method="UBCF")

#Predictions for two users 
recommended_items2 <- predict(Book_recomm_model2, Book_rate_data_matrix[1000:1001], n=5)
as(recommended_items2, "list")

