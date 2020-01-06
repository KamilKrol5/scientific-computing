# author: Kamil Król

include("./matrixgen.jl")
include("./blocksys.jl")
include("matrixgen.jl")

using .blocksys
using SparseArrays
using Test
using .matrixgen


# (A,n,l) = load_matrix("data16/A.txt")
# display(@view A[:,:])
# (A,n,l) = load_matrix("data50000/A.txt")
# b = load_vector("data50000/b.txt")
# # display(@view A[:,:])
# # A2, b2 = gauss(A, b, n, l, false)
# # print(A2)
# # display(@view A2[:,:])
# x_vec = solve_gauss_with_choose_main_element(A, b, n, l)
# display(@view x_vec[:,:])

@testset "gauss with partial choice 50000" begin
    (A,n,l) = load_matrix("data50000/A.txt")
    b = load_vector("data50000/b.txt")
    x_vec = solve_gauss_with_choice_main_element(A, b, n, l)
    @testset for x in @view x_vec[:,:]
        @test x ≈ 1.0
    end
end

@testset "gauss with partial choice 10000" begin
    (A,n,l) = load_matrix("data10000/A.txt")
    b = load_vector("data10000/b.txt")
    x_vec = solve_gauss_with_choice_main_element(A, b, n, l)
    @testset for x in @view x_vec[:,:]
        @test x ≈ 1.0
    end
end

@testset "gauss 50000" begin
    (A,n,l) = load_matrix("data50000/A.txt")
    b = load_vector("data50000/b.txt")
    x_vec = solve_gauss(A, b, n, l)
    @testset for x in @view x_vec[:,:]
        @test x ≈ 1.0
    end
end

@testset "gauss 10000" begin
    (A,n,l) = load_matrix("data10000/A.txt")
    b = load_vector("data10000/b.txt")
    x_vec = solve_gauss(A, b, n, l)
    @testset for x in @view x_vec[:,:]
        @test x ≈ 1.0
    end
end


@testset for i = 1000:1000:10000
    @testset "gauss $i computed b" begin
        blockmat(i, 4, 10.0, "matrix/matrix$i")
        (A,n,l) = load_matrix("matrix/matrix$i")
        x = ones(Float64, n)
        b = A' * x
        x_vec = solve_gauss(A, b, n, l)
        @test all(map(x -> x ≈ 1.0, x_vec)) 
        err = write_vector("xd.txt", x_vec, n, true)
        println("       Relative error: $err")
    end
end

@testset for i = 1000:1000:10000
    @testset "gauss with choice $i computed b" begin
        blockmat(i, 4, 10.0, "matrix/matrix$i")
        (A,n,l) = load_matrix("matrix/matrix$i")
        x = ones(Float64, n)
        b = A' * x
        x_vec = solve_gauss_with_choice_main_element(A, b, n, l)
        @test all(map(x -> x ≈ 1.0, x_vec)) 
        err = write_vector("xd.txt", x_vec, n, true)
        println("       Relative error: $err")
    end
end