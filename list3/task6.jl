# author: Kamil Król

include("functions.jl")
using .functions

delta = 1e-5
epsilon = 1e-5
max_iterations = 40

f1(x) = MathConstants.e^(1.0 - x) - 1.0
f2(x) = x * MathConstants.e^(-x)

f1′(x) = -MathConstants.e^(1.0 - x)
f2′(x) = MathConstants.e^-x - x * MathConstants.e^-x

# functions = [(f1, f1′,"f1:"), (f2, f2′,"f2:")]

println("f1:")
println("Bisection method:")
root, value, iterations, error = mbisekcji(f1, 0.4, 2.4, delta, epsilon)
println("root: $root, value: $value, number of iterations: $iterations, error: $error")
# println("$root & $value & $iterations \\\\ \\hline")

println("Newton method:")
root, value, iterations, error = mstycznych(f1, f1′, 1.5, delta, epsilon, max_iterations)
println("root: $root, value: $value, number of iterations: $iterations, error: $error")
# println("$root & $value & $iterations \\\\ \\hline")

println("Secant method:")
root, value, iterations, error = msiecznych(f1, 1.5, 2.0, delta, epsilon, max_iterations)
println("root: $root, value: $value, number of iterations: $iterations, error: $error")
# println("$root & $value & $iterations \\\\ \\hline")
println("---------------------------------------------")

println("f2:")
println("Bisection method:")
root, value, iterations, error = mbisekcji(f2, -1.0, 2.0, delta, epsilon)
println("root: $root, value: $value, number of iterations: $iterations, error: $error")
# println("$root & $value & $iterations \\\\ \\hline")

println("Newton method:")
root, value, iterations, error = mstycznych(f2, f2′, -2.0, delta, epsilon, max_iterations)
println("root: $root, value: $value, number of iterations: $iterations, error: $error")
# println("$root & $value & $iterations \\\\ \\hline")

println("Secant method:")
root, value, iterations, error = msiecznych(f2, -1.0, -0.5, delta, epsilon, max_iterations)
println("root: $root, value: $value, number of iterations: $iterations, error: $error")
# println("$root & $value & $iterations \\\\ \\hline")
println("---------------------------------------------")

println("other tests:")
println("Newton method (f2) x0=5.0:")
root, value, iterations, error = mstycznych(f2, f2′, 5.0, delta, epsilon, max_iterations)
println("root: $root, value: $value, number of iterations: $iterations, error: $error")
# println("$root & $value & $iterations \\\\ \\hline")

println("Newton method (f2) x0=1.0:")
root, value, iterations, error = mstycznych(f2, f2′, 1.0, delta, epsilon, max_iterations)
println("root: $root, value: $value, number of iterations: $iterations, error: $error")
# println("$root & $value & $iterations \\\\ \\hline")
