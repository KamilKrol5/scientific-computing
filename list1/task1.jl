#author: Kamil Król

# --- Comment ---
# The distance between two adjacent representable floating-point numbers is not constant, 
# but is smaller for smaller values and larger for larger values.

FLT_EPSILON = 1.19209290e-07 # float
DBL_EPSILON = 2.2204460492503131e-16 # double
types = [Float64, Float32, Float16]

# type - type for which macheps should be computed
function determineMachEps(type)
    one = type(1.0)
    macheps = type(1.0) #macheps value initializated with 1.0
    while one + macheps / 2 != one
        macheps = macheps / 2
    end
    return macheps
end

println("Machine Epsilon for every type:")
for type in types
    println("$type:      Computed macheps = $(determineMachEps(type)); eps($type) = $(eps(type))")
end

# type - type for which eta should be computed
function determineEta(type)
    zero = type(0.0)
    eta = type(1.0) #eta value initializated with 1.0
    while eta / 2 != zero
        eta = eta / 2
    end
    return eta
end

println()
println("Eta for every type:")
for type in types
    println("$type:      Computed eta = $(determineEta(type)); nextfloat($type(0.0)) = $(nextfloat(type(0.0)))")
end

# type - type for which MAX should be computed
function determineMax(type)
    max = type(2.0 - eps(type)) # or 1.0 eps/2 or 0.5 - eps/4 ...
        #czemu nie 1 - eps?
        #max value initializated with 1.0 but mantissa is filled with ones
    while !isinf(max * 2)
        max *= 2
    end
    return max
end

println()
println("MAX every type:")
for type in types
    println("$type:      Computed MAX = $(determineMax(type)); floatmax($type) = $(floatmax(type))")
end