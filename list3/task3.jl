# author: Kamil Król

# Function which computes zero of given function (f) using secant method.
# f - given function,
# x0, x1 - initial approximations,
# delta, epsilon - precision of the result,
# maxit - maxiumum number of iterations.
function msiecznych(f, x0::Float64, x1::Float64, delta::Float64, epsilon::Float64, maxit::Int)
    value_in_x0 = f(x0)     # value of function f in point x0
    value_in_x1 = f(x1)     # value of function f in point x1

    for it = 1 : maxit
        if (abs(value_in_x0) > abs(value_in_x1))
            x0, x1 = x1, x0 # swap
            value_in_x0, value_in_x1 = value_in_x1,value_in_x0 # swap
        end

        directional_coefficient = (x1 - x0) / (value_in_x1 - value_in_x0)
        x1 = x0
        value_in_x1 = value_in_x0
        x0 = x0 - (value_in_x0 * directional_coefficient)   # the intersection point of secant and OX is the next approximation
        value_in_x0 = f(x0)                                 # value of function in point x0 (the next approximation computed above)

        if (abs(x1 - x0) < delta || abs(value_in_x0) < epsilon) # end condition
            return x0, value_in_x0, it, 0
        end
    end

    return "error", "error", "error", 1   # the result was not computed in maxit iterations so error
end