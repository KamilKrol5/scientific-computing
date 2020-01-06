# author: Kamil Król

include("gauss.jl")
using SparseArrays

"""
Computes LU decomposition for given matrix using Gauss elimination.
Given matrix is destroyed during this process.
A: matrix (SparseMatrixCSC{Float64, Int64})
b: right side vector (Vector{Float64})
n: size of matrix A (Int64)
l: size of submatrices of A (Int64)
Returns:
A: given matrix after elimination (SparseMatrixCSC{Float64, Int64}),
b: given vector of right sides after elimination (Vector{Float64}).
"""
function lu(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64) 
    (AA, bb) = gauss(A, b, n, l, true)
    return AA
end

"""
Performs LU decomposition for given matrix using Gauss elimination with choice of main element. 
Given matrix is destroyed during this process.
A: matrix (SparseMatrixCSC{Float64, Int64}),
b: right side vector (Vector{Float64}),
n: size of matrix A (Int64),
l: size of submatrices of A (Int64).
Returns:
A: given matrix after elimination, is SparseMatrixCSC{Float64, Int64};
permutation - permutation vector, is Vector{Float64};
b: given vector of right sides after elimination, is Vector{Float64}
"""
function lu_with_choice_of_main_element(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64) 
     (AA, pp, bb) = gauss_with_choice_main_element(A, b, n, l, true)
     return AA, pp
end


"""
Solves Ax=b equation using LU decomposition made with the Gauss elimination.
A: matrix (SparseMatrixCSC{Float64, Int64})
b: right sides vector (Vector{Float64})
n: size of matrix A (Int64)
l: size of submatrices of A (Int64)
Returns:
x: vector with solutions (Vector{Float64})
"""
function solve_using_lu(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64) 
    new_b = Array{Float64}(undef, n)
	for i in 1 : n
		row_sum = 0.0
		start_column = max(Int(l * floor((i-1) / l) - 1), 1)
		for j in start_column:i-1
			row_sum += A[j, i] * new_b[j]
		end
		new_b[i] = b[i] - row_sum
	end

	x = Array{Float64}(undef, n)
	for i in n :-1:1
		row_sum = 0.0
		last_col = min(n, i + l)
		for j in i + 1 : last_col
			row_sum += A[j, i] * x[j]
		end
		x[i] = (new_b[i] - row_sum) / A[i, i]
	end
	return x

end


"""
Solves Ax=b equation using LU decomposition made with the Gauss elimination with choice of main element.
A: matrix (SparseMatrixCSC{Float64, Int64})
permutation: permutation vector (Vector{Float64})
b: right sides vector (Vector{Float64})
n: size of matrix A (Int64)
l: size of submatrices of A (Int64)
Returns:
x: vector with solutions (Vector{Float64})
"""
function solve_using_lu_with_main_element(A::SparseMatrixCSC{Float64, Int64}, permutation::Vector{Int64}, b::Vector{Float64}, n::Int64, l::Int64) 
    new_b = Vector{Float64}(undef, n)
    for i = 1:n
        row_sum = 0.0
        for j = max(l * Int(floor((permutation[i]-1) / l)) - 1, 1):i - 1
            row_sum += A[j, permutation[i]] * new_b[j]
        end
        new_b[i] = b[permutation[i]] - row_sum
    end
    x = Vector{Float64}(undef, n)
    for i = n:-1:1
        row_sum = 0.0
        for column = i + 1:min(i + 2 * l, n)
            row_sum += A[column, permutation[i]] * x[column]
        end
        x[i] = (new_b[i] -  row_sum) / A[i, permutation[i]]
    end
    return x
end
