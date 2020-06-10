model{
  # Priors
  ninfo <- 0.01
  log.delta ~ dnorm(0, ninfo)T(-10,10)
  
  # Likelihood
  for(i in 1:Nsample){
    X[i] ~ ddexp(X0[i], theta)T(0,L)
  }
  theta <- 1/delta
  log(delta) <- log.delta
}