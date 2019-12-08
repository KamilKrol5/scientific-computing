include("./interpolationLibrary.jl")
using .interpolationLibrary

using Test
using Polynomials

testCases = [
    (map(Float64, -2:3), [-25.0, 3, 1, -1, 27, 235], [-25.0, 28, -15, 5, 0, 1]), # example from tasklist for excercises
    (map(Float64, -1:3), [2.0, 1, 2, -7, 10], [2.0, -1, 1, -2, 2]), # example from tasklist for excercises
    ([3.0, 1, 5, 6], [1.0, -3, 2, 4], [1, 2, -3.0/8.0, 7.0/40.0]), # example from the lecture
]

areElementsApproximatelyEqual(xs, ys) = all(map(isapprox, xs, ys))

@testset "ilorazyRoznicoweTest" begin
    @testset for (x, f, fx) in testCases
        @test areElementsApproximatelyEqual(ilorazyRoznicowe(x, f), fx)
    end
end

@testset "warNewtonTest" begin
    @testset for (x, f) in testCases
        diff = ilorazyRoznicowe(x, f)
        @testset "x=$x0 f(x)=$value" for (x0, value) in zip(x, f)
            @test warNewton(x, diff, x0) ≈ value
        end
    end
end

@testset "naturalnaTest" begin
    @testset for (x, f) in testCases
        diff = ilorazyRoznicowe(x, f)
        natural = Poly(naturalna(x, diff))
        @testset "x=$x0" for x0 in x
            @test warNewton(x, diff, x0) ≈ natural(x0)
        end
    end
end