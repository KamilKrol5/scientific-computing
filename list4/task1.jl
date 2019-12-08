# author: Kamil Król

function ilorazyRoznicowe(x::AbstractVector{Float64}, f::AbstractVector{Float64})
    n = length(f) - 1
    fx = shiftIndexesBackwardsByOne(copy(f))
    x = shiftIndexesBackwardsByOne(x)

    for i = 1 : n
        for k = n : -1 : i
            fx[k] = (fx[k] - fx[k - 1]) / (x[k] - x[k - i])
        end
    end

    return shiftIndexesForwardsByOne(fx)
end
