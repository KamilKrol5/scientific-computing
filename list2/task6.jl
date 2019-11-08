#author: Kamil Król

function recursion(x_n, c)
    x_nplusone = x_n * x_n + c
    return x_nplusone
end

number_of_iterations = 40

tests = [(-2,1), 
        (-2,2),
        (-2,1.99999999999999),
        (-1, 1),
        (-1, -1),
        (-1, 0.75),
        (-1, 0.25)]

for test in tests
    c = test[1]
    x_0 = test[2]
    result = x_0
    # println("Test: c = $c, x_0 = $x_0")
    for i = 1:number_of_iterations
        result = recursion(result, c)
        # println("c = $c, x_0 = $x_0, x_$i = $result")
        println("$c & $x_0 & $result &")
    end
    println()
end