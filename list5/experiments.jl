# author: Kamil Król

include("blocksys.jl")
include("matrixgen.jl")

using .blocksys
using .matrixgen


for i = 10000:10000:40000
    blockmat(i, 10, 10.0, "matrix/matrix$i")
    (A1,n,l) = load_matrix("matrix/matrix$i")
    (A2,n,l) = load_matrix("matrix/matrix$i")
    (A3,n,l) = load_matrix("matrix/matrix$i")
    b = collect(Float64, 1:i)
    
    print("i=$i x=A\\b                                ")
    @time begin
        x = A2 \ b
    end

    print("i=$i gauss without choice of main element  ")
    @time begin
        x = solve_gauss(A1, b, n, l)
        
    end

    print("i=$i gauss with choice of main element     ")
    @time begin
        x = solve_gauss_with_choice_main_element(A3, b, n, l)
        
    end
end
