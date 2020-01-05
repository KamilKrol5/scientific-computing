# author: Kamil Król

using SparseArrays
using LinearAlgebra


"""
Loads a sparse matrix from given file.
Returns A: read matrix, n: matrix size, l: block size
"""
function load_matrix(file_path::String)
    open(file_path) do file
        ln = split(readline(file))
        n = parse(Int64, ln[1])
        l = parse(Int64, ln[2])
        el_num = n*l + 3*(n-l)
        J = Array{Int64}(undef,el_num)
        I = Array{Int64}(undef, el_num)
        V = Array{Float64}(undef, el_num)
        it = 1
        while !eof(file)
            ln = split(readline(file))
            J[it] = parse(Int64, ln[1])
            I[it] = parse(Int64, ln[2])
            V[it] = parse(Float64, ln[3])
            it += 1
        end
        for w=1:n
            for k = 1+Int64(l+l*floor((w-1)/l)): min(Int64(2*l+l * floor((w-1)/l)), n)
                if (k != w+l)
                    append!(J, w)
                    append!(I, k)
                    append!(V, 0.0)
                end
            end
        end
        A = sparse(I, J, V) #transposed
        return (A, n, l)
    end
end

"""
Loads a vector from given file.
Returns b:  read vector
"""
function load_vector(file_path::String)
    open(file_path) do file
        n = parse(Int64, readline(file))
        b = Array{Float64}(undef, n)
        it = 0
        while !eof(file)
            it += 1
            b[it] = parse(Float64, readline(file))
        end
        return b
    end
end

"""
Writes given vector x of size n to file.
Path to the file is specified in argument file_path.
Argument print_relative_error determines whether function should print relative error to the beginning of a file.
"""
function write_vector(file_path::String, x::Array{Float64}, n::Int64, print_relative_error::Bool)
    open(file_path, "w") do file
        if (print_relative_error)
            relative_error = norm(ones(n) - x) / norm(x)
            println(file, relative_error)
            return relative_error
        end
        for i in 1 : n
            println(file, x[i])
        end
    end
end