subroutine pifunc(n)
implicit none
integer, parameter :: seed = 86456
integer     :: i,n,hits
real        :: x,y,r,pival

call srand(seed)
hits = 0
do i=1,n
   x = rand()
   y = rand()
   r = sqrt(x*x + y*y)
   if(r <= 1) then 
       hits = hits + 1
   endif
enddo

pival = 4.0d0*hits/(1.0*n)

end subroutine pifunc
