#author: Kamil Król

types = [Float64, Float32]

# Help function for computing scalar product. It multiplies corresponding coordinates and returns an array of these products
# x and y - vectors for which corresponding coordinates should be multipied, they must have the same dimension
# type - type of data in vectors
multiplyCorrespondingCoordinates(x, y, type) = map(*, map(type, x), map(type, y))

# x and y - vectors for which scalar product should be computed, they must have the same dimension
# type - type of data in vectors
scalarProductForwardFunctional(x, y, type) = sum(multiplyCorrespondingCoordinates(x, y, type))

# x and y - vectors for which scalar product should be computed, they must have the same dimension
# type - type of data in vectors
scalarProductBackwardFunctional(x, y, type) = sum(reverse(multiplyCorrespondingCoordinates(x, y, type)))

# x and y - vectors for which scalar product should be computed, they must have the same dimension
# type - type of data in vectors
scalarProductDescending(x, y, type) = sum( sort(filter(u -> u<0 , multiplyCorrespondingCoordinates(x, y, type)))) +
                                      sum( sort(filter(u -> u>0 , multiplyCorrespondingCoordinates(x, y, type)), rev=true))

# x and y - vectors for which scalar product should be computed, they must have the same dimension
# type - type of data in vectors
scalarProductAscending(x, y, type) = sum( sort(filter(u -> u>0 , multiplyCorrespondingCoordinates(x, y, type)))) +
                                     sum( sort(filter(u -> u<0 , multiplyCorrespondingCoordinates(x, y, type)), rev=true))



x1 = [2.718281828, -3.141592654, 1.414213562, 0.5772156649, 0.3010299957]
y1 = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]

x2 = [2.718281828, -3.141592654, 1.414213562, 0.577215664, 0.301029995]
y2 = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]

realValue = -1.00657107000000e-11

function runExperiment(x, y)
    for type in types
        forward = scalarProductForwardFunctional(x, y, type)
        backward = scalarProductBackwardFunctional(x, y, type)
        descending = scalarProductDescending(x, y, type)
        ascedning = scalarProductAscending(x, y, type)
        absErrForward = abs(realValue - forward)
        absErrBackward = abs(realValue - backward)
        absErrDesc = abs(realValue - descending)
        absErrAsc = abs(realValue - ascedning)
        println("Type: $type")
        println("Scalar Product (Forward) = ",forward, " absolute error = $absErrForward, relative error = $(abs(absErrForward/realValue))")
        println("Scalar Product (Backward) = ",backward, " absolute error = $absErrBackward, relative error = $(abs(absErrBackward/realValue))")
        println("Scalar Product (Descending) = ",descending, " absolute error = $absErrDesc, relative error = $(abs(absErrDesc/realValue))")
        println("Scalar Product (Ascending) = ",ascedning, " absolute error = $absErrAsc, relative error = $(abs(absErrAsc/realValue))")
        # println("Forward & $forward & $absErrForward & $(abs(absErrForward/realValue)) \\\\ \\hline")
        # println("Backward & $backward & $absErrBackward & $(abs(absErrBackward/realValue)) \\\\ \\hline")
        # println("Descending & $descending & $absErrDesc & $(abs(absErrDesc/realValue)) \\\\ \\hline")
        # println("Ascending & $ascedning & $absErrAsc & $(abs(absErrAsc/realValue)) \\\\ \\hline")
        println()
    end
end

runExperiment(x1, y1)
runExperiment(x2, y2)

println("Real value: −1.00657107e−11")