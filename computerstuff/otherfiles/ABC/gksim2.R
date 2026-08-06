# gk package available from github:
# https://github.com/dennisprangle/gk

library(gk)

##Simulate a dataset of 1000 iid g-and-k draws (typical in ABC papers using this distribution)
x <- rgk(1000, A=3, B=1, g=2, k=0.5)

##Simulate some parameter values from typical prior distributions
n <- 100000
A <- runif(n,0,10)
B <- runif(n,0,10)
g <- runif(n,0,10)
k <- runif(n,0,10)
theta <- cbind(A,B,g,k)

##Simulate n datasets of 1000 iid draws each
X <- sapply(1:n,
            function(i) { rgk(1000, theta=theta[i,]) }
            )

##Efficiently simulate n datasets consisting of particular order statistics taken from 1000 iid draws
#os <- c(250,500,750)

# octiles
os <- (1000/8)*(1:7)

Y <- sapply(1:n,
            function(i) { rgk.orderstats(1000, orderstats=os, theta=theta[i,]) }
            )

gkl<-list(theta=theta,X=X,Y=Y)

gkdata<-cbind(theta,t(Y))
save(gkdata,file="gkdata.rda")
