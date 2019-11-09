#author: Kamil Król

include("hilb.jl")
include("matcond.jl")

using LinearAlgebra

nValues = [5, 10, 20]
cValues = [1., 10., 10^3, 10^7, 10^12, 10^16]

function gaussElimination(A, b)
    return A \ b
end

function computeUsingInversion(A, b)
    return inv(A) * b
end

function relativeError(realValue, computedValue)
    return norm(realValue - computedValue) / norm(realValue)
end

function hilbExperiment()
    for n in 2:15
        x = [1 for i in 1:n]
        A = hilb(n)
        b = A * x

        gaussResult = gaussElimination(A, b)
        invResult = computeUsingInversion(A, b)

        gaussError = relativeError(x, gaussResult)
        invError = relativeError(x, invResult)

        # println("HILB size = $n x $n, rank = $(rank(A)), cond = $(cond(A)), gauss error = $gaussError, inversion error = $invError")
        println("H $n x $n & $(rank(A)) & $(cond(A)) & $gaussError & $invError \\\\ \\hline")
    end
end

function randomMatrixExperiment()
    for n in nValues
        x = [1 for i in 1:n]

        for c in cValues
            A = matcond(n, c)
            b = A * x

            gaussResult = gaussElimination(A, b)
            invResult = computeUsingInversion(A, b)

            gaussError = relativeError(x, gaussResult)
            invError = relativeError(x, invResult)

            # println("size = $n x $n, rank = $(rank(A)), cond = $(cond(A)), gauss error = $gaussError, inversion error = $invError")
            println("$n x $n & $(rank(A)) & \$\\approx$(c)\$ & $gaussError & $invError \\\\ \\hline")
        end
    end
end

hilbExperiment()
randomMatrixExperiment()
