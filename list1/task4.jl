#author: Kamil Król

types = [Float64]

function main()
    @time begin
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

        start = nextfloat(Float64(0.0)) #first number in range (0,1)
        end_ = Float64(1.0) #end of the range (0,1) (exclusive)
        number = start; #sought number
    
        while number < end_
            if number * ( 1.0 / number ) != 1.0
                break
            end
            number = nextfloat(number) #taking next number
        end
    
        println("The smallest number x for which x ∗ ( 1.0 / x ) != 1.0 (from range (0,1)) is: $(number) ($(bitstring(number)))")
        println("1.0 / x = $(1.0 / number) and x ∗ ( 1.0 / x ) = $(number * (1.0 / number))")
    end
end


main()
