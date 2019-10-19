#author: Kamil Król

using Printf

types = [Float64]

# type - type for which value of function f given in the task should be computed
# x - argument for which value of function will be computed
function f(type, x)
    result = sqrt(x*x + type(1)) - type(1)
    return result
end

# type - type for which value of function g given in the task should be computed
# x - argument for which value of function will be computed
function g(type, x)
    result = ( x * x ) / ( sqrt(x * x + type(1)) + type(1) )
    return result
end

for n = 1:30
    x = Float64(8)^(-n)
    f_ = f(Float64, x)
    g_ = g(Float64, x)
    # println("For x = 8^(-$n) - $(@sprintf("%.30f",x)):    f = $f_;    g = $g_;   Is it equal? $(f_ == g_)")
    println("\$8^{-$n}\$ & $f_ & $g_ & $(f_ == g_) \\\\ \\hline")
end