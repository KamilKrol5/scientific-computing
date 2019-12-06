module interpolationLibrary

export shiftIndexesBackwardsByOne, shiftIndexesForwardsByOne, ilorazyRoznicowe, naturalna, rysujNnfx
using OffsetArrays

shiftIndexesBackwardsByOne(x) = OffsetArray(x, 0:length(x)-1)
shiftIndexesForwardsByOne(x) = parent(x)

include("task1.jl")
include("task2.jl")
include("task3.jl")
include("task4.jl")

end
