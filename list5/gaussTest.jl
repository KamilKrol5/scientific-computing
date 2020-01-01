include("./gauss.jl")
include("./matrixgen.jl")
include("./blocksys.jl")

using .blocksys
using SparseArrays


(A,n,l) = load_matrix("data16/A.txt")
b = load_vector("data16/b.txt")
display(@view A[:,:])
# A2, b2 = gauss(A, b, n, l, false)
# print(A2)
# display(@view A2[:,:])
b3 = solve_gauss_with_choose_main_element(A, b, n, l)
display(@view b3[:,:])
