# author: Kamil Król

using SparseArrays

"""
Performs gaussian elimination on given matrix A (A has the form which is specified in the task description). 
If write_matrix_L is set to true, function performs LU decompsition using gaussian elimiantion.
A: matrix which is SparseMatrixCSC{Float64, Int64}
b: vector with values which is Vector{Float64}
n: size of matrix A (Int64)
l: size of submatrices of A (Int64)
write_matrix_L: detrminates if function should perform LU decomposition.
Returns:
A, b: A: given matrix after elimination (SparseMatrixCSC{Float64, Int64}),
      b: given vector of right sides after elimination (Vector{Float64}).
"""
function gauss(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64, write_matrix_L::Bool)
    # Iteration over columns
    for column = 1:n - 1
        # The last element to be eliminated in current column
        to_eliminate = convert(Int64, min(l + l * floor((column+1) / l), n))

        # Iteration over elements (rows) to be eliminated
        for elem = column + 1:to_eliminate

            # multiplier = element to be eliminated / current element on diagonal (main element)
            multiplier = A[column, elem] / A[column, column]

            if write_matrix_L
                # If LU decomposition is performed, then multiplier is written here
                A[column, elem] = multiplier
            else
                A[column, elem] = Float64(0.0)
            end

            # Iteration over columns (operating on 2 rows)
            for j = column + 1:min(column + l, n)
                A[j, elem] -= multiplier * A[j, column] # performing subtraction of rows R_elem - mult * R_k 
            end


            # If it's LU, then transforming b vector is unnecessary
            if !write_matrix_L
                b[elem] -= multiplier * b[column]
            end
        end
    end
    return A, b
end

"""
Solves equation Ax=b using gaussian elimination method.
A: matrix (SparseMatrixCSC{Float64, Int64})
b: vector with values (Vector{Float64})
n: size of matrix A (Int64)
l: size of blocks in matrix A (Int64)
Returns:
x: vector with solutions (Vector{Float64})
"""
function solve_gauss(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64)
    res = gauss(A, b, n, l, false)
    A2 = res[1]
    b2 = res[2]
    # Vector being a solution to the equation
    x = Vector{Float64}(n)

    # Iteration over rows
    for i = n:-1:1
        sum_in_row = 0.0
        # Iteration over columns
        for j = i + 1:min(n, i + l)
            sum_in_row += A2[j, i] * x[j] # sum which will be subtracted from b side
        end
        x[i] = (b2[i] - sum_in_row) / A2[i, i] # ax = b - sum
    end
    return x
end