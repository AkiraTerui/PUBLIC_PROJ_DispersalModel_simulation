# Library
  library(tidyverse)
  library(egg)

# Read data ----
  rm(list=ls(all.names=T))
  source("datasort02_gaussian.R")

  ## axis titles
  xtitle <- expression("True dispersal parameter"~sigma[italic(true)]~"(m)")
  ytitle <- expression("Proportion of stayers or recaptures")

  ## panel label
  dat$phi.label <- sprintf('phi=="%.1f"', dat$PHI); dat$phi_f <- factor(dat$phi.label, levels = unique(dat$phi.label) )
  dat$N.label <- sprintf('italic(N)=="%i"', dat$N); dat$N_f <- factor(dat$N.label, levels = unique(dat$N.label) )
  dat$L.label <- sprintf('italic(L)=="%i"', dat$LEN); dat$L_f <- factor(dat$L.label, levels = unique(dat$L.label) )
  dat %>% pivot_longer(cols = c(Pstay, Pcap), names_to = "Ptype", values_to = "P") -> dat_long

  ## plot colors
  COL <- c(rgb(0,0,0), rgb(1,0,0))

# Plot ----
  ggplot(dat_long) +
    geom_boxplot(aes(y = P, x = as.factor(THETA), fill = Ptype, color = Ptype),
                 alpha = 0.4, lwd = 0.1, outlier.size = 0.5, outlier.stroke = 0) +
    scale_colour_manual(values = COL, name = "", labels = c("Recapture", "Stayer")) +
    scale_fill_manual(values = COL, name = "", labels = c("Recapture", "Stayer")) +
    scale_y_continuous(limits = c(0,1) ) +
    facet_wrap(.~N_f + L_f + phi_f, ncol = 4, scale = "free",
               labeller = labeller(.cols = label_parsed, .multi_line = F)) +
    theme(plot.margin= unit(c(1, 1, 2, 2), "lines"),
          axis.title.x = element_text(vjust = -5),
          axis.title.y = element_text(vjust = 5),
          legend.position = "top",
          legend.direction = "horizontal",
          strip.background = element_blank(),
          panel.background = element_blank(),
          axis.text = element_text(vjust = 1),
          axis.ticks = element_line(color = "grey50"),
          axis.line = element_line(color = "grey50")) +
    labs(x = xtitle, y = ytitle) -> p
  
  tag_facet(p, x = 5) +
    theme(strip.text = element_text())
  
  ggsave("figure3.tiff", width = 9, height = 7)
