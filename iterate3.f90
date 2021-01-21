	complex *16  function p1(u,v) 
	complex *16  u,v
	complex *16  one,ten,five
	one = 1 
	ten = 10
	five = 5
        p1 = one  + ( (((one/ten)/ten)/ten)/five)*(u*u + 2*v*v + 3*u*v)
	return 
	end
	complex *16  function p2(u,v) 
	complex *16 u,v
	complex *16 one,ten,five
	one = 1 
	ten = 10
        p2 =one + ((((one/ten)/ten)/ten )/five) *(u*u + 5*v*v + 4*u*v)
	return 
	end
	
	program  iterate 
	complex *16  u,v, newu, newv 
	complex *16  a,b
	complex *16 myI 
	complex *16  p1, p2
	real *8  omega1,omega2,mypi
	real *8  zero, one, two, five,ten
	real *8  s,t,step
	real *8  distu,distv, mindist, minmax
	real *8  stepomega1, stepomega2
	integer n,m,j, j1, j2
    integer nmax,mmax,jmax,j1max,j2max
    
    jmax = 4
    j1max = 4
    j2max = 4
    nmax = 4
    mmax = 4
    step = 0.1
	
	zero = 0 
	one = 1 
	two = 2
	five = 5
	ten = 10
	myI = cmplx(zero, one)
	
        mypi = 4*atan(one)

    stepomega1 = one/j1max
    stepomega2 = one/j2max

	omega1 = zero
	do j1 = 1,j1max
	   omega1 = omega1 + stepomega1 
	   omega2 = zero
	do j2 = 1,j2max
	   omega2= omega2 + stepomega2

	a = exp(two*mypi*myI*omega1) 
	b = exp(two*mypi*myI*omega2) 
	

        write(*,*) "# ", abs(a), abs(b)

	
	minmax = zero

	s = -five
	do  n = 1, nmax
	s = s+step 
	t = -five
	do  m = 1, mmax
	t = t +step 

	u = cmplx(s,zero) 
	v = cmplx(t,zero) 
	
	mindist = ten
	do   j  = 1, jmax

	u = a*u*p1(u,v)/p1(1/u,1/v) 
	v = b*v*p2(u,v)/p2(1/u,1/v) 

	distu =  abs( (abs(u) - one))
	distv =  abs( (abs(v) - one))

	if(distu .lt. mindist) then
	   mindist = distu
	endif

	if(distv .lt. mindist) then
	   mindist = distv
	endif

	if( (abs(u) .gt. five) .or. (abs(v) .gt. five))  then 
	write (*,*) "#  ", abs(u), abs(v),j
	go to 20
	end if 

	end do
20      continue
	if(j .gt. jmax)  then 
	   if (mindist .gt. minmax) then 
	      minmax = mindist 
	   endif

	end if
	end do 
	end do
	write (*,*) omega1, omega2, minmax
	end do 
	end do 
	stop

	end
