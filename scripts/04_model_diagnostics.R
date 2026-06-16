############################################################
# 04_model_diagnostics.R
#
# Model diagnostics for multivariable Gaussian GLMs
#
# Outputs:
#   Table S1
#   Table S2
#   Table S3
#   Residual diagnostics (Reviewer response)
############################################################

############################################################
# Required packages
############################################################

library(dplyr)
library(car)

############################################################
# Load prepared dataset
############################################################

source("scripts/01_data_preparation.R")

analysis_data <- prepared_data

############################################################
# Variables used in multivariable models
############################################################

model_vars <- c(
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
# Table S1
# Normality assessment of categorical variables
# (log-transformed bacterial abundance after +1 transformation)
############################################################

############################################################
# Brushing frequency
############################################################

shapiro_brushing <- analysis_data %>%
  filter(!is.na(brushing_frequency),
         !is.na(p_gingivalis)) %>%
  mutate(
    # add +1 to handle zero values
    p_gingivalis_adj = p_gingivalis + 1,
    
    # log transformation
    p_gingivalis_log = log(p_gingivalis_adj)
  ) %>%
  group_by(brushing_frequency) %>%
  summarise(
    n = n(),
    shapiro_p =
      ifelse(
        n >= 3,
        shapiro.test(p_gingivalis_log)$p.value,
        NA_real_
      )
  )

############################################################
# Toothbrush replacement interval
############################################################

shapiro_replacement <- analysis_data %>%
  filter(!is.na(toothbrush_replacement),
         !is.na(p_gingivalis)) %>%
  group_by(toothbrush_replacement) %>%
  summarise(
    n = n(),
    shapiro_p =
      ifelse(
        n >= 3,
        shapiro.test(p_gingivalis)$p.value,
        NA_real_
      )
  )

############################################################
# Smoking history
############################################################

shapiro_smoking <- analysis_data %>%
  filter(!is.na(smoking_history),
         !is.na(p_gingivalis)) %>%
  group_by(smoking_history) %>%
  summarise(
    n = n(),
    shapiro_p =
      ifelse(
        n >= 3,
        shapiro.test(p_gingivalis)$p.value,
        NA_real_
      )
  )

############################################################
# Alcohol history
############################################################

shapiro_alcohol <- analysis_data %>%
  filter(!is.na(alcohol_history),
         !is.na(p_gingivalis)) %>%
  group_by(alcohol_history) %>%
  summarise(
    n = n(),
    shapiro_p =
      ifelse(
        n >= 3,
        shapiro.test(p_gingivalis)$p.value,
        NA_real_
      )
  )

############################################################
# Drug use history
############################################################

shapiro_drug <- analysis_data %>%
  filter(!is.na(drug_use_history),
         !is.na(p_gingivalis)) %>%
  group_by(drug_use_history) %>%
  summarise(
    n = n(),
    shapiro_p =
      ifelse(
        n >= 3,
        shapiro.test(p_gingivalis)$p.value,
        NA_real_
      )
  )

############################################################
# Dentist visit history
############################################################

shapiro_dentist <- analysis_data %>%
  filter(!is.na(dentist_visit_history),
         !is.na(p_gingivalis)) %>%
  group_by(dentist_visit_history) %>%
  summarise(
    n = n(),
    shapiro_p =
      ifelse(
        n >= 3,
        shapiro.test(p_gingivalis)$p.value,
        NA_real_
      )
  )

############################################################
# Passive smoking
############################################################

shapiro_passive <- analysis_data %>%
  filter(!is.na(passive_smoking),
         !is.na(p_gingivalis)) %>%
  group_by(passive_smoking) %>%
  summarise(
    n = n(),
    shapiro_p =
      ifelse(
        n >= 3,
        shapiro.test(p_gingivalis)$p.value,
        NA_real_
      )
  )

############################################################
# Combine Table S1
############################################################

table_s1 <- bind_rows(
  mutate(shapiro_brushing,
         variable = "Brushing frequency"),
  mutate(shapiro_replacement,
         variable = "Toothbrush replacement"),
  mutate(shapiro_smoking,
         variable = "Smoking history"),
  mutate(shapiro_alcohol,
         variable = "Alcohol history"),
  mutate(shapiro_drug,
         variable = "Drug use history"),
  mutate(shapiro_dentist,
         variable = "Dentist visit history"),
  mutate(shapiro_passive,
         variable = "Passive smoking")
)

############################################################
# Table S3
# Complete-case dataset summary
############################################################

analysis_vars <- c(
  "maternal_age",
  "gravidity",
  "passive_smoking",
  "alcohol_history",
  "drug_use_history",
  "dentist_visit_history",
  "brushing_frequency",
  "toothbrush_replacement"
)

table_s3 <- data.frame(
  variable = analysis_vars,
  missing_n = sapply(
    analysis_data[analysis_vars],
    function(x) sum(is.na(x))
  )
)

############################################################
# Table S2
# Variance Inflation Factors (VIF)
############################################################

create_vif_model <- function(outcome){

  vars <- c(
    outcome,
    "maternal_age",
    "gravidity",
    "passive_smoking",
    "alcohol_history",
    "drug_use_history",
    "dentist_visit_history",
    "brushing_frequency",
    "toothbrush_replacement"
  )

  dat_cc <- analysis_data[, vars]
  dat_cc <- na.omit(dat_cc)

  glm(
    as.formula(
      paste(
        outcome,
        "~ maternal_age + gravidity +
          passive_smoking +
          alcohol_history +
          drug_use_history +
          dentist_visit_history +
          brushing_frequency +
          toothbrush_replacement"
      )
    ),
    data = dat_cc,
    family = gaussian()
  )
}

model_pg <- create_vif_model("log_p_gingivalis")

table_s2 <- data.frame(
  Variable = names(vif(model_pg)),
  VIF = as.numeric(vif(model_pg))
)

############################################################
# Reviewer response
# Residual diagnostics
############################################################

run_residual_diagnostics <- function(outcome){

  vars <- c(
    outcome,
    "maternal_age",
    "gravidity",
    "passive_smoking",
    "alcohol_history",
    "drug_use_history",
    "dentist_visit_history",
    "brushing_frequency",
    "toothbrush_replacement"
  )

  dat_cc <- analysis_data[, vars]
  dat_cc <- na.omit(dat_cc)

  model <- glm(
    as.formula(
      paste(
        outcome,
        "~ maternal_age + gravidity +
          passive_smoking +
          alcohol_history +
          drug_use_history +
          dentist_visit_history +
          brushing_frequency +
          toothbrush_replacement"
      )
    ),
    data = dat_cc,
    family = gaussian()
  )

  residuals_model <- residuals(model)

  cat("\n=================================\n")
  cat("Outcome:", outcome, "\n")
  cat("=================================\n")

  print(
    shapiro.test(residuals_model)
  )

  par(mfrow = c(1, 2))

  plot(
    fitted(model),
    residuals_model,
    xlab = "Fitted values",
    ylab = "Residuals",
    main = paste(
      "Residuals vs Fitted:",
      outcome
    )
  )

  abline(h = 0, lty = 2)

  qqnorm(
    residuals_model,
    main = paste(
      "Normal Q-Q:",
      outcome
    )
  )

  qqline(residuals_model)
}

############################################################
# Run residual diagnostics
############################################################

run_residual_diagnostics(
  "log_p_gingivalis"
)

run_residual_diagnostics(
  "log_t_forsythia"
)

run_residual_diagnostics(
  "log_t_denticola"
)

run_residual_diagnostics(
  "log_p_intermedia"
)

############################################################
# End of script
##############################################
