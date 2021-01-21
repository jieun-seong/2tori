# static arrays -> will improve the speed? why?

    zero = BigFloat(0)
    one = BigFloat(1)
    two = BigFloat(2)

    i = complex(zero, one)
    println("# ", i*i)

    omega1 = omega2 = BigFloat(15) / BigFloat(100) # 0.15
    a = exp(two*pi*i*omega1)
    b = exp(two*pi*i*omega2)
    println("# ", abs(a), " ", abs(b))
    
    eps = one / BigFloat(100) # 0.01
    p1(u, v) = (u.*u .+ v.*v.*BigFloat(2) .+ u.*v.*BigFloat(3)) .* eps .+ one
    p2(u, v) = (u.*u .+ v.*v.*BigFloat(5) .+ u.*v.*BigFloat(8)) .* eps .+ one

    nmax = mmax = 2000
    step = one / BigFloat(1000) # 0.001

    s_init = t_init = BigFloat(-3)

    #@time begin

    s_global = collect(s_init:step:(s_init+step*nmax))

    for m in 1:mmax
        s = reshape(s_global, length(s_global), 1)
        t_m = t_init+step*m
        t = fill(t_m, length(s_global), 1)
        u = reshape(complex.(s), length(s_global), 1)
        v = reshape(complex.(t), length(s_global), 1)
        j = 1
        for j in 1:50
            if (length(u)==0)
                break
            end
            u = a .* u .* p1(u, v) ./ p1(u.^(-1), v.^(-1))
            v = b .* v .* p2(u, v) ./ p2(u.^(-1), v.^(-1))
            escaped = (abs.(u).>5) .| (abs.(v).>5)
            u_escaped = u[escaped]
            v_escaped = v[escaped]
            remaining = .!escaped
            #=for k in 1:length(u_escaped)
                println("#  ", abs(u_escaped[k]), "  ", abs(v_escaped[k]), "  ", j)
            end #for=#
            u = u[remaining]
            v = v[remaining]
            s = s[remaining]
            t = t[remaining]
        end #for
        for k in 1:length(s)
            println(s[k], "  ", t_m)
        end #for
    end #for
    #end