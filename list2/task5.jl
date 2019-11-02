#author: Kamil Król

function population(r, p_n, type)
    p_nplus1 = p_n + r * p_n * (type(1.0) - p_n)
    return p_nplus1
end

function test1(type)
    p_0 = type(0.01)
    r = type(3)
    number_of_iterations = 40
    population_result = p_0
    for i = 1:number_of_iterations
        population_result = population(r, population_result, type)
    end
    return population_result
end

function test2(type)
    p_0 = type(0.01)
    r = type(3)
    number_of_iterations_part1 = 10
    number_of_iterations_part2 = 40
    population_result = p_0
    for i = 1:number_of_iterations_part1
        population_result = population(r, population_result, type)
    end

    # manipulating data
    population_result = trunc(population_result, digits=3)
    println("Truncated value: ", population_result)

    for i = (number_of_iterations_part1+1):number_of_iterations_part2
        population_result = population(r, population_result, type)
    end

    return population_result
end

function test3()
    println("Test 3")
    types = [Float32, Float64]
    for type in types
        result = test1(type)
        println("For type $type result is: $result")
        # println("$type & $result \\\\ \\hline")
    end
end

println("Test1 (Float32)")
test1_ = test1(Float32)
println("Result = $test1_")

println("Test2 (Float32)")
test2_ = test2(Float32)
println("Result = $test2_")

test3()