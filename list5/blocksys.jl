# author: Kamil Król

module blocksys

include("io_utils.jl")
include("gauss.jl")
include("lu.jl")

export write_vector, 
load_vector, 
load_matrix,
gauss, 
gauss_with_choice_main_element, 
lu, 
lu_with_choice_of_main_element, 
solve_gauss, 
solve_gauss_with_choice_main_element, 
solve_using_lu_with_main_element, 
solve_using_lu
end