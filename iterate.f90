	complex *16 function p1(u,v) 
	complex *16 u,v
	complex *16 one,ten
	one = 1
    ten = 10
        p1 = one  + 0.01*(u*u + 2*v*v + 3*u*v)
	return 
	end
	complex *16 function p2(u,v) 
	complex *16 u,v
	complex *16 one,ten
	one = 1 
	ten = 10
        p2 =one + 0.01 *(u*u + 5*v*v + 4*u*v)
	return 
	end
	
	program  iterate 
	complex *16 u,v, newu, newv 
	complex *16 a,b
	complex *16 myI 
	complex *16 p1, p2
	real *8 omega1,omega2,mypi
	real *8 zero, one, two, five,ten
	real *8 s,t,step
	integer n,m,j
    
    integer test_precision
    test_precision = 1
	
	zero = 0 
	one = 1 
	two = 2
	five = 5
	ten = 10
	myI = cmplx(zero, one)
        
        write(*,*) "# ", myI*myI
	
	omega1= 0.15
	omega2= 0.15
	mypi = 4*atan(one)

	a = exp(two*mypi*myI*omega1) 
	b = exp(two*mypi*myI*omega2)

        write(*,*) "# ", abs(a), abs(b)

	step  = ((one/ten)/ten)/ten
	
	s = -five
	do  n = 1, 10
	s = s + step 
	t = -five
	do  m = 1, 10
	t = t +step 

	u = dcmplx(s,zero)
	v = dcmplx(t,zero)
    
    if(test_precision .eq. 1) then
        write(*,*) "s = ", s
        write(*,*) "t = ", t
        write(*,*) "u = ", u
        write(*,*) "v = ", v
    end if

	do   j  = 1, 200

	u = a*u*p1(u,v)/p1(1/u,1/v) 
	v = b*v*p2(u,v)/p2(1/u,1/v)

	if( (abs(u) .gt. five) .or. (abs(v) .gt. five))  then
	write (*,*) "#  ", abs(u), abs(v),j
	go to 20
	end if 

	end do
20      continue
	if(j .eq. 201)  then 
	write(*,*) s,t
	end if
	end do 
	end do
	stop

	end
