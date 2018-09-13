
https://rstudio-pubs-static.s3.amazonaws.com/31867_8236987cf0a8444e962ccd2aec46d9c3.html
library(graph)
library(Rgraphviz)

findAssocs(myDTM, 'amp', 0.20)



d <- dist(t(myDTM), method="euclidian")   
fit <- hclust(d=d, method="ward")
plot(fit)
