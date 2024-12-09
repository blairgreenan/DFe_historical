# Load the readxl package
library(readxl)
library(tidyverse)

# Read the Excel file using the first row as column names
DFe_data <- read_excel("DFe_summary_noref2.xlsx", col_names = TRUE)

# Display the first few rows
head(DFe_data)

# Check the structure of the data
str(DFe_data)

# Convert the first column to Date format (assuming the column name is "date")
DFe_data$Date <- as.Date(DFe_data$Date, format = "%m/%d/%y")

# Ensure the second column is a factor (assuming the column name is "season")
DFe_data$Season <- factor(DFe_data$Season, levels = c("Spring", "Summer", "Fall"))

# Arrange the data by Date, Season, and Depth
DFe_data <- DFe_data %>%
  arrange(Date, Season, Depth)

# Check the structure again to confirm the changes
str(DFe_data)

# plot the data by season
ggplot(DFe_data, aes(x = DFe, y = Depth, group = Date)) +
  geom_point(size = 1) +
  geom_line() +  # Add lines to connect points for each date
  facet_wrap(~ Season) +
  scale_y_continuous(trans = "reverse", limits = c(700, 0)) +
  scale_x_continuous(limits = c(-0.005, 1.26), breaks = c(0, 0.3, 0.6, 0.9, 1.2), labels = c("0.0", "0.3", "0.6", "0.9", "1.2")) +
  xlab("DFe (nM)") +
  ylab((""))
# ylab(("Depth (m)"))


# save the plot to a png file
ggsave("dFe_historical_with_lines.png", width = 10, height = 4.25, units = c("cm"), dpi = 1200, bg = "white", scale = 1.5)
