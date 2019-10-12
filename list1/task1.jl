#author: Kamil Król

# --- Comment ---
# The distance between two adjacent representable floating-point numbers is not constant, 
# but is smaller for smaller values and larger for larger values.

FLT_EPSILON = 1.19209290e-07 # float
DBL_EPSILON = 2.2204460492503131e-16 # double
types = [Float64, Float32, Float16]

function determineMachEps(type)
    one = type(1.0)
    macheps = type(1.0)
    while one + macheps / 2 != one
        macheps = macheps / 2
    end
    return macheps
end

println("Machine Epsilon for every type:")
for type in types
    println("Computed macheps = $(determineMachEps(type)); eps($type) = $(eps(type))")
end