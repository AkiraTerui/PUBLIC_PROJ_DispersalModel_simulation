# Read data ----
  rm(list=ls(all.names=T))
  library(tidyverse)
  library(egg)
  
  ## parameter setup
  dlaplace <- function(x, delta) 0.5*(1/delta)*exp(-(1/delta)*abs(x))
  X <- -500:500
  dpara <- seq(50, 300, by = 50)
  xtitle <- "Distance from the reference point (m)"
  ytitle <- "Density"
  
  ## create dataset
  yL <- data.frame(sapply(dpara, function(x) dlaplace(X, delta = x)), X = X)
  yG <- data.frame(sapply(dpara, function(x) dnorm(X, sd = x)), X = X)
  colnames(yL)[1:6] <- colnames(yG)[1:6] <- sapply(1:6, function(x) x*50)
  Y <- merge(yL, yG, all = T)
  
  ## tidy data and merge data
  yL %>%
    pivot_longer(cols = -X, names_to = "Parameter", values_to = "Density") %>%
    mutate(Kernel = "Laplace") -> YL
  
  yG %>%
    pivot_longer(cols = -X, names_to = "Parameter", values_to = "Density") %>%
    mutate(Kernel = "Gaussian") %>%
    full_join(YL) %>%
    mutate(Parameter = factor(Parameter, levels = unique(Parameter) ) ) -> Y
  
# Plot ----
  ggplot(Y) +
    geom_line(aes(y = Density, x = X, color = Parameter)) +
    facet_wrap(.~Kernel) +
    scale_color_discrete() +
    theme(plot.margin= unit(c(1, 1, 2, 2), "lines"),
          axis.title.x = element_text(vjust = -5),
          axis.title.y = element_text(vjust = 5),
          strip.background = element_blank(),
          panel.background = element_blank(),
          axis.text = element_text(vjust = 1),
          axis.ticks = element_line(color = "grey50"),
          axis.line = element_line(color = "grey50")) +
    labs(x = xtitle, y = ytitle)
  
  ggsave("figure1.tiff", width = 8, height = 4)
  