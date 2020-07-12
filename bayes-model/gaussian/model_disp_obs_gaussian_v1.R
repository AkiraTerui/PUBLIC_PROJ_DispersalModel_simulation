model{
  # Priors
  tau ~ dscaled.gamma(1000, 1)
  sigma <- sqrt(1/tau)
  mu.phi ~ dunif(0,1)
  
  # Dispersal model
  for(i in 1:Nsample){
    ## Observation
    Y[i] ~ dbern(phi[i]*z[i])
    phi[i] <- mu.phi
    
    ## Dispersal
    z[i] <- step(s[i] - 1.5)
    s[i] <- step(L - X[i]) + step(X[i])
    X[i] ~ dnorm(X0[i], tau)
  }
}