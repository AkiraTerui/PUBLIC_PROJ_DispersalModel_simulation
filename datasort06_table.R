
# Read library
  library(tidyverse)
  library(knitr)

# Read data
  rm(list = ls(all.names = T))
  source("datasort01_laplace.R")
  datl <- dat %>% mutate(Kernel = "Laplace")
  
  source("datasort02_gaussian.R")
  datg <- dat %>% mutate(Kernel = "Gaussian")
  
  dat <- bind_rows(datl, datg)
  
# summary for table 2
  summary_table = dat %>%
    group_by(Kernel, N, LEN, PHI, THETA, model_code) %>%
    summarise(Bias = mean(bias)) %>%
    group_by(Kernel, model_code) %>%
    summarise(mean(Bias), min(Bias), max(Bias) )
  
# summary for SI tables
  dat_table = dat %>%
    group_by(Kernel, N, LEN, PHI, THETA, model_code) %>%
    summarize(Bias = round(mean(bias),1) ) %>%
    pivot_wider(names_from = model_code, values_from = Bias)
  
  theta <- sort(unique(dat_table$THETA))
  DL <- list(NULL)
  for(i in 1:length(theta)){
    DL[[i]] = dat_table %>%
      filter(THETA == theta[i]) %>%
      arrange(Kernel) %>%
      kable(col.names = c("Kernel", "$N$", "$L$", "$\\phi$", "$\\theta_{true}$",
                          "$\\%~bias_{simple}$", "$\\%~bias_{trunc}$", "$\\%~bias_{disp-obs}$"),
            format = "markdown")
    names(DL)[i] <- paste0("Table S", i)
  }
