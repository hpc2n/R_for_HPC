#---
#title: "Exercises"
#author: "Pedro Ojeda, Birgitte Brydsö, Mirko Myllykoski, Lars Viklund"
#date: "Feb., 2021"
#output: html_document
#---

## Problem 1. 

#Using the functions sumcol() and colSums() from the Profiling section to obtain a memory 
#profiling summary using *Rprof*. Replace *FIXME* strings with the appropriate R code.



A <- matrix(1.0, 5000, 5000)     #Matrix initialization

sumcol <- function(B) {
  l <- ncol(B)  #obtain the number of columns
  colsm <- rep(0,l) #create a vector to save the sums
  
  for(j in 1:l){  
    s <- 0
    for(i in 1:l){
      s <- s + B[i,j]
    }
    colsm[i] <- s
  }
  return(colsm)
}

#Profiling sumcol() function
*FIXME*("Rprof-mema.out", *FIXME*=*FIXME*)
res1 <- sumcol(A)
*FIXME*(*FIXME*)
*FIXME*("Rprof-mema.out", *FIXME*=*FIXME*)   #see the summary report

#Profiling colSums() function
*FIXME*("Rprof-memb.out", *FIXME*=*FIXME*)
res2 <- colSums(A)
*FIXME*(*FIXME*)
*FIXME*("Rprof-memb.out", *FIXME*=*FIXME*)   #see the summary report


#What is the total memory used by *sumcol()* and *colSums()*?

## Problem 2.

#Using the setup from the lecture on *bigmemory* package for the large array *bm*,
#compute the mean and standard deviation of each column for a matrix with a size
#$10^7 \times 3$ and using chunks of $10^6$.

#First, we create the backing file *bm* and descriptor *bm.desc* for the big matrix:


library(*FIXME*)
set.seed(1234)
bm <- big.matrix(*FIXME*, *FIXME*, backingfile = "bm", backingpath = getwd())
bm


#Now, work with chunks of data. Initialize the big matrix's columns with according to
#probability distributions:


chunksize <- *FIXME*
start <- 1
while (start <= nrow(bm)) {
  end <- min(*FIXME* + *FIXME* -1, nrow(bm))
  chunksize <- *FIXME* - *FIXME* + 1
  bm[*FIXME*, 1] <- rpois(chunksize, 1e3)
  bm[*FIXME*, 2] <- sample(0:1, chunksize, TRUE, c(0.7,0.3))
  bm[*FIXME*, 3] <- runif(chunksize, 0, 1e5)
  start <- start + *FIXME*
}


#means:


col.sums <- numeric(3)
chunksize <- *FIXME*
start <- 1
while (start <= nrow(bm)) {
  end <- min(*FIXME* + *FIXME* -1, nrow(bm))
  col.sums <- col.sums + colSums(bm[*FIXME*:*FIXME*,])
  start <- start + *FIXME*
}
col.means <- *FIXME* / nrow(bm)
col.means



#standard deviations:


col.sq.dev <- numeric(3)
chunksize <- *FIXME*
start <- 1
while (start <= nrow(bm)) {
  end <- min(*FIXME* + *FIXME* -1, nrow(bm))
  col.sq.dev <- col.sq.dev + rowSums((t(bm[*FIXME*:*FIXME*,]) - col.means) ^2)
  start <- start + *FIXME*
}
col.var <- *FIXME*/(nrow(bm)-1)
col.sd <- sqrt(col.var)
col.sd


#Note: *bigmemory* package is used for larger matrices than in the present 
#example. Here, I chose a small size for the matrix to avoid filling your 
#disk.


## Problem 3.

#The two following *for loops* use a cutoff of 0.05 to assing the value **NA** to the vector
#elements:


library(tictoc)
x <- runif(1e+08)   #change this value to 1e+06, 1e+07, 1e+08         

#plain loop
tic()
for (i in 1:length(x)) {
  if (x[i] < 0.05) {
    x[i] <- NA
  }
}
toc()

x <- runif(1e+08)   #change this value to 1e+06, 1e+07, 1e+08
#below is the vectorized counterpart:
tic()
x[which(x < 0.05)] <- NA 
toc()


#compare the execution times of both functions using vector sizes of 1e+06, 1e+07, and 1e+08. 
#Which function showed the best performance?

#Now, use *gcinfo* to analyze the memory used by both codes (plain loop and the vectorized one)
#as follows: 


#rm(list = ls())
x <- runif(1e+07)
check <- gcinfo(TRUE)
if(check == FALSE) check <- gcinfo(TRUE)

#Plain loop
  for (i in 1:length(x)) {
    if (x[i] < 0.05) {
      x[i] <- NA
    }
  }

gcinfo(FALSE)



x <- runif(1e+07)
check <- gcinfo(TRUE)
if(check == FALSE) check <- gcinfo(TRUE)

x[which(x < 0.05)] <- NA 

gcinfo(FALSE)


#which code uses more memory? Based on this result, when would it be more appropriate to use the
#plain loop and when the vectorized code? **Note: in order to run the codes for the plain loop and
#the vectorized code, one needs to start with a fresh R session (Ctrl+Shift+F10) after running each
#of block of code**
