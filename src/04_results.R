"Evaluate the performance of the model using the test dataset

Usage: src/04_results.R --input_path=<input_path> --output_path=<output_path> 

Options:
--input_path_train=<input_path_train>
--input_path_test=<input_path_test>
--input_path_model=<input_path_model>
--output_path=<output_path>
" -> doc

library(docopt)
library(readr)

opt <- docopt::docopt(doc)

train_data <- readr::read_csv(opt$input_path_train)
test_data <- readr::read_csv(opt$input_path_test)
penguin_fit <- readr::read_rds(opt$input_path_model)

# Predict on test data
predictions <- predict(penguin_fit, test_data, type = "class") %>%
  bind_cols(test_data)

# Confusion matrix
conf_mat <- conf_mat(predictions, truth = species, estimate = .pred_class)
conf_mat

readr::write_rds(conf_mat, opt$output_path)
