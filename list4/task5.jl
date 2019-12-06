# author: Kamil Król

include("interpolationLibrary.jl")
using .interpolationLibrary

f1(x) = MathConstants.e ^ x
f2(x) = x^2 * sin(x)


function main()
    for n in [5, 10, 15]
        rysujNnfx(f1, 0.0, 1.0, n, filename="task5plotf1_$n.png")
    end

    for n in [5, 10, 15]
        rysujNnfx(f2, -1.0, 1.0, n, filename="task5plotf2_$n.png")
    end
end

main()
