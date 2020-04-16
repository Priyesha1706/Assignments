mydata<-read.csv("C:\\Users\\nitin\\Desktop\\priyesha assignment\\PCA\\wine.csv") ## use read.csv for csv files
View(mydata)
attach(mydata)
cor(mydata)
# cor = TRUE use correlation matrix for getting PCA scores
?princomp
pcawine <-princomp(mydata,cor = TRUE, scores = TRUE,covmat = NULL)
str(pcawine)
## princomp(mydata, cor = TRUE) not_same_as prcomp(mydata, scale=TRUE); similar, but different
summary(pcawine)
loadings(pcawine)
plot(pcawine)
# graph showing importance of principal components 
# Comp.1 having highest importance (highest variance)
biplot(pcawine)
# Showing the increase of variance with considering principal components
# Which helps in choosing number of principal components
?cumsum
plot(cumsum(pcawine$sdev*pcawine$sdev)*100/(sum(pcawine$sdev*pcawine$sdev)),type="b")
#pcaObj$loadings
pcawine$scores[,1:3]# Top 3 PCA Scores which represents the whole data
# cbind used to bind the data in column wise
# Considering top 3 principal component scores and binding them with mydata
mydata <- cbind(mydata,pcawine$scores[,1:3])
View(mydata)
# preparing data for clustering (considering only pca scores as they represent the entire data)
clus_wine <- mydata[,15:17]
# Normalizing the data 
normalize_wine <- scale(clus_wine)# Scale function is used to normalize data
dist_wine <- dist(clus_wine,method = "euclidean")
# method for finding the distance
# here I am considering Euclidean distance
# Clustering the data using hclust function --> Hierarchical
fit_wine <- hclust(dist_wine,method = "complete")
# method here is complete linkage
plot(fit_wine)# Displaying Dendrogram
group_wine <- cutree(fit_wine,k=5)
rect.hclust(fit_wine,k = 5,plot(fit_wine,hang = -1),border ="red")
# Cutting the dendrogram for 5 clusters
wine_plot <- as.matrix(group_wine)
View(wine_plot)
final_winedata <- cbind(wine_plot,mydata)# binding column wise with orginal data
View(final_winedata)
View(aggregate(final_winedata[,-c(15:17)],by=list(wine_plot),FUN=mean)) # Inferences can be
# drawn from the aggregate of the wine data on wineplot
write.csv(final_winedata,file="wine,csv",row.names = F,col.names = F)
getwd()
