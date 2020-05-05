install.packages('factoextra')
install.packages('NbClust')

library(factoextra)
library(NbClust)
library(MASS)

data('iris')

head(iris)

tail(iris)

str(iris)

nrow(iris)

ncol(iris)

summary(iris)

## data partition

set.seed(555)
ind <- sample(2,
              nrow(iris),
              replace = TRUE,
              prob = c(0.8,0.2))

training_data <- iris[ind == 1, ]
testing_data <- iris[ind == 2, ]

## Decision Tree Model

install.packages('party')
library('party')

tree <- ctree(Species~.,training_data)
tree

tree1 <- ctree(Sepal.Length~.,training_data)
tree1


## Visualization

plot(tree)
plot(tree,type = 'simple')


plot(tree1)


head(training_data)
tail(training_data)

## Predicition


predict(tree,training_data, type = 'prob')


## Misclassification error - training data


predection1 <- predict(tree, training_data)
table1 <- table(Predicted = predection1,Actual = training_data$Species)
table1
# error
1 - sum(diag(table1))/sum(table1)


## Misclassification error - testing data
prediction2 <- predict(tree,testing_data)
table2 <- table(Predicted = prediction2,Actual = testing_data$Species)
table2
## error
1 - sum(diag(table2))/sum(table2)


## k-means Clustering


Iris.features <- iris
Iris.features$Species <- NULL
Iris.features
iris
result <- kmeans(Iris.features, 3)
result

result$size
result$cluster

table(iris$Species,result$cluster)

plot(iris[c("Petal.Length","Petal.Width")],col = result$cluster)
plot(iris[c("Petal.Length","Petal.Width")],col = iris$Species)
plot(iris[c("Sepal.Length","Sepal.Width")],col = result$cluster)
plot(iris[c("Sepal.Length","Sepal.Width")],col = iris$Species)


## Desnity based clustering

str(iris)
new <- iris[,-5]
new

install.packages(fpc)
library(fpc)
install.packages(dbscan)
library(dbscan)


## Obtaining optimal eps value
kNNdistplot(new, k =3)
abline(h = 0.45,lty = 5)


## Desnity based clustering using fps and dbscan

set.seed(123)
f <- fpc::dbscan(new, eps = 0.45, MinPts = 4)
f

d <- dbscan::dbscan(new, eps = 0.45, 4)
d

## Cluster Visualization
dev.off()
?fviz_cluster
fviz_cluster(f,new,geom = "point")
plot(f,new)
install.packages(cluster)
library(cluster)

