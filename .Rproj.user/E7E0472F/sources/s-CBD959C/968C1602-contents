# Read data ----
  rm(list=ls(all.names=T))
  library(devEMF)
  dat <- read.csv("result/sim_model_2020-03-17.csv")
  dat$Y <- dat$delta_upper - dat$delta_lower # 95%CI range
  
  para <- sapply(2:4, function(i)unique(dat[,i]) )
  para.set <- expand.grid(para[[1]], para[[2]], para[[3]])
  panel.id <- c("(a)", "(b)", "(c)",
                "(d)", "(e)", "(f)",
                "(g)", "(h)", "(i)",
                "(j)", "(k)", "(l)")

# Plot ----
  #pdf("figure_deltaCI_v1.pdf", width = 11, height = 13.5)
  emf("figure_deltaCI_v1.emf", width = 11, height = 13.5)
  par(mfrow = c(4,3), oma = c(4,5,2,1), mar = c(4,4,1,1), cex.axis = 1.5, cex.lab = 1.5)
  
  ALPHA <- 0.4
  for(i in 1:nrow(para.set)){
    ## Sub-dataset with a given parameter set
    ROW <- dat$N==para.set[i,1]&dat$LEN==para.set[i,2]&dat$PHI==para.set[i,3]
    dat.sub <- dat[ROW,]
    
    ## Parameter set title
    para.title <- substitute(a~"N ="~b*", L ="~c*", "~phi*" = "*d*"",
                             list( a = panel.id[i],
                                   b = unique(dat.sub$N),
                                   c = unique(dat.sub$LEN),
                                   d = unique(dat.sub$PHI) ) )
    
    ## Plot colors
    BG <- NULL
    BG[dat.sub$model == "disp_obs"] <- rgb(1,0,0, ALPHA)
    BG[dat.sub$model == "truncated"] <- rgb(0,0,1, ALPHA)
    BG[dat.sub$model == "simple"] <- rgb(0,0,0, ALPHA)
    
    ## Plot
    plot(Y ~ delta, dat.sub, pch = 21, cex = 1.2, xlim = c(0,300), ylim = c(0,max(dat.sub$Y)),
         col = NA, bg = BG, axes = F, ann = F)
    box(bty = "l")
    axis(1, lab = ifelse(any(i==c(10:12, 22:24, 34:36)), T, F) )
    axis(2, las = 1)
    mtext(para.title) # parameter values
    
    ## Lowess fit
    fit1 <- lowess(dat.sub$Y[dat.sub$model=="disp_obs"] ~ dat.sub$delta[dat.sub$model=="disp_obs"])
    fit2 <- lowess(dat.sub$Y[dat.sub$model=="truncated"] ~ dat.sub$delta[dat.sub$model=="truncated"])
    fit3 <- lowess(dat.sub$Y[dat.sub$model=="simple"] ~ dat.sub$delta[dat.sub$model=="simple"])
    lines(fit1$y[order(fit1$x)] ~ sort(fit1$x), col = "red")
    lines(fit2$y[order(fit2$x)] ~ sort(fit2$x), col = "blue")
    lines(fit3$y[order(fit3$x)] ~ sort(fit3$x))
  }
  mtext(expression("True dispersal distance"~~delta[true]~"(m)"), 1, outer = T, line = 1, cex = 1.3)
  mtext(expression("95% CI in estimated dispersal distance"~~delta[est]), 2, outer = T, line = 1, cex = 1.3)

  dev.off()