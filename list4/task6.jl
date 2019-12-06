# author: Kamil Król

include("interpolationLibrary.jl")
using .interpolationLibrary

f1(x) = abs(x)
f2(x) = 1 / (1 + x ^ 2)

function main()
    for n in [5, 10, 15, 20, 30]
        rysujNnfx(f1, -1.0, 1.0, n, filename="task6plotf1_$n.png")
    end

    for n in [5, 10, 15, 20, 30]
        rysujNnfx(f2, -5.0, 5.0, n, filename="task6plotf2_$n.png")
    end
end

main()
