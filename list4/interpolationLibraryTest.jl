include("./interpolationLibrary.jl")
using .interpolationLibrary

using Test

isapproxvec(xs, ys) = all(map(isapprox, xs, ys))

@testset "ilorazyRoznicowe" begin
    @test isapproxvec(ilorazyRoznicowe(Float64.([3, 1, 5, 6]), Float64.([1, -3, 2, 4])), [1, 2, -3.0/8.0, 7.0/40.0])
end
