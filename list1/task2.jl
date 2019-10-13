#author: Kamil Król

types = [Float64, Float32, Float16]

# type - type for which expression given in the task (3(4/3−1)−1) should be computed
function computeExpression(type)
    result = type(3.0) * ( type(4.0) / type(3.0) - type(1.0) ) - type(1.0)
    return result
end


println("Machine Epsilon for every type:")
for type in types
    println("$type:      Computed macheps [3(4/3−1)−1] = $(computeExpression(type)); eps($type) = $(eps(type))")
end