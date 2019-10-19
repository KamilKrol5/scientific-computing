#author: Kamil Król

types = [Float64]

function main()
    start = nextfloat(Float64(1.0)) #first number in range (1,2)
    end_ = Float64(2.0) #end of the range (1,2) (exclusive)
    number = start; #sought number

    while number < end_
        if number * ( 1.0 / number ) != 1.0
            break
        end
        number = nextfloat(number) #taking next number
    end

    println("The smallest number x for which x ∗ ( 1.0 / x ) != 1.0 is: $(number) ($(bitstring(number)))")
    println("nextfloat(1.0) = $(nextfloat(1.0))")
end

main()
