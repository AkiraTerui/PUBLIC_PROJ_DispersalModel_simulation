model{
  # Priors
  ninfo <- 0.01
  log.delta ~ dnorm(0, ninfo)T(-10,10)
  mu.phi ~ dunif(0,1)
  
  # Dispersal model
  for(i in 1:Nsample){
    ## Observation
    Y[i] ~ dbern(phi[i]*z[i])
    phi[i] <- mu.phi
    
    ## Dispersal
    z[i] <- step(s[i] - 1.5)
    s[i] <- step(L - X[i]) + step(X[i])
    X[i] ~ ddexp(X0[i], theta)
  }
  theta <- 1/delta
  log(delta) <- log.delta
}