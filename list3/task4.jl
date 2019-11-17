# author: Kamil Król

include("functions.jl")
using .functions

delta = 0.5 * 10^(-5)
epsilon = 0.5 * 10^(-5)

f(x) = sin(x) - (0.5 * x) ^ 2.0
f′(x) = cos(x) - 0.5 * x

range = (1.5, 2.0)
max_iterations = 40


println("Bisection method:")
root, value, iterations, error = mbisekcji(f, 1.5, 2.0, delta, epsilon)
println("root: $root, value: $value, number of iterations: $iterations, error: $error")
# println("$root & $value & $iterations & $error \\\\ \\hline")
# println("$root & $value & $iterations \\\\ \\hline")

println("Newton method:")
root, value, iterations, error = mstycznych(f, f′, 1.5, delta, epsilon, max_iterations)
println("root: $root, value: $value, number of iterations: $iterations, error: $error")
# println("$root & $value & $iterations & $error \\\\ \\hline")
# println("$root & $value & $iterations \\\\ \\hline")

println("Secant method:")
root, value, iterations, error = msiecznych(f, 1.0, 2.0, delta, epsilon, max_iterations)
println("root: $root, value: $value, number of iterations: $iterations, error: $error")
# println("$root & $value & $iterations & $error \\\\ \\hline")
# println("$root & $value & $iterations \\\\ \\hline")


