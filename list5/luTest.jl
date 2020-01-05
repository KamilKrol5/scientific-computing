include("./matrixgen.jl")
include("./blocksys.jl")
include("matrixgen.jl")

using .blocksys
using .matrixgen
using SparseArrays
using Test

@testset "lu 16" begin
    (A,n,l) = load_matrix("data16/A.txt")
    b = load_vector("data16/b.txt")
    lu_matrix = lu(A, b, n, l)
    # display(@view lu_matrix[:,:])
    vx = solve_using_lu(lu_matrix, b, n, l)
    # display(@view vx[:,:])
    @testset for x in @view vx[:,:]
        @test x ≈ 1.0
    end
end

@testset "lu choice 16" begin
    (A,n,l) = load_matrix("data16/A.txt")
    b = load_vector("data16/b.txt")
    (lu_matrix, permutation) = lu_with_choice_of_main_element(A, b, n, l)
    vx = solve_using_lu_with_main_element(lu_matrix, permutation, b, n, l)
    @testset for x in @view vx[:,:]
        @test x ≈ 1.0
    end
end

@testset "lu 10000" begin
    (A,n,l) = load_matrix("data10000/A.txt")
    b = load_vector("data10000/b.txt")
    lu_matrix = lu(A, b, n, l)
    vx = solve_using_lu(lu_matrix, b, n, l)
    @testset for x in @view vx[:,:]
        @test x ≈ 1.0
    end
end

@testset "lu choice 10000" begin
    (A,n,l) = load_matrix("data10000/A.txt")
    b = load_vector("data10000/b.txt")
    (lu_matrix, permutation) = lu_with_choice_of_main_element(A, b, n, l)
    vx = solve_using_lu_with_main_element(lu_matrix, permutation, b, n, l)
    @testset for x in @view vx[:,:]
        @test x ≈ 1.0
    end
end

@testset "lu 50000" begin
    (A,n,l) = load_matrix("data50000/A.txt")
    b = load_vector("data50000/b.txt")
    lu_matrix = lu(A, b, n, l)
    vx = solve_using_lu(lu_matrix, b, n, l)
    @testset for x in @view vx[:,:]
        @test x ≈ 1.0
    end
end

@testset "lu choice 50000" begin
    (A,n,l) = load_matrix("data50000/A.txt")
    b = load_vector("data50000/b.txt")
    (lu_matrix, permutation) = lu_with_choice_of_main_element(A, b, n, l)
    vx = solve_using_lu_with_main_element(lu_matrix, permutation, b, n, l)
    @testset for x in @view vx[:,:]
        @test x ≈ 1.0
    end
end

@testset for i = 1000:1000:10000
    @testset "lu $i computed b" begin
        blockmat(i, 4, 10.0, "matrix/matrix$i")
        (A,n,l) = load_matrix("matrix/matrix$i")
        x = ones(Float64, n)
        b = A' * x
        lu_matrix = lu(A, b, n, l)
        vx = solve_using_lu(lu_matrix, b, n, l)
        @test all(map(x -> x ≈ 1.0, vx)) 
        err = write_vector("xd.txt", vx, n, true)
        println("       Relative error: $err")
    end
end

@testset for i = 1000:1000:10000
    @testset "lu with choice $i computed b" begin
        blockmat(i, 4, 10.0, "matrix/matrix$i")
        (A,n,l) = load_matrix("matrix/matrix$i")
        x = ones(Float64, n)
        b = A' * x
        (lu_matrix, p) = lu_with_choice_of_main_element(A, b, n, l)
        vx = solve_using_lu_with_main_element(lu_matrix, p, b, n, l)
        @test all(map(x -> x ≈ 1.0, vx)) 
        err = write_vector("xd.txt", vx, n, true)
        println("       Relative error: $err")
    end
end