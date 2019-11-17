# author: Kamil Król

# Function which computes zero of given function (f) using Newton method.
# f - given function,
# f_prim - derivative of given function f,
# x0 - initial approximation,
# delta, epsilon - precision of the result,
# maxit - maxiumum number of iterations.
function mstycznych(f, f_prim, x0::Float64, delta::Float64, epsilon::Float64, maxit::Int)
    value_in_x0 = f(x0)

    if(abs(value_in_x0) < epsilon)    # value of function f in x0 is close enough to 0
        return x0, value_in_x0, 0, 0
    end

    if (abs(f_prim(x0)) < epsilon)   # value of derivative of function f in point x0 is close to 0
        return "error", "error", "error", 2
    end

    for iteration = 1:maxit
        x1 = x0 - (value_in_x0/f_prim(x0))  # the next approximation of the root
        value_in_x0 = f(x1)                 # value of function f in the next approximation of the root

        if(abs(x1 - x0) < delta || abs(value_in_x0) < epsilon)  # end condition
            return x1, value_in_x0, iteration, 0
        end
        x0 = x1                             # updating the approximation
    end

    return "error", "error", "error", 1   # the result was not computed in maxit iterations so error
end