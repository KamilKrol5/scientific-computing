# author: Kamil Król

function warNewton(x::AbstractVector{Float64}, fx::AbstractVector{Float64}, t::Float64)
    n = length(fx) - 1
    x = shiftIndexesBackwardsByOne(x)
    fx = shiftIndexesBackwardsByOne(fx)
    nt = fx[n]

    for i = n - 1 : -1 : 0
        nt = fx[i] + (t - x[i]) * nt
    end

    return nt
end
