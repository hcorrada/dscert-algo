mu1 = 1
s1 = 1
mu2 = -1
s2 = sqrt(3)
pi1 = .6
pi2 = .4

draw <- function(n=1000) {
  delta <- rbernoulli(n, pi1)
  mu <- ifelse(delta == 0, mu1, mu2)
  s <- ifelse(delta == 0, s1, s2)
  rnorm(n, mean = mu, sd = s)
}

set.seed(1234)
x <- draw()

curve(pi1*dnorm(x,mean=mu1,sd=s1) + pi2*dnorm(x,mean=mu2,sd=s2),from=-6,to=4,ylab = "density")
curve(pi1*dnorm(x, mean = mu1, sd=s1), from=-6,to=5,col="red",add=TRUE,lty=2)
curve(pi2*dnorm(x, mean = mu2, sd=s2), from=-6,to=5,col="blue",add=TRUE,lty=2)

true_theta <- list(mu1=mu1,s1=s1,mu2=mu2,s2=s2,pi1=pi1)
plot_mix <- function(cur_theta, true_theta) {
  with(true_theta,curve(pi1*dnorm(x,mean=mu1,sd=s1) + (1-pi1)*dnorm(x,mean=mu2,sd=s2),from=-6,to=4,ylab = "density"))
  with(cur_theta,curve(pi1*dnorm(x, mean = mu1, sd=s1), from=-6,to=5,col="red",add=TRUE,lty=2))
  with(cur_theta,curve((1-pi1)*dnorm(x, mean = mu2, sd=s2), from=-6,to=5,col="blue",add=TRUE,lty=2))
  
}

plot_mix(true_theta,true_theta)

init_theta <- function() {
  res <- list()
  res$mu1 = runif(1, min=-3, max=3)
  res$s1 = exp(runif(1, min=-1, max=2))
  res$mu2 = runif(1, min=-3, max=3)
  res$s2 = exp(runif(1, min=-1, max=2))
  res$pi1 = runif(1, min=0, max=1)  
  res
}

theta0 <- init_theta()
plot_mix(theta0, true_theta)

estep <- function(theta, x) {
  d0 = with(theta, pi1 * dnorm(x, mean=mu1, sd=s1))
  d1 = with(theta,(1-pi1) * dnorm(x, mean=mu2, sd=s2))
  d0 / (d0 + d1)
}

mstep <- function(theta, x, z) {
  res <- list()
  res$mu1 = sum(x*z)/sum(z)
  v1 <- sum(z * (x-res$mu1)^2) / sum(z)
  res$s1 <- sqrt(v1)
  
  res$mu2 - sum(x*(1-z)) / sum(1-z)
  v2 <- sum((1-z)* (x-res$mu2)^2) / sum(1-z)
  res$s2 <- sqrt(v2)
  
  n <- length(x)
  res$pi1 = sum(z) / n
  res
}

z <- estep(theta0,x)
theta_k <- mstep(theta0, x, z)

plot_mix(theta_k, true_theta)

em_step <- function(theta, x) {
  z <- estep(theta, x)
  mstep(theta, x, z)
}

theta1 <- em_step(theta0,x)
plot_mix(theta1, true_theta)

plot_mix(true_theta, true_theta)

theta <- init_theta()
plot_mix(theta, true_theta)
for (step in seq(1,5)) {
  cat("step ", step, "\n")
  theta <- em_step(theta, x)
  plot_mix(theta, true_theta)
}