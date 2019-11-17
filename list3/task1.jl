# author: Kamil Król

# Function which computes zero of given function (f) using bisection method.
# f - given function,
# a, b - left and right bound of the range,
# delta, epsilon - precision of the result.
function mbisekcji(f, a::Float64, b::Float64, delta::Float64, epsilon::Float64)
    value_in_left_bound = f(a)
    value_in_right_bound = f(b)
    range_length = b - a   # the length of range [a,b]
    iterations = 0
    if (sign(value_in_left_bound) == sign(value_in_right_bound)) # function does not change its sign in range [a,b]
        return "error", "error", "error", 1
    end

    while range_length > epsilon
        iterations += 1
        range_length = range_length / 2
        middle_point_of_range = a + range_length
        value_in_middle_point = f(middle_point_of_range)    # value of function of in the middle point of range [a,b]

        if (abs(range_length) < delta || abs(value_in_middle_point) < epsilon) # end condition
            return middle_point_of_range, value_in_middle_point, iterations, 0
        end

        if (sign(value_in_middle_point) != sign(value_in_left_bound))
            b = middle_point_of_range
            value_in_right_bound = value_in_middle_point
        else
            a = middle_point_of_range
            value_in_left_bound = value_in_middle_point
        end
    end
end