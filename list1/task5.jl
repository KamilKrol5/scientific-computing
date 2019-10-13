#author: Kamil Król

types = [Float64, Float32]

# vector1 and vector2 - vectors for which scalar product should be computed, they must have the same dimension
# type - type of data in vectors
function scalarProductForward(vector1, vector2, type)
    if (size(vector1) != size(vector2))
        throw(DimensionMismatch("Given vectors do not have the same dimension: $vector1, $vector2."))
    elseif (size(vector1) == 0)
        throw(ArgumentError("Dimension cannot be equal 0."))
    end
    
    scalarProduct = type(0.0) #variable for product initialized with 0.0
    for i = 1:size(vector1, 1)
        scalarProduct = scalarProduct + type(vector1[i]) * type(vector2[i])
    end

    # alternative version of loop using zip
    # for (a, b) in zip(vector1, vector2)
    #     scalarProduct = scalarProduct + type(a) * type(b)
    # end

    return scalarProduct
end

# vector1 and vector2 - vectors for which scalar product should be computed, they must have the same dimension
# type - type of data in vectors
function scalarProductBackward(vector1, vector2, type)
    if (size(vector1) != size(vector2))
        throw(DimensionMismatch("Given vectors do not have the same dimension: $vector1, $vector2."))
    elseif (size(vector1) == 0)
        throw(ArgumentError("Dimension cannot be equal 0."))
    end
    
    scalarProduct = type(0.0) #variable for product initialized with 0.0
    for i = size(vector1, 1):-1:1 #step in the middle
        scalarProduct = scalarProduct + type(vector1[i]) * type(vector2[i])
    end

    return scalarProduct
end

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



x = [2.718281828, -3.141592654, 1.414213562, 0.5772156649, 0.3010299957]
y = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]

for type in types
    println("Type: $type")
    println("Scalar Product (Forward) = ",scalarProductForwardFunctional(x, y, type))
    println("Scalar Product (Backward) = ",scalarProductBackwardFunctional(x, y, type))
    println("Scalar Product (Descending) = ",scalarProductDescending(x, y, type))
    println("Scalar Product (Ascending) = ",scalarProductAscending(x, y, type))
    println()
end

println("Real value: −1.00657107e−11")