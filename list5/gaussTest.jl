include("./matrixgen.jl")
include("./blocksys.jl")

using .blocksys
using SparseArrays
using Test


# (A,n,l) = load_matrix("data50000/A.txt")
# b = load_vector("data50000/b.txt")
# # display(@view A[:,:])
# # A2, b2 = gauss(A, b, n, l, false)
# # print(A2)
# # display(@view A2[:,:])
# b3 = solve_gauss_with_choose_main_element(A, b, n, l)
# display(@view b3[:,:])
@testset "gauss with partial choice 50000" begin
    (A,n,l) = load_matrix("data50000/A.txt")
    b = load_vector("data50000/b.txt")
    b3 = solve_gauss_with_choose_main_element(A, b, n, l)
    @testset for x in @view b3[:,:]
        @test x ≈ 1.0
    end
end

@testset "gauss with partial choice 10000" begin
    (A,n,l) = load_matrix("data10000/A.txt")
    b = load_vector("data10000/b.txt")
    b3 = solve_gauss_with_choose_main_element(A, b, n, l)
    @testset for x in @view b3[:,:]
        @test x ≈ 1.0
    end
end

@testset "gauss 50000" begin
    (A,n,l) = load_matrix("data50000/A.txt")
    b = load_vector("data50000/b.txt")
    b3 = solve_gauss(A, b, n, l)
    @testset for x in @view b3[:,:]
        @test x ≈ 1.0
    end
end

@testset "gauss 10000" begin
    (A,n,l) = load_matrix("data10000/A.txt")
    b = load_vector("data10000/b.txt")
    b3 = solve_gauss(A, b, n, l)
    @testset for x in @view b3[:,:]
        @test x ≈ 1.0
    end
end