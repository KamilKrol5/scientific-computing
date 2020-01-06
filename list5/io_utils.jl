# author: Kamil Król

using SparseArrays
using LinearAlgebra


"""
Loads a sparse matrix from given file.
Returns A: read matrix, n: matrix size, l: block size
"""
function load_matrix(file_path::String)
    open(file_path) do file
        line = split(readline(file))
        n = parse(Int64, line[1])
        l = parse(Int64, line[2])
        el_num = n*l + 3*(n-l)
        I = Array{Int64}(undef, el_num)
        J = Array{Int64}(undef,el_num)
        V = Array{Float64}(undef, el_num)
        counter = 1
        while !eof(file)
            line = split(readline(file))
            I[counter] = parse(Int64, line[2])
            J[counter] = parse(Int64, line[1])
            V[counter] = parse(Float64, line[3])
            counter += 1
        end
        for w=1:n
            for k = 1+Int64(l+l*floor((w-1)/l)): min(Int64(2*l+l * floor((w-1)/l)), n)
                if (k != w+l)
                    append!(I, k)
                    append!(J, w)
                    append!(V, 0.0)
                end
            end
        end
        A = sparse(I, J, V) # is transposed
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
        counter = 0
        while !eof(file)
            counter += 1
            b[counter] = parse(Float64, readline(file))
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