# author: Kamil Król

include("blocksys.jl")
include("matrixgen.jl")

using .blocksys
using .matrixgen
using Plots
using Profile

# time comparison
upper_bound = 1000000
step =100000
start = 100000
xs = collect(start:step:upper_bound)
normal_TIME = Array{Float64}(undef, 0)
gauss_TIME = Array{Float64}(undef, 0)
gauss_choice_TIME = Array{Float64}(undef, 0)
lu_TIME = Array{Float64}(undef, 0)
lu_choice_TIME = Array{Float64}(undef, 0)

#getting Julia hotter to get smoother plots
(AA,nn,ll) = load_matrix("data10000/A.txt")
bb = load_vector("data10000/b.txt")
y = AA\bb

for i = start:step:upper_bound
    blockmat(i, 10, 10.0, "matrix/matrix$i")
    (A1,n,l) = load_matrix("matrix/matrix$i")
    (A2,n,l) = load_matrix("matrix/matrix$i")
    (A3,n,l) = load_matrix("matrix/matrix$i")
    (A4,n,l) = load_matrix("matrix/matrix$i")
    (A5,n,l) = load_matrix("matrix/matrix$i")
    b = collect(Float64, 1:i)

    # @profile solve_gauss(A1, b, n, l)
    # Profile.print()

    print("i=$i x=A\\b\n")
    t =@timed begin
        x = A2 \ b
    end
    append!(normal_TIME, [t[2]])

    print("i=$i gauss without choice of main element\n")
    t = @timed begin
        x = solve_gauss(A1, b, n, l)
    end
    append!(gauss_TIME,[ t[2]])

    print("i=$i gauss with choice of main element\n")
    t = @timed begin
        x = solve_gauss_with_choice_main_element(A3, b, n, l)
    end
    append!(gauss_choice_TIME, [t[2]])

    print("i=$i lu\n")
    t = @timed begin
        A4 = lu(A4, b, n, l)
        x = solve_using_lu(A4, b, n, l)
    end
    append!(lu_TIME, [t[2]])

    print("i=$i lu with choice of main element\n")
    t = @timed begin
        (A5, p) = lu_with_choice_of_main_element(A5, b, n, l)
        x = solve_using_lu_with_main_element(A5, p, b, n, l)
    end
    append!(lu_choice_TIME, [t[2]])
end


gr()
# plt = plot(xs,[gauss],lab=["gauss"], lw=3.0)
plt = plot(xs,[normal_TIME, gauss_TIME, gauss_choice_TIME, lu_TIME, lu_choice_TIME],lab=["x=A|b" "gauss" "gauss with choice" "lu" "lu with choice"], lw=3.0, legend=:topleft)
savefig(plt, string("plotwithluTIME.png"))

# lu efficiency
upper_bound = 100000
step =10000
start = 10000
xs = collect(start:step:upper_bound)
first = Array{Float64}(undef, 0)
first_choice = Array{Float64}(undef, 0)
second = Array{Float64}(undef, 0)
second_choice = Array{Float64}(undef, 0)


#getting Julia hotter to get smoother plots
(AA,nn,ll) = load_matrix("data10000/A.txt")
bb = load_vector("data10000/b.txt")
y = AA\bb

for i = start:step:upper_bound
    blockmat(i, 10, 10.0, "matrix/matrix$i")
    (A1,n,l) = load_matrix("matrix/matrix$i")
    (A2,n,l) = load_matrix("matrix/matrix$i")
    b = collect(Float64, 1:i)

    print("i=$i lu first")
    t =@timed begin
        A1 = lu(A1, b, n, l)
        x = solve_using_lu(A1, b, n, l)
    end
    append!(first, [t[2]])

    print("i=$i lu choice first")
    t = @timed begin
        (A2, p2) = lu_with_choice_of_main_element(A2, b, n, l)
        x = solve_using_lu_with_main_element(A2, p2, b, n, l)
    end
    append!(first_choice,[ t[2]])

    print("i=$i lu second\n")
    t = @timed begin
        x = solve_using_lu(A1, b, n, l)
    end
    append!(second, [t[2]])

    print("i=$i lu choice second\n")
    t = @timed begin
        x = solve_using_lu_with_main_element(A2, p2, b, n, l)
    end
    append!(second_choice, [t[2]])
end


gr()
# plt = plot(xs,[gauss],lab=["gauss"], lw=3.0)
plt = plot(xs,[first, first_choice, second, second_choice],lab=["1st LU" "1st LU with choice" "2nd LU" "2nd LU with choice"], lw=3.0, legend=:topleft)
savefig(plt, string("luplot.png"))