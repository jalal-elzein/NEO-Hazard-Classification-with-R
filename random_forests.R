# install.packages("randomForests")
library(caret)
library(randomForest)
library(cvms)

data <- read.csv("balanced_dataset.csv")

feature_names <- c("absolute_magnitude", "miss_distance", "relative_velocity", "est_diameter_min", "est_diameter_max")
features <- data[feature_names]
target <- factor(data$hazardous)

features_scaled <- scale(features)

set.seed(123)
splitIndex <- createDataPartition(data$hazardous, p = .8, list = FALSE)
X_train <- features_scaled[splitIndex,]
X_test <- features_scaled[-splitIndex,]
y_train <- target[splitIndex]
y_test <- target[-splitIndex]

rf_train_control <- trainControl(method = "cv", number = 5)
rf_hyperparameters <- expand.grid(mtry = c(2, 3, 4), ntree = c(100, 500, 1000, 2000))

rf_model <- randomForest(
  x = X_train,
  y = y_train,
  ntree = 500,
  importance = TRUE,
  type = "classification",
  trControl = train_control,
  tuneGrid = hyperparameters
)

rf_predictions <- predict(rf_model, newdata = X_test, type = "class")

rf_confusion_matrix <- cvms::confusion_matrix(targets = y_test, predictions = rf_predictions)
plot_confusion_matrix(rf_confusion_matrix$`Confusion Matrix`[[1]])

rf_accuracy <- mean(rf_predictions == y_test)
print(rf_accuracy)
print(rf_confusion_matrix$`Balanced Accuracy`)
print(rf_confusion_matrix$F1)