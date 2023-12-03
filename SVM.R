# Loading necessary libraries
library(lattice)
library(e1071)
library(caTools)
library(caret)
library(pROC)
library(ggplot2)
library(reshape2)

# Read and prepare the data
final_dataset <- read.csv("balanced_dataset.csv")
final_dataset$hazardous <- factor(final_dataset$hazardous, levels = c("False", "True"))

# Splitting the dataset
set.seed(123) # for reproducibility
splitIndex <- createDataPartition(final_dataset$hazardous, p = .8, list = FALSE)
train_data <- final_dataset[splitIndex,]
test_data <- final_dataset[-splitIndex,]

# Initialize results dataframe
results <- data.frame()
kernels <- c("linear", "polynomial", "radial", "sigmoid")
roc_data <- data.frame()

# SVM analysis and ROC data collection
for (kernel in kernels) {
  # Train the model with probability estimation
  model <- svm(hazardous ~ est_diameter_min + absolute_magnitude + relative_velocity + miss_distance, 
               data = train_data, 
               type = 'C-classification', 
               kernel = kernel, 
               probability = TRUE)
  
  # Predictions
  predictions <- predict(model, test_data, probability = TRUE)
  
  # Evaluation Metrics
  cm <- table(test_data$hazardous, predictions)
  accuracy <- sum(diag(cm)) / sum(cm)
  precision <- diag(cm) / colSums(cm)
  recall <- diag(cm) / rowSums(cm)
  f1_scores <- 2 * (precision * recall) / (precision + recall)
  f1_score <- mean(f1_scores, na.rm = TRUE)  # Averaging the F1 scores
  
  # ROC and AUC
  probabilities <- attr(predictions, "probabilities")
  if("True" %in% colnames(probabilities)) {
    roc_obj <- roc(test_data$hazardous, probabilities[, "True"])
    auc_value <- auc(roc_obj)
    
    # Adding ROC data for plotting
    roc_data <- rbind(roc_data, data.frame(t = roc_obj$thresholds, 
                                           tp = roc_obj$sensitivities, 
                                           fp = 1 - roc_obj$specificities, 
                                           kernel = kernel))
  } else {
    auc_value <- NA
    print(paste("AUC not computed for kernel:", kernel, "- 'True' class probabilities missing"))
  }
  
  # Collect results
  results <- rbind(results, data.frame(kernel, accuracy, f1_score, auc_value))
}

# Output the results
print(results)

# Plot ROC Curves for all kernels in one plot
ggplot(roc_data, aes(x = fp, y = tp, color = kernel)) + 
  geom_line() + 
  theme_minimal() + 
  labs(title = "Comparison of ROC Curves for Different Kernels", 
       x = "False Positive Rate", 
       y = "True Positive Rate")

# Performance Metrics Comparison
melted_results <- melt(results, id.vars = "kernel")
ggplot(melted_results, aes(x = kernel, y = value, fill = variable)) +
  geom_bar(stat = "identity", position = position_dodge()) +
  theme_minimal() +
  labs(title = "Comparison of Performance Metrics Across Kernels",
       x = "Kernel", y = "Value")

