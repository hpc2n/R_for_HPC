#---
#title: "Exercises"
#author: "Pedro Ojeda, Birgitte Brydsö, Mirko Myllykoski, Lars Viklund"
#date: "Feb., 2021"
#output: html_document
#---


## 1. Exercise

#In the previous module about Profiling we wrote a function for computing the sum of the elements of each column:


library(tictoc)
A <- matrix(1.0, 5000, 5000)
sumcol <- function(B) {
  l <- ncol(B)  #obtain the number of columns
  colsm <- rep(0,l) #create a vector to save the sums
  
  for(j in 1:l){  
    s <- 0
    for(i in 1:l){
      s <- s + B[i,j]
    }
    colsm[j] <- s
  }
  return(colsm)
}

tic()
res1 <- sumcol(A)
toc()


#The bottleneck in this function was the for loop. In this exercise, we will vectorize the heavy loop.
#Replace the *FIXME* strings with the corresponding R code:


library(tictoc)
A <- matrix(1.0, 5000, 5000)
sumcol_vec <- function(B) {
  l <- ncol(B)  #obtain the number of columns
  colsm <- rep(0,l) #create a vector to save the sums
  
  for(j in 1:l){  
    colsm[j] <- *FIXME*(B[,*FIXME*])  #hint the sum function is a vectorized operation
                                      #we also need to specify a range for elements in the matrix
  }
  return(colsm)
}

tic()
res2 <- sumcol_vec(A)
toc()


#Did the vectorized code ran faster?

## 2. Exercise

#The function *sdcol* which computes the standard deviation of each column of a matrix A of size 
#10000x3 using for loops. This function has a strong C accent. 

#Compare the performance of this function with the counterpart *apply()* function for computing 
#the standard deviation. 

#Finally, compare the performance of these two functions with the colSds() function from the 
#*library(matrixStats)* package.



A <- matrix(sample(0:1, 1000000, replace = TRUE),1000000,3)

sdcol <- function(B) {
  l <- ncol(B)  #obtain the number of columns
  n <- nrow(B)  #obtain the number of rows
  colsm <- rep(0,l) #create a vector to save the means
  colsd <- rep(0,l) #create a vector to save the sd
  
  for(j in 1:l){  
    s <- 0
    for(i in 1:n){
      s <- s + B[i,j]
    }
    colsm[j] <- s/n
  }
  
  for(j in 1:l){  
    s <- 0
    for(i in 1:n){
      s <- s + (B[i,j] - colsm[j])^2
    }
    colsd[j] <- sqrt( s/(n-1))
  }
  
  return(colsd)
}
library(tictoc)
tic()
res1 <- sdcol(A)
toc()

tic()
res2 <- apply(A,2,sd)
toc()

#install.packages("matrixStats")
library(matrixStats)
tic()
res3 <- colSds(A)
toc()


#What function performed best? What could be the difference from the other two?

## 3. Exercise

#Use the *Rcpp* package to write a C++ function that adds three float numbers:


library(Rcpp)

cppFunction('*FIXME* sum_cpp(*FIXME*, *FIXME* , *FIXME* ) {
  *FIXME* sumc = *FIXME* ;
  return sumc;
}')
sum_cpp   
sum_cpp(2,4,6)


## 4. Exercise (Challenge)

#The following functions **func1, func2** update the entry *i,j* of a matrix A (they do the same thing).
#One of them is faster than the other. 


library(tictoc)
A <- matrix(runif(1000000),nrow=1000)

func1 <- function(a) {
  for(j in 1:ncol(a)) {
    for(i in 1:nrow(a)) {
      if (a[i,j] > 0.5 ) {
        a[i,j] <- 0.5
      }
    }
  }
  a
}
tic()
B <- func1(A)
toc()

func2 <- function(a) {
  for(j in 1:dim(a)[2]) {
    for(i in 1:dim(a)[1]) {
      if (a[i,j] > 0.5 ) {
        a[i,j] <- 0.5
      }
    }
  }
  a
}

tic()
C <- func2(A)
toc()




library(lineprof)
prof1 <- lineprof(func1(A))
prof1

prof2 <- lineprof(func2(A))
prof2


#Look at the columns allocated, release, and duplicated data. Can you draw a conclusion why one 
#of the functions is faster that the other?
