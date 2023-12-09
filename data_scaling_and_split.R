data <- read.csv("balanced_dataset.csv")

feature_names <- c("absolute_magnitude", "miss_distance", "relative_velocity", "est_diameter_min", "est_diameter_max")
features <- data[feature_names]
target <- data$hazardous

features_scaled <- scale(features)

set.seed(123) # for reproducibility
splitIndex <- createDataPartition(data$hazardous, p = .8, list = FALSE)
# train_data <- data[splitIndex,]
# test_data <- data[-splitIndex,]
X_train <- features_scaled[splitIndex,]
X_test <- features_scaled[-splitIndex,]
y_train <- target[splitIndex]
y_test <- target[-splitIndex]