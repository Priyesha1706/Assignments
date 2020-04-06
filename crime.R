View(crime_data)
# Normalizing continuous columns to bring them under same scale
normalize_data <- scale(crime_data[2:5])
d <- dist(normalize_data,method = "euclidean")# distance matrix
?hclust
#hcluster <- hclust(d,method = "average")# average linkage method
#plot(hcluster, hang = -1)
#h1cluster <- hclust(d, method = "centroid")# centroid linkage method
#plot(h1cluster)
h2cluster <- hclust(d,method = "complete")#complete linkage method
plot(h2cluster)
#h3cluster <- hclust(d,method = "single") #single linkage method
#plot(h3cluster)
?cutree
group <- cutree(h2cluster,k =4)
rect.hclust(h2cluster,plot(h2cluster, hang = -1),k=4,border = "red")
cluster = data.frame('crimedata' = crime_data[,2:5], 'cluster'= group )
View(cluster)
final_cluster <-cbind(crime_data,group)
aggregate(final_cluster[,2:6], by=list(final_cluster$group), FUN = mean)
#As per summary we can say group 2 have the higher rate of crime.