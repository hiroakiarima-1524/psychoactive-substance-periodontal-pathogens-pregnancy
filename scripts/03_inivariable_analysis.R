############################################################
# 03_univariable_analysis.R
############################################################

library(dplyr)
library(ggplot2)
library(ggbeeswarm)
library(minerva)

source("scripts/01_data_preparation.R")

analysis_data <- prepared_data

plot_continuous_association <- function(
    data,
    predictor,
    outcome,
    xlab,
    ylab
){

    mic_value <- mine(
        data[[predictor]],
        data[[outcome]],
        use = "pairwise.complete.obs"
    )$MIC

    ggplot(
        data,
        aes_string(
            x = predictor,
            y = outcome
        )
    ) +
        geom_smooth(
            method = lm,
            formula = y ~ x + I(x^2) + I(x^3),
            se = TRUE,
            colour = "#5DADE2",
            fill = "#AED6F1",
            alpha = 0.4
        ) +
        geom_point(
            colour = "#2E86C1",
            size = 2,
            alpha = 0.6
        ) +
        annotate(
            "text",
            x = Inf,
            y = Inf,
            label = paste0(
                "MIC = ",
                round(mic_value,3)
            ),
            hjust = 1.1,
            vjust = 1.5
        ) +
        labs(
            x = xlab,
            y = ylab
        ) +
        theme_classic()
}

plot_binary_group <- function(
    data,
    group_var,
    outcome,
    xlab,
    ylab
){

    dat <- data %>%
        filter(
            !is.na(.data[[group_var]]),
            !is.na(.data[[outcome]])
        )

    p <- wilcox.test(
        dat[[outcome]] ~ dat[[group_var]]
    )$p.value

    ggplot(
        dat,
        aes_string(
            x = group_var,
            y = outcome,
            color = group_var
        )
    ) +
        geom_jitter(
            width = 0.15,
            alpha = 0.7,
            size = 2
        ) +
        annotate(
            "text",
            x = Inf,
            y = Inf,
            label = paste0(
                "p = ",
                signif(p,3)
            ),
            hjust = 1.1,
            vjust = 1.5
        ) +
        labs(
            x = xlab,
            y = ylab
        ) +
        theme_classic()
}


plot_multigroup <- function(
    data,
    group_var,
    outcome,
    xlab,
    ylab
){

    dat <- data %>%
        filter(
            !is.na(.data[[group_var]]),
            !is.na(.data[[outcome]])
        )

    p <- kruskal.test(
        dat[[outcome]] ~ dat[[group_var]]
    )$p.value

    ggplot(
        dat,
        aes_string(
            x = group_var,
            y = outcome,
            color = group_var
        )
    ) +
        geom_jitter(
            width = 0.18,
            alpha = 0.7,
            size = 2
        ) +
        annotate(
            "text",
            x = Inf,
            y = Inf,
            label = paste0(
                "p = ",
                signif(p,3)
            ),
            hjust = 1.1,
            vjust = 1.5
        ) +
        labs(
            x = xlab,
            y = ylab
        ) +
        theme_classic()
}


# Figure S1
outcome <- "p_gingivalis"

# Age
plot_continuous_association(...)

# Gravidity
plot_continuous_association(...)

# Brushing frequency
plot_multigroup(...)

# Passive smoking
plot_binary_group(...)

# etc...

outcome <- "t_forsythia"
outcome <- "t_denticola"
outcome <- "p_intermedia"
