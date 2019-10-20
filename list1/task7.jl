#author: Kamil Król

using Printf

types = [Float64]

# Computes value of function: sin(x) + cos(3x)
# type - type for which value of function should be computed
function analysedFunction(x, type=Float64)
    return sin(type(x)) + cos(3*type(x))
    
end

# Computes approximate value of derivative of function: sin(x) + cos(3x) according to formula given in the task
# h - argument corresponding to h in the formula
# x - point in which the derivative value should be computed
# type - type for which value of derivative should be computed
function approximationDerivative(h, x, type=Float64)
    return (analysedFunction(x + h, type) - analysedFunction(x)) / h
end


# Computes derivative of function: sin(x) + cos(3x) according to mathematical formula
# x - point in which the derivative value should be computed
# type - type for which value of derivative should be computed
function derivative(x, type=Float64)
    # derivative for sin(x) + cos(3x) is: cos(x) - 3 sin(3 x)
    return cos(type(x)) - 3.0 * sin(3 * type(x))
end

function main()
    fromMathFormulaResult = derivative(1.0)
    println("From mathematical formula: f'(1.0) = $fromMathFormulaResult")
    for n = 0:58
        h = 2.0 ^ (-n)
        approxFormulaResult = approximationDerivative(h, 1.0)
        println("n = $n; val = $approxFormulaResult; Error: $(abs(fromMathFormulaResult - approxFormulaResult)); h + 1 = $(1.0 + h)")
        # println("$n & $approxFormulaResult & $(abs(fromMathFormulaResult - approxFormulaResult)) & $(1.0 + h)\\\\ \\hline")
    end
end

main()