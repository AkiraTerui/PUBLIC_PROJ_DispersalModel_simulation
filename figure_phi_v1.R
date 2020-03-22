# Read data ----
  rm(list=ls(all.names=T))
  library(devEMF)
  dat <- read.csv("result/sim_model_2020-03-17.csv")
  para <- sapply(2:4, function(i)unique(dat[,i]) )
  para.set <- expand.grid(para[[1]], para[[2]], para[[3]])
  panel.id <- c("(a)", "(b)", "(c)",
                "(d)", "(e)", "(f)",
                "(g)", "(h)", "(i)",
                "(j)", "(k)", "(l)")

# Plot ----
  #pdf("figure_Phi_v1.pdf", width = 11, height = 13.5)
  emf("figure_Phi_v1.emf", width = 11, height = 13.5)
  par(mfrow = c(4,3), oma = c(4,5,2,1), mar = c(4,4,1,1), cex.axis = 1.5, cex.lab = 1.5)
  
  ALPHA <- 0.2
  for(i in 1:nrow(para.set)){
    ## Sub-dataset with a given parameter set
    ROW <- dat$N==para.set[i,1]&dat$LEN==para.set[i,2]&dat$PHI==para.set[i,3]&dat$model=="disp_obs"
    dat.sub <- dat[ROW,]
    
    ## Parameter set title
    para.title <- substitute(a~"N ="~b*", L ="~c*", "~phi*" = "*d*"",
                             list( a = panel.id[i],
                                   b = unique(dat.sub$N),
                                   c = unique(dat.sub$LEN),
                                   d = unique(dat.sub$PHI) ) )
    
    ## Plot
    plot(phi_med ~ delta, dat.sub, pch = 21, cex = 1.2, xlim = c(0,300), ylim = c(0,max(dat.sub$Pstay)),
         col = NA, bg = rgb(1,0,0,ALPHA), axes = F, ann = F)
    segments(x0 = dat.sub$delta, y0 = dat.sub$phi_lower, y1 = dat.sub$phi_upper, col = rgb(1,0,0,ALPHA) )
    box(bty = "l")
    axis(1, lab = ifelse(any(i==c(10:12, 22:24, 34:36)), T, F) )
    axis(2, las = 1)
    abline(h = unique(dat.sub$PHI), col = grey(0, ALPHA))
    mtext(para.title) # parameter values
  }
  mtext(expression("True dispersal distance"~delta[true]~"(m)"), 1, outer = T, line = 1, cex = 1.3)
  mtext(expression("Estimated recapture probability"~phi[est]), 2, outer = T, line = 1, cex = 1.3)
  
  dev.off()