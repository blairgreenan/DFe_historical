# Load required libraries
library(readxl)
library(tidyverse)

# Read the Excel file using the first row as column names
DFe_data <- read_excel("DFe_summary.xlsx", col_names = TRUE)

# Convert the first column to Date format (assuming the column name is "Date")
DFe_data$Date <- as.Date(DFe_data$Date, format = "%m/%d/%y")

# Ensure the second column is a factor (assuming the column name is "Season")
DFe_data$Season <- factor(DFe_data$Season, levels = c("Spring", "Summer", "Fall"))

# Sort the data by Date, Season, and Depth to ensure correct ordering
DFe_data <- DFe_data %>%
  arrange(Date, Season, Depth)

# Plot the data by season, ensuring Depth determines the order of connection
ggplot(DFe_data, aes(x = DFe, y = Depth, group = Date, color = as.factor(Date))) +
  geom_point(size = 1, show.legend = FALSE) +  # Disable legend for points
  geom_path(show.legend = FALSE) +  # Disable legend for paths
  scale_color_viridis_d() +
  facet_wrap(~ Season) +
  scale_y_continuous(trans = "reverse", limits = c(700, 0)) +
  scale_x_continuous(
    limits = c(-0.005, 1.26),
    breaks = c(0, 0.3, 0.6, 0.9, 1.2),
    labels = c("0.0", "0.3", "0.6", "0.9", "1.2")
  ) +
  xlab("DFe (nM)") +
  ylab("")  # Adjusted y-label for an empty string



# save the plot to a png file
ggsave("dFe_historical_with_lines.png", width = 10, height = 4.25, units = c("cm"), dpi = 1200, bg = "white", scale = 1.5)
