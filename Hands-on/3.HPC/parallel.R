##### Chapter 11: Improving Model Performance -------------------
#Source: https://github.com/dataspelunking/MLwR
# load the credit dataset
#install.packages("caret")
#install.packages("doParallel")
credit <- read.csv("credit.csv")
library(caret)
library(doParallel)

## Random Forests ----
# random forest with default settings
#install.packages("randomForest")
#install.packages("e1071")
library(randomForest)
set.seed(300)
system.time(
  rf <- randomForest(default ~ ., data = credit)
)
rf

#using Caret
ctrl <- trainControl(method = "repeatedcv",
                     number = 10, repeats = 10)

# auto-tune a random forest
grid_rf <- expand.grid(.mtry = c(2, 4, 8, 16))

set.seed(300)

cluster <- makeCluster(*FIXME*) # convention to leave 1 core for OS
registerDoParallel(cluster)
system.time( 
  m_rf <- train(default ~ ., data = credit, method = "rf",
                metric = "Kappa", trControl = ctrl,
                tuneGrid = grid_rf)
)
stopCluster(cluster)
m_rf

# auto-tune a boosted C5.0 decision tree
grid_c50 <- expand.grid(.model = "tree",
                        .trials = c(10, 20, 30, 40),
                        .winnow = "FALSE")

set.seed(300)
cluster <- makeCluster(*FIXME*) # convention to leave 1 core for OS
registerDoParallel(cluster)
system.time(
  m_c50 <- train(default ~ ., data = credit, method = "C5.0",
                 metric = "Kappa", trControl = ctrl,
                 tuneGrid = grid_c50)
)
stopCluster(cluster)
m_c50

#For big random forest there is a package called "bigrf"