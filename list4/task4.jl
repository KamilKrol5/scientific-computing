# author: Kamil Król

using Plots

function rysujNnfx(f::Function, a::Float64, b::Float64, n::Int; filename::String)
    density = 40
    rangeLength = b - a
    step1 = rangeLength/n
    step2 = rangeLength/(density*n)
    x1 = a : step1 : b
    x2 = a : step2 : b
    fx = map(f, x1)

    dividedDifference = ilorazyRoznicowe(x1, fx)
    interpolatedValues = map(t -> warNewton(x1, dividedDifference, t), x2)
    realValues = map(f, x2)

    gr()
    plt = plot(x2,[realValues, interpolatedValues],lab=["f(x)" "p(x)"], lw=3.0)
    savefig(plt, string("plots/", filename))


end
