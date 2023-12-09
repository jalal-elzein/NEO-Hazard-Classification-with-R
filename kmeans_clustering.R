data <- read.csv("balanced_dataset.csv")

feature_names <- c("absolute_magnitude", "miss_distance", "relative_velocity", "est_diameter_min", "est_diameter_max")
kmeans_features <- data[feature_names]

kmeans_features_scaled <- scale(kmeans_features)

kmeans_model <- kmeans(kmeans_features_scaled, 4, nstart = 20)

print(kmeans_model$cluster)

# plot(x, col = (kmeans_model$cluster + 1),
#     main = "K-Means Clustering Results with K = 4",
#     xlab = "", ylab = "", pch = 20, cex = 2)
