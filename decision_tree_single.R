# install.packages("rpart")
# install.packages("rpart.plot")
library(ggplot2)
library(lattice)
library(caret)
library(rpart)
library(rpart.plot)
library(cvms)

data <- read.csv("balanced_dataset.csv")

feature_names <- c("absolute_magnitude", "miss_distance", "relative_velocity", "est_diameter_min", "est_diameter_max")
features <- data[feature_names]
target <- data$hazardous

features_scaled <- scale(features)

set.seed(123)
splitIndex <- createDataPartition(data$hazardous, p = .8, list = FALSE)
X_train <- features_scaled[splitIndex,]
X_test <- features_scaled[-splitIndex,]
y_train <- target[splitIndex]
y_test <- target[-splitIndex]

model <- rpart(y_train ~ est_diameter_min + est_diameter_max + relative_velocity + miss_distance + absolute_magnitude,
               data = as.data.frame(X_train),
               method = "class",
               control = rpart.control(cp = 0.001),
)

rpart.plot(model)

predictions <- predict(model, newdata = as.data.frame(X_test), type = "class")

accuracy <- mean(predictions == y_test)
confusion_matrix <- cvms::confusion_matrix(targets = y_test, predictions = predictions)
plot_confusion_matrix(confusion_matrix$`Confusion Matrix`[[1]])
print(confusion_matrix$`Balanced Accuracy`)
print(confusion_matrix$Sensitivity)
print(confusion_matrix$Specificity)
print(confusion_matrix$F1)
