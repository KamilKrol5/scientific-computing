# author: Kamil Król

include("functions.jl")
using .functions

f(x) = MathConstants.e ^ x - 3.0 * x
delta = 10.0 ^ (-4.0)
epsilon = 10.0 ^ (-4.0)

range1 = (0.0, 1.0)
range2 = (1.0, 2.0)

root1, value1, iterations1, error1 = mbisekcji(f, 0.0, 1.0, delta, epsilon)
println("x1: $root1, value: $value1, number of iterations: $iterations1, error: $error1")
# println("$root1 & $value1 & $iterations1 & $error \\\\ \\hline")
# println("$root1 & $value1 & $iterations1 \\\\ \\hline")

root2, value2, iterations2, error2 = mbisekcji(f, 1.0, 2.0, delta, epsilon)
println("x2: $root2, value: $value2, number of iterations: $iterations2, error: $error2")
# println("$root2 & $value2 & $iterations2 & $error2 \\\\ \\hline")
# println("$root2 & $value2 & $iterations2 \\\\ \\hline")