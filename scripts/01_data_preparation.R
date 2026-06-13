############################################################
# 01_data_preparation.R
#
# Data preparation for all analyses
#
# Outputs:
#   prepared_data
#
# Used in:
#   - Figure 3
#   - Figure 4
#   - Figure S1-S4
#   - Table 1
#   - Table 2
#   - Table S1-S5
############################################################

library(dplyr)

############################################################
# Input dataset
############################################################

# Replace with the study dataset

prepared_data <- study_data

############################################################
# Smoking history
############################################################

prepared_data$smoking_history <- with(
  prepared_data,
  ifelse(
    lifetime_smoking == 0,
    "Never",
    ifelse(
      lifetime_smoking == 1 &
        smoking_during_pregnancy == 0,
      "Former",
      ifelse(
        lifetime_smoking == 1 &
          smoking_during_pregnancy == 1,
        "Current",
        NA
      )
    )
  )
)

prepared_data$smoking_history <- factor(
  prepared_data$smoking_history,
  levels = c(
    "Never",
    "Former",
    "Current"
  )
)

############################################################
# Alcohol history
############################################################

prepared_data$alcohol_history <- with(
  prepared_data,
  ifelse(
    lifetime_alcohol_use == 0,
    "Never",
    ifelse(
      lifetime_alcohol_use == 1 &
        alcohol_use_during_pregnancy == 0,
      "Former",
      ifelse(
        lifetime_alcohol_use == 1 &
          alcohol_use_during_pregnancy == 1,
        "Current",
        NA
      )
    )
  )
)

prepared_data$alcohol_history <- factor(
  prepared_data$alcohol_history,
  levels = c(
    "Never",
    "Former",
    "Current"
  )
)

############################################################
# Drug use history
############################################################

prepared_data$drug_use_history <- with(
  prepared_data,
  ifelse(
    lifetime_drug_use == 0,
    "Never",
    ifelse(
      lifetime_drug_use == 1 &
        drug_use_during_pregnancy == 0,
      "Former",
      ifelse(
        lifetime_drug_use == 1 &
          drug_use_during_pregnancy == 1,
        "Current",
        NA
      )
    )
  )
)

prepared_data$drug_use_history <- factor(
  prepared_data$drug_use_history,
  levels = c(
    "Never",
    "Former",
    "Current"
  )
)

############################################################
# Toothbrush replacement interval
############################################################

prepared_data$toothbrush_replacement <- factor(
  prepared_data$toothbrush_replacement_interval,
  levels = c(
    1,
    2,
    3,
    4,
    5
  ),
  labels = c(
    "3_months",
    "6_months",
    "1_year",
    "Over_1_year",
    "No_toothbrush"
  )
)

prepared_data$toothbrush_replacement <- relevel(
  prepared_data$toothbrush_replacement,
  ref = "3_months"
)

############################################################
# Red-complex abundance
############################################################

prepared_data$red_complex_abundance <-
  prepared_data$p_gingivalis +
  prepared_data$t_forsythia +
  prepared_data$t_denticola

############################################################
# Log-transformed bacterial abundance
############################################################

prepared_data$log_p_gingivalis <-
  log10(prepared_data$p_gingivalis + 1)

prepared_data$log_t_forsythia <-
  log10(prepared_data$t_forsythia + 1)

prepared_data$log_t_denticola <-
  log10(prepared_data$t_denticola + 1)

prepared_data$log_p_intermedia <-
  log10(prepared_data$p_intermedia + 1)

prepared_data$log_red_complex <-
  log10(prepared_data$red_complex_abundance + 1)

############################################################
# End of script
############################################################

