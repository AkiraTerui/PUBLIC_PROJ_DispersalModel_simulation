
# Read data -----
  d1 <- read.csv("result/sim_model_simple_Laplace2020-05-12.csv")
  d2 <- read.csv("result/sim_model_truncated_Laplace2020-05-13.csv")
  d3 <- read.csv("result/sim_model_disp_obs_Laplace2020-05-13.csv")
  d1$model <- "simple"; d1$model_code <- "m1"
  d2$model <- "truncation"; d2$model_code <- "m2"
  d3$model <- "disp_obs"; d3$model_code <- "m3"
  
# Load data ----
  dat <- merge(d1, d2, all = T)
  dat <- merge(dat, d3, all = T)
  dat$bias <- 100*(dat$delta_med - dat$DELTA)/dat$DELTA
  dat$CI <- dat$delta_upper - dat$delta_lower
  dat$THETA <- dat$DELTA