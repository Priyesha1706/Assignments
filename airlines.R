View(EastWestAirlines)
colnames(EastWestAirlines)
Eastwest_Airlines <- EastWestAirlines[,2:12] 
normalize_airline <- scale(Eastwest_Airlines)
View(normalize_airline)
library(lattice)
 d <- dist(normalize_airline, method = "euclidean")# distance matrix
 hcluster <- hclust(d, method = "complete")
 #clusters of passengers that have similar characteristics for the purpose of targeting different segments for different types of mileage offers
plot(hcluster, hang = -1)
 #h1cluster <- hclust(d,method ="average")
 #plot(h1cluster, hang = -1)
 #h2cluster <- hclust(d,method = "centroid")
 #plot(h2cluster, hang = -1)
 #h3cluster <- hclust(d,method = "single")
 #plot(h3cluster, hang = -1)
 group_airlines <- cutree(hcluster, k = 5)
rect.hclust(hcluster,k =5,plot(hcluster, hang = -1),border = "red") 
new_EastWestAirlines <- cbind(EastWestAirlines,group_airlines)
setNames(EastWestAirlines_New,'group_airlines')
aggregate(EastWestAirlines[,2:12], by=list(EastWestAirlines_New$ group_airlines), FUN = mean)
# K-MEANS CLustering
k = 5
airline_Kmean <- kmeans(normalize_airline,centers = k,iter.max = 1000)
str(airline_Kmean)
airline_Kmean$centers
new_EastWestAirlines <- cbind(new_EastWestAirlines,airline_Kmean$cluster)
colnames(new_EastWestAirlines)
aggregate(EastWestAirlines[,2:12],by=list(new_EastWestAirlines$`airline_Kmean$cluster`),FUN = mean)
install.packages("animation")
library(animation)
windows()
airline_kmean <- kmeans.ani(normalize_airline,5)
#scree plot
wss = (nrow(normalize_airline)-1)*sum(apply(normalize_airline, 2, var))      # Determine number of clusters by scree-plot 
for (i in 2:12) wss[i] = sum(kmeans(normalize_airline, centers=i)$withinss)
plot(1:12, wss, type="b", xlab="Number of Clusters", ylab="Within groups sum of squares")   # Look for an "elbow" in the scree plot #
title(sub = "K-Means Clustering Scree-Plot")

