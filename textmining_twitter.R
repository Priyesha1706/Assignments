library("twitteR")
## Warning: package 'twitteR' was built under R version 3.5.1
library("ROAuth")
## Warning: package 'ROAuth' was built under R version 3.5.1
library(base64enc)
library(httpuv)
## Warning: package 'httpuv' was built under R version 3.5.1
library(tm)
## Warning: package 'tm' was built under R version 3.5.1
## Loading required package: NLP
## Warning: package 'NLP' was built under R version 3.5.1
library(wordcloud)
## Warning: package 'wordcloud' was built under R version 3.5.1
## Loading required package: RColorBrewer
library(wordcloud2)
library(syuzhet)
## Warning: package 'syuzhet' was built under R version 3.5.1
library(lubridate)
## Warning: package 'lubridate' was built under R version 3.5.1
## 
## Attaching package: 'lubridate'
## The following object is masked from 'package:base':
## 
##     date
library(ggplot2)
## Warning: package 'ggplot2' was built under R version 3.5.1
## 
## Attaching package: 'ggplot2'
## The following object is masked from 'package:NLP':
## 
##     annotate
library(scales)
## Warning: package 'scales' was built under R version 3.5.1
## 
## Attaching package: 'scales'
## The following object is masked from 'package:syuzhet':
## 
##     rescale
library(reshape2)
library(dplyr)

cred <- OAuthFactory$new(consumerKey='BagGgBbanzbdpPNNp8Uy6TQBP', # Consumer Key (API Key)
                         consumerSecret='pFxap1Jzc1fClDQ9psLNU3RKSQ5FvS2PhJz8E2R7ix0cawPKfa', #Consumer Secret (API Secret)
                         requestURL='https://api.twitter.com/oauth/request_token',                accessURL='https://api.twitter.com/oauth/access_token',                 authURL='https://api.twitter.com/oauth/authorize')

save(cred, file="twitter authentication.Rdata")
load("twitter authentication.Rdata")

#Access Token Secret

setup_twitter_oauth("BagGgBbanzbdpPNNp8Uy6TQBP", # Consumer Key (API Key)
                    "pFxap1Jzc1fClDQ9psLNU3RKSQ5FvS2PhJz8E2R7ix0cawPKfa", #Consumer Secret (API Secret)
                    "1076425245521731584-Ev31ZLB7Cf0idVMqDI8BxiVG2SgRnu",  # Access Token
                    "ZVUw0Z0mFrX7d6sjQxuB08l48JHhmnjmlAm86G2OPG7BS")  #Access Token Secret
## [1] "Using direct authentication"
#registerTwitterOAuth(cred)

Tweets <- userTimeline('facebook', n = 1000,includeRts = T)
TweetsDF <- twListToDF(Tweets)
dim(TweetsDF)
## [1] 1000   16
View(TweetsDF)
setwd("C:\\Users\\nitin\\Desktop\\priyesha assignment\\Text Mining\\TwitterAnalysis")

write.csv(TweetsDF, "Tweets.csv",row.names = F)

getwd()

facebook <- read.csv("C:\\Users\\nitin\\Desktop\\priyesha assignment\\Text Mining\\TwitterAnalysis")
str(facebook)
corpus <- facebook$text
corpus <- Corpus(VectorSource(corpus))
inspect(corpus[1:5])
corpus <- tm_map(corpus,tolower)
inspect(corpus[1:5])
corpus <- tm_map(corpus,removePunctuation)
inspect(corpus[1:5])
corpus <- tm_map(corpus,removeNumbers)
inspect(corpus[1:5])
inspect(corpus[1:5])
cleanset<-tm_map(corpus,removeWords, stopwords('english'))
inspect(cleanset[1:5])
removeURL <- function(x) gsub('http[[:alnum:]]*','',x)
cleanset <- tm_map(cleanset, content_transformer(removeURL))
inspect(cleanset[1:5])
cleanset<-tm_map(cleanset,removeWords, c('facebook','can'))
cleanset <- tm_map(cleanset, gsub,pattern = 'pages', replacement = 'page')
inspect(cleanset[1:5])
cleanset <- tm_map(cleanset,stripWhitespace)
inspect(cleanset[1:5])
#Term Document Matrix :
# Convert the unstructured data to structured data :
tdm <- TermDocumentMatrix(cleanset)
tdm

tdm <- as.matrix(tdm)
tdm[1:10,1:20]

w <- rowSums(tdm)  # provides the no of times a particular word has been used.
w <- subset(w, w>= 25) # Pull words that were used more than 25 times.
barplot(w, las = 2, col = rainbow(50))

# Word Cloud :

w <- sort(rowSums(tdm), decreasing = TRUE) # Sort words in decreasing order.
set.seed(123)
wordcloud(words = names(w), freq = w, 
          max.words = 250,random.order = F,
          min.freq =  3, 
          colors = brewer.pal(8, 'Dark2'),
          scale = c(5,0.3),
          rot.per = 0.6)
w <- data.frame(names(w),w)
colnames(w) <- c('word','freq')
wordcloud2(w,size = 0.5, shape = 'triangle', rotateRatio = 0.5, minSize = 1)

letterCloud(w,word = "F",frequency(5), size=1)
# Sentiment Analysis for tweets:


 install.packages("syuzhet")

# Read File 
fbdata <- read.csv(file.choose(), header = TRUE)
tweets <- as.character(fbdata$text)
class(tweets)
s <- get_nrc_sentiment(tweets)
head(s)
tweets[4]

get_nrc_sentiment('pretending')

get_nrc_sentiment('can learn') #1 for positive
barplot(colSums(s), las = 2.5, col = rainbow(10),
        ylab = 'Count',main= 'Sentiment scores for Facebook Tweets')
