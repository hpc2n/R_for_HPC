#---
#title: "Exercises"
#author: "Pedro Ojeda, Birgitte Brydsö, Mirko Myllykoski, Lars Viklund"
#date: "Feb., 2021"
#output: html_document
#---

## 1. Exercise

#Use the following template by filling the *FIXME* strings with the corresponding
#R code. In this exercise, you will use the **tictoc** package to time different
#parts of a R code and save the results in a log file:


library(*FIXME*)             #We will use **tictoc** package
*FIXME*()                    #Clear the existing log file
*FIXME*("Total execution time")  #Start the stopwatch for the entire code

*FIXME*("time: var init")        #Start stopwatch for variables initialization
A <- matrix(1.0, 5000, 5000)
*FIXME*()                        #Stop  stopwatch for variables initialization 

sumcol <- function(B) {
*FIXME*("time: var init func")   #Start stopwatch for variables initialization in function
    l <- ncol(B)  #obtain the number of columns
  colsm <- rep(0,l) #create a vector to save the sums
*FIXME*(*FIXME*)                 #Stop stopwatch  for variables initialization in function   
*FIXME*("time: for loop")        #Start stopwatch for loop  
  for(j in 1:l){  
    s <- 0
    for(i in 1:l){
      s <- s + B[i,j]
    }
    colsm[j] <- s
  }
*FIXME*(*FIXME*)                 #Stop stopwatch for loop
  return(colsm)
}

res1 <- sumcol(A)

*FIXME*(*FIXME*)                 #Stop stopwatch for entire code
*FIXME* <- *FIXME*()             #Save the **tictoc** log file into a variable called *logfile*


#What is the most expensive part of this code?

## 2. Exercise

#In this problem you will use common packages to profile R code. Replace the *FIXME* strings
#with appropriate R code.

#Given the matrix A of ones with a size of 5000x5000:


A <- matrix(1.0, 5000, 5000)


#compare the profiling results of the following functions in a) and b).

#a) the user function *sumcol* computes the sum of the elements by columns



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

*FIXME*("*FIXME*")           #Start Rprof and write output in a filename called Rprofa.out
res1 <- *FIXME*(*FIXME*)     #profile the sumcol function with the matrix A as input 
*FIXME*(*FIXME*)             #Finish Rprof profiling 

*FIXME*Rprof("*FIXME")       #view the profiling's summary of Rprof



#b) the R built-in *colSums* function for computing the sums of elements by columns


*FIXME*("*FIXME*")           #Start Rprof and write output in a filename called Rprofb.out
res2 <- *FIXME*(*FIXME*)     #profile the colSums function with the matrix A as input
*FIXME*(*FIXME*)             #Finish Rprof profiling 
summary*FIXME*("*FIXME*")   #view the profiling's summary of Rprof 



#* Are the performances of the two functions similar? 
#* The two functions do the same calculation, why the performaces could differ?

## 3. Exercise

#**Challenge:** Do a benchmarking of the previous two functions by using rbenchmark
#and microbenchmark packages:


#initialize the matrix A and set function sumcol
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

library(*FIXME*)   #load rbenchmark package
#benchmark sumcol and colSums functions using the matrix A for 10 replicas
res3 <- *FIXME*(*FIXME*(*FIXME*), *FIXME*(*FIXME*), replications=*FIXME*) 
res3 

library(*FIXME*)   #load microbenchmark package
#benchmark sumcol and colSums functions using the matrix A for 10 replicas
res4 <- *FIXME*(*FIXME*(*FIXME*), *FIXME*(*FIXME*), times=*FIXME*)
res4
