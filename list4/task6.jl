# author: Kamil Król

include("interpolationLibrary.jl")
using .interpolationLibrary
using Plots

f1(x) = abs(x)
f2(x) = 1 / (1 + x ^ 2)

function main()
    for n in [5, 10, 15, 20, 30]
        rysujNnfx(f1, -1.0, 1.0, n, filename="task6plotf1_$n.png")
        rysujNnfxForChebyshev(f1, -1.0, 1.0, n, filename="task6ChebyshevPlotf1_$n.png")
    end

    for n in [5, 10, 15, 20, 30]
        rysujNnfx(f2, -5.0, 5.0, n, filename="task6plotf2_$n.png")
        rysujNnfxForChebyshev(f2, -5.0, 5.0, n, filename="task6ChebyshevPlotf2_$n.png")
    end
end

function generateChebyshevNodes(a, b, n)
    return map(i -> b + (1.0 - cos((2.0 * i - 1.0) * π / (2.0 * n))) * (a - b) / 2.0, 1:n)
end

function rysujNnfxForChebyshev(f::Function, a::Float64, b::Float64, n::Int; filename::String)
    density = 40
    rangeLength = b - a
    step2 = rangeLength/(density*n)
    x1 = generateChebyshevNodes(a,b,n)
    x2 = a : step2 : b
    fx = map(f, x1)

    dividedDifference = ilorazyRoznicowe(x1, fx)
    interpolatedValues = map(t -> warNewton(x1, dividedDifference, t), x2)
    realValues = map(f, x2)

    gr()
    plt = plot(x2,[realValues, interpolatedValues],lab=["f(x)" "p(x)"], lw=3.0)
    savefig(plt, string("plots/", filename))
end

main()
