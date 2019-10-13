#author: Kamil Król

types = [Float64]

#Range [1,2] delta=2^(-52)
delta = Float64(2) ^ (-52) #delta - step
beginning = Float64(1.0) #beginning of the range [1,2]
println("Range: [1,2], Delta = 2^(-52)")
for i = 1:9
    #(1 + i * delta) reprezentation
    println("1.0 + $i * delta = $(bitstring(beginning + i * delta))")
end
    
#Range [0.5,1] delta=2^(-53)
delta = Float64(2) ^ (-53) #delta - step
beginning = Float64(0.5) #beginning of the range [0.5,1]
println("Range: [0.5,1], Delta = 2^(-53)")
for i = 1:9
    #(1 + i * delta) reprezentation
    println("1.0 + $i * delta = $(bitstring(beginning + i * delta))")
end

#Range [2,4] delta=2^(-51)
delta = Float64(2) ^ (-51) #delta - step
beginning = Float64(2.0) #beginning of the range [2,4]
println("Range: [2,4], Delta = 2^(-51)")
for i = 1:9
    #(1 + i * delta) reprezentation
    println("1.0 + $i * delta = $(bitstring(beginning + i * delta))")
end

#The closer to 0 the step is smaller (here: 2^-53), the farther from 0 the step is bigger (here: 2^-51)