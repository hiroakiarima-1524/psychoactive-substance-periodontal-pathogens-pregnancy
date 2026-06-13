############################################################
# 05_multivariable_analysis.R
#
# Multivariable Gaussian GLMs
#
# Outputs:
#   Table S4
#   Table S5
############################################################

############################################################
# Required packages
############################################################

library(dplyr)

############################################################
# Load prepared dataset
############################################################

source("scripts/01_data_preparation.R")

analysis_data <- prepared_data

############################################################
# Common explanatory variables
############################################################

predictors <- c(
  "maternal_age",
  "gravidity",
  "passive_smoking",
  "alcohol_history",
  "drug_use_history",
  "dentist_visit_history",
  "brushing_frequency",
  "toothbrush_replacement"
)

############################################################
# Function:
# Multivariable Gaussian GLM
############################################################

run_multivariable_model <- function(
  data,
  outcome,
  predictors
){

  vars <- c(outcome, predictors)

  dat_cc <- data[, vars]

  dat_cc <- na.omit(dat_cc)

  formula_text <- paste(
    outcome,
    "~",
    paste(
      predictors,
      collapse = " + "
    )
  )

  model <- glm(
    as.formula(formula_text),
    data = dat_cc,
    family = gaussian()
  )

  coef_table <- summary(model)$coefficients

  ci_table <- confint.default(model)

  results <- data.frame(
    outcome = outcome,
    variable = rownames(coef_table),
    beta = coef_table[,1],
    ci_lower = ci_table[,1],
    ci_upper = ci_table[,2],
    p_value = coef_table[,4]
  )

  return(results)

}

############################################################
# Table S4
# Individual bacterial species
############################################################

outcomes_s4 <- c(
  "log_p_gingivalis",
  "log_t_forsythia",
  "log_t_denticola",
  "log_p_intermedia"
)

table_s4 <- bind_rows(
  lapply(
    outcomes_s4,
    run_multivariable_model,
    data = analysis_data,
    predictors = predictors
  )
)

############################################################
# Formatting
############################################################

table_s4$beta <- round(
  table_s4$beta,
  3
)

table_s4$ci_lower <- round(
  table_s4$ci_lower,
  3
)

table_s4$ci_upper <- round(
  table_s4$ci_upper,
  3
)

table_s4$p_value <- round(
  table_s4$p_value,
  3
)

############################################################
# Create Red Complex
############################################################

analysis_data$red_complex_abundance <-
  analysis_data$p_gingivalis +
  analysis_data$t_forsythia +
  analysis_data$t_denticola

analysis_data$log_red_complex <-
  log10(
    analysis_data$red_complex_abundance + 1
  )

############################################################
# Red Complex model
############################################################

table_s5_beta <- run_multivariable_model(
  data = analysis_data,
  outcome = "log_red_complex",
  predictors = predictors
)

############################################################
# Convert beta to fold change
############################################################

table_s5 <- table_s5_beta

table_s5$fold_change <-
  10^(table_s5$beta)

table_s5$fold_lower <-
  10^(table_s5$ci_lower)

table_s5$fold_upper <-
  10^(table_s5$ci_upper)

table_s5$fold_change <- round(
  table_s5$fold_change,
  2
)

table_s5$fold_lower <- round(
  table_s5$fold_lower,
  2
)

table_s5$fold_upper <- round(
  table_s5$fold_upper,
  2
)

table_s5$p_value <- round(
  table_s5$p_value,
  3
)

############################################################
# Export results
############################################################

write.csv(
  table_s4,
  "results/TableS4_multivariable_coefficients.csv",
  row.names = FALSE
)

write.csv(
  table_s5,
  "results/TableS5_red_complex_fold_change.csv",
  row.names = FALSE
)

############################################################
# End of script
############################################################
###########
