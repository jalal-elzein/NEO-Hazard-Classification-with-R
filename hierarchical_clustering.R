# BOOK

data <- read.csv("balanced_dataset.csv")

feature_names <- c("absolute_magnitude", "miss_distance", "relative_velocity", "est_diameter_min", "est_diameter_max")
hclust_features <- data[feature_names]

hclust_features_scaled <- scale(hclust_features)

complete_heir_model <- hclust(dist(hclust_features_scaled), method = "complete")
single_heir_model <- hclust(dist(hclust_features_scaled), method = "single")
average_heir_model <- hclust(dist(hclust_features_scaled), method = "average")
centroid_heir_model <- hclust(dist(hclust_features_scaled), method = "centroid")
median_heir_model <- hclust(dist(hclust_features_scaled), method = "median")
mcquitty_heir_model <- hclust(dist(hclust_features_scaled), method = "mcquitty")
ward.D_heir_model <- hclust(dist(hclust_features_scaled), method = "ward.D")
ward.D2_heir_model <- hclust(dist(hclust_features_scaled), method = "ward.D2")

# par(mfrow = c(3, 3))
plot(complete_heir_model, main = "Complete Linkage",
     xlab = "", sub = "", cex = .9)
plot(single_heir_model, main = "Single Linkage",
     xlab = "", sub = "", cex = .9)
plot(average_heir_model, main = "Average Linkage",
     xlab = "", sub = "", cex = .9)
plot(centroid_heir_model, main = "Centroid Linkage",
     xlab = "", sub = "", cex = .9)
plot(median_heir_model, main = "Median Linkage",
     xlab = "", sub = "", cex = .9)
plot(mcquitty_heir_model, main = "McQuitty Linkage",
     xlab = "", sub = "", cex = .9)
plot(ward.D_heir_model, main = "Ward D Linkage",
     xlab = "", sub = "", cex = .9)
plot(ward.D2_heir_model, main = "Ward D2 Linkage",
     xlab = "", sub = "", cex = .9)


# rect.hclust(complete_heir_model, h = 4e7, border = "red")
# rect.hclust(complete_heir_model, h = 2.5e7, border = "blue")