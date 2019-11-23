include("functions.jl")
using .functions
using Test

function mbisekcjiOk(f, a, b, eps, delta, root, iterations=-1)
    res = mbisekcji(f, a, b, eps, delta)
    return res[4] == 0 && (abs(res[1] - root) < eps || abs(res[2]) < delta) && (iterations == -1 || res[3] == iterations)
end

function mstycznychOk(f, f′, x_0, eps, delta, iter, root, expectedIterations=-1)
    res = mstycznych(f, f′, x_0, eps, delta, iter)
    return res[4] == 0 && (abs(res[1] - root) < eps || abs(res[2]) < delta) && (expectedIterations == -1 || res[3] == expectedIterations)
end

function msiecznychOk(f, x_0, x_1, eps, delta, iter, root, expectedIterations=-1)
    res = msiecznych(f, x_0, x_1, eps, delta, iter)
    return res[4] == 0 && (abs(res[1] - root) < eps || abs(res[2]) < delta) && (expectedIterations == -1 || res[3] == expectedIterations)
end

@testset "task4 sin(x)-(0.5x)^2" begin
        eps = 0.5 * 10.0^(-5)
        f(x) = sin(x) - (0.5 * x) ^ 2.0
        f′(x) = cos(x) - 0.5 * x
        @test mbisekcji(f, 1.5, 2.0, eps, eps) == (1.9337539672851562, -2.7027680138402843e-7, 16, 0)
        @test mstycznych(f, f′, 1.5, eps, eps, 40) == (1.933753779789742, -2.2423316314856834e-8, 4, 0)
        @test msiecznych(f, 1.0, 2.0, eps,eps, 40) == (1.933753644474301, 1.564525129449379e-7, 4, 0)
end

@testset "precision $prec" for prec in map(x -> parse(Float64, "5e-$x"), 3:12)
    eps = prec

    @testset "(x-8)(x-4)" begin
        f(x) = (x-8.0)*(x-4.0)
        f′(x) = 2*x -12
        @test mbisekcjiOk(f, 3.0, 5.0, eps, eps, 4.0)
        @test mbisekcjiOk(f, 5.5, 9.0, eps, eps, 8.0)
        @test mbisekcji(f, 8.5, 10.0, eps, eps) == ("error", "error", "error", 1)
        @test mstycznychOk(f, f′, 1.5, eps, eps, 40, 4.0)
        @test mstycznychOk(f, f′, 5.5, eps, eps, 40, 4.0)
        @test mstycznychOk(f, f′, 12.0, eps, eps, 40, 8.0)
        @test msiecznychOk(f, 1.0, 2.0, eps, eps, 40, 4.0)
        @test msiecznych(f, 4.0, 4.0, eps, eps, 40) == ("error", "error", "error", 1)
        @test msiecznychOk(f, 7.0, 9.0, eps, eps, 40, 8.0)
        @test msiecznychOk(f, 80.0, 9.0, eps,eps, 40, 8.0)
        @test msiecznych(f, 4.0, 8.0, eps, eps, 80) == ("error", "error", "error", 1)
    end

    @testset "e^x" begin
        f(x) = MathConstants.e^x
        @test mbisekcji(f, -8.0, 5.0, eps, eps) == ("error", "error", "error", 1)
    end

    @testset "x(x-9)(x-1) BISECTION" begin
        f(x) = x*(x-9.0)*(x-1.0)
        f′(x) = 9.0 - 20.0 * x + 3 * x^2
        @test mbisekcjiOk(f, -1.0, 0.05, eps, eps, 0.0)
        @test mbisekcjiOk(f, -1.0, 0.5, eps, eps, 0.0)
        @test mbisekcjiOk(f, -10.0, 0.999, eps, eps, 0.0)
        @test mbisekcjiOk(f, -100.0, 0.99999, eps, eps, 0.0)
        @test mbisekcjiOk(f, 0.2, 1.2, eps, eps, 1.0)
        @test mbisekcjiOk(f, 0.002, 1.001, eps, eps, 1.0)
        @test mbisekcjiOk(f, 0.99, 1.0001, eps, eps, 1.0)
        @test mbisekcjiOk(f, 0.99, 8.999, eps, eps, 1.0)
        @test mbisekcjiOk(f, 0.99, 5.0, eps, eps, 1.0)
        @test mbisekcjiOk(f, 0.5, 2.0, eps, eps, 1.0)
        @test mbisekcjiOk(f, 5.0, 10.0, eps, eps, 9.0)
        @test mbisekcjiOk(f, 8.999, 9.02, eps, eps, 9.0)
        @test mbisekcjiOk(f, 1.00001, 9.02, eps, eps, 9.0)
        @test mbisekcjiOk(f, 8.5, 9.5, eps, eps, 9.0)
    end

    @testset "x(x-9)(x-1) NEWTON" begin
        f(x) = x*(x-9.0)*(x-1.0)
        f′(x) = 9.0 - 20.0 * x + 3 * x^2
        @test mstycznychOk(f, f′, 0.05, eps, eps, 64, 0.0)
        @test mstycznychOk(f, f′, -1000.0, eps, eps, 64, 0.0)
        @test mstycznychOk(f, f′, 0.5, eps, eps, 64, 0.0)
        @test mstycznychOk(f, f′, -0.5, eps, eps, 64, 0.0)
        @test mstycznychOk(f, f′, 0.999, eps, eps, 64, 1.0)
        @test mstycznychOk(f, f′, -0.999, eps, eps, 64, 0.0)
        @test mstycznychOk(f, f′, 0.99999, eps, eps, 64, 1.0)
        @test mstycznychOk(f, f′, 1.2, eps, eps, 64, 1.0)
        @test mstycznychOk(f, f′, 1.001, eps, eps, 64, 1.0)
        @test mstycznychOk(f, f′, 1.0001, eps, eps, 64, 1.0)
        @test mstycznychOk(f, f′, 8.999, eps, eps, 64, 9.0)
        @test mstycznychOk(f, f′, 5.0, eps, eps, 64, 9.0)
        @test mstycznychOk(f, f′, 2.0, eps, eps, 64, 1.0)
        @test mstycznychOk(f, f′, 10.0, eps, eps, 64, 9.0)
        @test mstycznychOk(f, f′, 9.02, eps, eps, 64, 9.0)
        @test mstycznychOk(f, f′, 9.02, eps, eps, 64, 9.0)
        @test mstycznychOk(f, f′, 9.5, eps, eps, 64, 9.0)
        @test mstycznychOk(f, f′, 900.0, eps, eps, 64, 9.0)
        @test mstycznych(f, f′, 0.4853320848941607, eps, eps, 600) ==  ("error", "error", "error", 2)
        @test mstycznych(f, f′, 6.181334581772511, eps, eps, 600) ==  ("error", "error", "error", 2)
    end

    @testset "x(x-9)(x-1) SECANT" begin
        f(x) = x*(x-9.0)*(x-1.0)
        f′(x) = 9.0 - 20.0 * x + 3 * x^2
        @test msiecznychOk(f, 0.0, 0.05, eps, eps, 64, 0.0)
        @test msiecznychOk(f, 0.0, -1000.0, eps, eps, 64, 0.0)
        @test msiecznychOk(f, 0.0, 0.5, eps, eps, 64, 0.0)
        @test msiecznychOk(f, 0.0, -0.5, eps, eps, 64, 0.0)
        @test msiecznychOk(f, 0.0, 0.999, eps, eps, 64, 1.0)
        @test msiecznychOk(f, 0.0, -0.999, eps, eps, 64, 0.0)
        @test msiecznychOk(f, 0.0, 0.99999, eps, eps, 64, 1.0)
        @test msiecznychOk(f, 0.0, 1.2, eps, eps, 64, 1.0)
        @test msiecznychOk(f, 0.0, 1.001, eps, eps, 64, 1.0)
        @test msiecznychOk(f, 0.0, 1.0001, eps, eps, 64, 1.0)
        @test msiecznychOk(f, 0.0, 8.999, eps, eps, 64, 9.0)
        @test msiecznychOk(f, 0.0, 10.0, eps, eps, 64, 9.0)
        @test msiecznychOk(f, 0.0, 9.02, eps, eps, 64, 9.0)
        @test msiecznychOk(f, 0.0, 9.02, eps, eps, 64, 9.0)
        @test msiecznychOk(f, 0.0, 9.5, eps, eps, 64, 9.0)
        @test msiecznychOk(f, 0.0, 900.0, eps, eps, 64, 9.0)
    end

    @testset "x^3-x" begin
        f(x) = x^3-x
        f′(x) = 3*x^2-1
        @test mstycznychOk(f, f′, 1.0, eps, eps, 64, 0.0)
        @test mstycznych(f, f′, 1.0/sqrt(3), eps, eps, 64) == ("error", "error", "error", 2)
        @test mstycznych(f, f′, -1.0/sqrt(3), eps, eps, 64) == ("error", "error", "error", 2)
        @test mstycznych(f, f′, -1.0/sqrt(5), eps, eps, 64) == ("error", "error", "error", 1)
        @test mstycznych(f, f′, 1.0/sqrt(5), eps, eps, 64) == ("error", "error", "error", 1)
    end
end