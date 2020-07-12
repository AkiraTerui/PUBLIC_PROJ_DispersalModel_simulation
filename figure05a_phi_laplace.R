# Library
  library(tidyverse)
  library(egg)

# Read data ----
  rm(list=ls(all.names=T))
  source("datasort01_laplace.R")

  ## axis titles
  xtitle <- expression("True dispersal parameter"~delta[true]~"(m)")
  ytitle <- expression("Estimated recpature probability"~phi[est])

  ## panel label
  dat$phi.label <- sprintf('phi=="%.1f"', dat$PHI); dat$phi_f <- factor(dat$phi.label, levels = unique(dat$phi.label) )
  dat$N.label <- sprintf('N=="%i"', dat$N); dat$N_f <- factor(dat$N.label, levels = unique(dat$N.label) )
  dat$L.label <- sprintf('L=="%i"', dat$LEN); dat$L_f <- factor(dat$L.label, levels = unique(dat$L.label) )

  ## plot colors
  COL <- c(rgb(0,0,0), rgb(0,0.3,0.7),rgb(1,0,0))

# Plot ----
  dat %>%
    filter(model_code == "m3") %>%
    ggplot() +
      geom_boxplot(aes(y = phi_med, x = as.factor(THETA), color = "red", fill = "red"),
                   alpha = 0.4, lwd = 0.1, outlier.size = 0.5, outlier.stroke = 0) +
      geom_hline(aes(yintercept = PHI), lwd = 0.5, color = "grey60", alpha = 0.4) +
      scale_y_continuous(limits = c(0,1) ) +
      facet_wrap(.~N_f + L_f + phi_f, ncol = 3, dir = "v", scale = "free",
                 labeller = labeller(.cols = label_parsed, .multi_line = F)) +
      theme(plot.margin= unit(c(1, 1, 2, 2), "lines"),
            axis.title.x = element_text(vjust = -5),
            axis.title.y = element_text(vjust = 5),
            legend.position = "none",
            strip.background = element_blank(),
            panel.background = element_blank(),
            axis.text = element_text(vjust = 1),
            axis.ticks = element_line(color = "grey50"),
            axis.line = element_line(color = "grey50")) +
      labs(x = xtitle, y = ytitle) -> p
    
    tag_facet(p) +
      theme(strip.text = element_text())
    
    ggsave("figure6.tiff", width = 8, height = 8)
