include("./gauss.jl")
include("./matrixgen.jl")
include("./blocksys.jl")

using .blocksys
using SparseArrays


(A,n,l) = load_matrix("data16/A.txt")
b = load_vector("data16/b.txt")
display(@view A[:,:])
A2, b2 = gauss(A, b, n, l, false)
# print(A2)
display(@view A2[:,:])
