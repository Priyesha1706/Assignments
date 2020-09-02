install.packages("jpeg")
install.packages("imager")
install.packages("pixmap")
library(jpeg)
library(imager)
library(pixmap)
cat <- readJPEG('C:\\Users\\nitin\\Desktop\\Desktop items\\Wedding Pics-Honey\\DCIM\\100DELHI\\_DSC0025.JPG')
ncol(cat)
nrow(cat)
r <- cat[,,1]
g <- cat[,,2]
h <- cat[,,3]

cat.r.pca <- prcomp(r,center = FALSE)
cat.g.pca <- prcomp(g,center = FALSE)
cat.h.pca <- prcomp(h,center = FALSE)

rgh.pca <- list(cat.r.pca,cat.g.pca,cat.h.pca)

rgh.image <- sapply(rgh.pca, function(j){compressed.img <- j$u[,1:1] %*% t(j$rotation[,1:150])}, simplify = "array")
a<- pixmap::pixmapRGB(rgh.image)
window()
plot(a)
