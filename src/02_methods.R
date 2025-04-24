"Perform exploratory data analysis (EDA) and prepare the data for modeling

Usage: src/02_methods.R --input_path=<input_path> --output_path_summary=<output_path_summary> --output_path_boxplot=<output_path_boxplot> --output_path_data=<output_path_data>

Options:
--input_path=<input_path>
--output_path_summary=<output_path_summary>
--output_path_boxplot=<output_path_boxplot>
--output_path_data=<output_path_data>
" -> doc

library(docopt)
library(readr)

opt <- docopt::docopt(doc)

data <- readr::read_csv(opt$input_path)

# Summary statistics
glimpse(data)
summary <- dplyr::summarise(data, 
                            mean_bill_length = mean(bill_length_mm), 
                            mean_bill_depth = mean(bill_depth_mm), 
                            mean_flipper_length = mean(flipper_length_mm), 
                            mean_body_mass = mean(body_mass_g))

# Visualizations
boxplot <- ggplot(data, aes(x = species, y = bill_length_mm, fill = species)) +
  geom_boxplot() +
  theme_minimal()

# Prepare data for modeling
data <- data %>%
  select(species, bill_length_mm, bill_depth_mm, flipper_length_mm, body_mass_g) %>%
  mutate(species = as.factor(species))

readr::write_csv(summary, opt$output_path_summary)
ggplot2::ggsave(opt$output_path_boxplot, boxplot)
readr::write_csv(data, opt$output_path_data)