############################################################
# 02_descriptive_analysis.R
#
# Descriptive analyses
#
# Outputs:
#   Figure 3
#   Figure 4
############################################################

############################################################
# Required packages
############################################################

library(dplyr)
library(tidyr)
library(ggplot2)
library(corrplot)

############################################################
# Load prepared dataset
############################################################

source("scripts/01_data_preparation.R")

analysis_data <- prepared_data

############################################################
# Figure 3
# Participant Characteristics
############################################################

# Figure 3A
ggplot(
  analysis_data,
  aes(x = maternal_age)
) +
  geom_histogram(
    binwidth = 5,
    fill = "#9bdaf1",
    color = "#1f4fa3",
    linewidth = 0.4
  ) +
  labs(
    x = "Age (years)",
    y = "Number of participants"
  ) +
  theme_classic(base_size = 14)

# Figure 3B
ggplot(
  analysis_data,
  aes(x = gravidity)
) +
  geom_histogram(
    binwidth = 1,
    fill = "#9bdaf1",
    color = "#1f4fa3",
    linewidth = 0.4
  ) +
  labs(
    x = "Gravidity",
    y = "Number of participants"
  ) +
  theme_classic(base_size = 14)

# Figure 3C
ggplot(
  analysis_data,
  aes(x = brushing_frequency)
) +
  geom_histogram(
    binwidth = 1,
    fill = "#9bdaf1",
    color = "#1f4fa3",
    linewidth = 0.4
  ) +
  labs(
    x = "Toothbrushing frequency",
    y = "Number of participants"
  ) +
  theme_classic(base_size = 14)

# Figure 3D
ggplot(
  subset(
    analysis_data,
    !is.na(toothbrush_replacement)
  ),
  aes(x = toothbrush_replacement)
) +
  geom_bar(
    fill = "#9bdaf1",
    color = "#1f4fa3",
    linewidth = 0.5
  ) +
  labs(
    x = "Toothbrush replacement interval",
    y = "Number of participants"
  ) +
  theme_classic(base_size = 14)

# Figure 3E
ggplot(
  subset(
    analysis_data,
    !is.na(dentist_visit_history)
  ),
  aes(x = factor(dentist_visit_history))
) +
  geom_bar(
    fill = "#e5e5e5",
    color = "#4d4d4d",
    linewidth = 0.6
  ) +
  labs(
    x = "Dental visit history",
    y = "Number of participants"
  ) +
  theme_classic(base_size = 14)

# Figure 3F
ggplot(
  subset(
    analysis_data,
    !is.na(passive_smoking)
  ),
  aes(x = factor(passive_smoking))
) +
  geom_bar(
    fill = "#e5e5e5",
    color = "#4d4d4d",
    linewidth = 0.6
  ) +
  labs(
    x = "Passive smoking exposure",
    y = "Number of participants"
  ) +
  theme_classic(base_size = 14)

# Figure 3G
ggplot(
  subset(
    analysis_data,
    !is.na(smoking_history)
  ),
  aes(x = smoking_history)
) +
  geom_bar(
    fill = "#e5e5e5",
    color = "#4d4d4d",
    linewidth = 0.6
  ) +
  labs(
    x = "Smoking history",
    y = "Number of participants"
  ) +
  theme_classic(base_size = 14)

# Figure 3H
ggplot(
  subset(
    analysis_data,
    !is.na(alcohol_history)
  ),
  aes(x = alcohol_history)
) +
  geom_bar(
    fill = "#e5e5e5",
    color = "#4d4d4d",
    linewidth = 0.6
  ) +
  labs(
    x = "Alcohol use history",
    y = "Number of participants"
  ) +
  theme_classic(base_size = 14)

# Figure 3I
ggplot(
  subset(
    analysis_data,
    !is.na(drug_use_history)
  ),
  aes(x = drug_use_history)
) +
  geom_bar(
    fill = "#e5e5e5",
    color = "#4d4d4d",
    linewidth = 0.6
  ) +
  labs(
    x = "Drug use history",
    y = "Number of participants"
  ) +
  theme_classic(base_size = 14)

############################################################
# Figure 4A
# Distribution of bacterial abundance
############################################################

bacterial_load_long <- analysis_data %>%
  select(
    log_p_gingivalis,
    log_t_forsythia,
    log_t_denticola,
    log_p_intermedia
  ) %>%
  pivot_longer(
    cols = everything(),
    names_to = "bacterial_species",
    values_to = "log10_bacterial_load"
  ) %>%
  na.omit()

ggplot(
  bacterial_load_long,
  aes(
    x = bacterial_species,
    y = log10_bacterial_load
  )
) +
  geom_boxplot() +
  theme_bw() +
  labs(
    x = "Bacterial species",
    y = "Log10 bacterial load"
  )

############################################################
# Figure 4B
# Correlation heatmap
############################################################

bacterial_data <- analysis_data %>%
  select(
    p_gingivalis,
    t_forsythia,
    t_denticola,
    p_intermedia
  )

correlation_matrix <- cor(
  bacterial_data,
  method = "spearman",
  use = "complete.obs"
)

corrplot(
  correlation_matrix,
  method = "color",
  type = "upper",
  tl.col = "black",
  addCoef.col = "black"
)

############################################################
# End of script
#######################
