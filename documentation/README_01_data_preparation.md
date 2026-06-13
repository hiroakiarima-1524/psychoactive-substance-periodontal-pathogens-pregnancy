Purpose
This script performs all data preparation procedures required for the statistical analyses and visualizations presented in the manuscript.
The script generates derived categorical variables, calculates combined bacterial abundance measures, and performs log-transformation of bacterial counts.
The resulting dataset (prepared_data) is used as the input for all subsequent analyses.

Input Data
The script assumes an input dataset named:
study_data
containing demographic variables, oral health variables, substance use variables, and bacterial abundance measurements.

Derived Variables
Smoking History
Participants are classified into three categories:
Category	Definition
Never	No lifetime smoking history
Former	Smoked previously but not during pregnancy
Current	Smoked during pregnancy

Generated variable:
smoking_history

Alcohol History
Participants are classified into three categories:
Category	Definition
Never	No lifetime alcohol use
Former	Alcohol use before pregnancy only
Current	Alcohol use during pregnancy

Generated variable:
alcohol_history

Drug Use History
Participants are classified into three categories:
Category	Definition
Never	No lifetime drug use
Former	Drug use before pregnancy only
Current	Drug use during pregnancy

Generated variable:
drug_use_history

Toothbrush Replacement Interval
Toothbrush replacement frequency is converted into a categorical factor:
Category
3 months
6 months
1 year
Over 1 year
No toothbrush

The 3-month category is used as the reference group in regression analyses.
Generated variable:
toothbrush_replacement

Red-Complex Abundance
A combined red-complex abundance variable is calculated as:
Porphyromonas gingivalis+Tannerella forsythia+Treponema denticola

Generated variable:
red_complex_abundance

Log Transformation
To accommodate zero counts and reduce skewness, bacterial abundance values are transformed using:
log10(x+1)

Generated variables:
log_p_gingivalis
log_t_forsythia
log_t_denticola
log_p_intermedia
log_red_complex

Output
The script returns a prepared dataset:
prepared_data
which serves as the input dataset for:
Figure 3
Figure 4
Figure S1–S4
Table 1
Table 2
Table S1–S5

