#author: Kamil Król

using Polynomials

p=[1, -210.0, 20615.0,-1256850.0,
      53327946.0,-1672280820.0, 40171771630.0, -756111184500.0,          
      11310276995381.0, -135585182899530.0,
      1307535010540395.0,     -10142299865511450.0,
      63030812099294896.0,     -311333643161390640.0,
      1206647803780373360.0,     -3599979517947607200.0,
      8037811822645051776.0,      -12870931245150988800.0,
      13803759753640704000.0,      -8752948036761600000.0,
      2432902008176640000.0]

function wilkinsonPolynomialNatural(x)
    P = Poly(reverse(p))
    return polyval(P, x)
    # result = 0.0
    # for c in 1:length(p)
    #     result = result + p[c] * x^(21-c)
    #     # println("$result + $(p[c]) * x^$(21-c))")
    # end
    # return result
end

function wilkinsonPolynomialMultiplicaive(x)
    p_ = poly([20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1])
    # result = (x - 20) * (x - 19) * (x - 18) * (x - 17) * (x - 16) * 
    # (x - 15) * (x - 14) * (x - 13) * (x - 12) * (x - 11) * 
    # (x - 10) * (x - 9) * (x - 8) * (x - 7) * (x - 6) * 
    # (x - 5) * (x - 4) * (x - 3) * (x - 2) * (x - 1)
    # return result
    return polyval(p_, x)
    
end

rootsOfP = roots(Poly(reverse(p)))
println("Roots of P: $rootsOfP")
for (index, r) in enumerate(rootsOfP)
    P_z_k = abs(wilkinsonPolynomialNatural(r))
    p_z_k = abs(wilkinsonPolynomialMultiplicaive(r))
    z_k_minus_k = abs(r - index)
    # println("z_$index = $r, P_z_$index = $P_z_k, p_z_$index = $p_z_k, |z_$index - $index| = $z_k_minus_k")
    println("$index & $r & $P_z_k & $p_z_k & $z_k_minus_k \\\\ \\hline")
end

#wilkinson experiment
p2=[1, -210.0-2^23, 20615.0,-1256850.0,
      53327946.0,-1672280820.0, 40171771630.0, -756111184500.0,          
      11310276995381.0, -135585182899530.0,
      1307535010540395.0,     -10142299865511450.0,
      63030812099294896.0,     -311333643161390640.0,
      1206647803780373360.0,     -3599979517947607200.0,
      8037811822645051776.0,      -12870931245150988800.0,
      13803759753640704000.0,      -8752948036761600000.0,
      2432902008176640000.0]
P2 = Poly(reverse(p2))

println()
println("Zeros of polynomial in wilkinson experiment: $(roots(P2))")
for r in roots(P2)
    println("$(real(r)) & $(imag(r))im \\\\ \\hline")
end