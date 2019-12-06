# author: Kamil Król

function naturalna(x::AbstractVector{Float64}, fx::AbstractVector{Float64})
    n = length(x) - 1
    x = shiftIndexesBackwardsByOne(x)
    fx = shiftIndexesBackwardsByOne(fx)

    a = shiftIndexesBackwardsByOne(Vector{Float64}(undef, n + 1))

    a[n] = fx[n]
    for k = n - 1 : -1 : 0
        a[k] = fx[k] - a[k+1] * x[k]
        for i = (k + 1) : (n - 1)
            a[i] = a[i] - a[i+1] * x[k]
        end
    end

    return shiftIndexesForwardsByOne(a)
end
