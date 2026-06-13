# Psychoactive Substance Use and Salivary Periodontal Pathogens Among Pregnant Women in Rural Rwanda
## Overview
This repository contains the R scripts used for data processing, descriptive analyses, univariable analyses, multivariable regression analyses, and model diagnostics conducted in the study examining Psychoactive substance use and salivary periodontal pathogens among pregnant women in rural Rwanda.

The repository was created to improve transparency and reproducibility of the statistical analyses reported in the manuscript.

## Repository Structure
scripts/
├── 01_data_preparation.R
├── 02_descriptive_analysis.R
├── 03_univariable_analysis.R
├── 04_model_diagnostics.R
└── 05_multivariable_analysis.R

documentation/
├── README_01_data_preparation.md
├── README_02_descriptive_analysis.md
├── README_03_univariable_analysis.md
├── README_04_model_diagnostics.md
└── README_05_multivariable_analysis.md

## Description of Scripts
01_data_preparation.R

Preparation of analytical datasets, variable recoding, creation of categorical variables, log-transformation of bacterial abundance data, and complete-case dataset generation.

02_descriptive_analysis.R

Generation of descriptive statistics and visualizations, including participant characteristics and bacterial abundance distributions.

03_univariable_analysis.R

Univariable analyses evaluating associations between participant characteristics and bacterial abundance measures using correlation analyses and non-parametric group comparisons.

04_model_diagnostics.R

Assessment of model assumptions, including multicollinearity diagnostics, residual diagnostics, Shapiro–Wilk tests, residual-versus-fitted plots, and normal Q-Q plots.

05_multivariable_analysis.R

Multivariable Gaussian generalized linear models examining associations between participant characteristics, psychoactive substance use variables, oral health behaviors, and bacterial abundance outcomes.

## Software

Analyses were conducted using:

R (version 4.3.2)
RStudio (version 2026.01.0+392)

Major packages included:

dplyr
tidyr
ggplot2
corrplot
minerva
PMCMRplus
ggbeeswarm
car

## Data Availability

Participant-level data cannot be publicly shared because of ethical and privacy restrictions.

To protect participant confidentiality, dataset names and variable names have been generalized in the publicly released scripts.

## Reproducibility
The scripts contained in this repository correspond to the analyses reported in the manuscript and are provided to facilitate reproducibility and transparency.

## Author
Hiroaki Arima, PhD
Department of International Health and Medical Anthropology
Institute of Tropical Medicine
Nagasaki University
Nagasaki, Japan
