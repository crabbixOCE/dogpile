using Random
using DSP  # Digital Signal Processing package for convolution
using Combinatorics
using LinearAlgebra
include("boards.jl")

function argminmax_ones(arr)
    min_coords = nothing
    max_coords = nothing
    min_sum = Inf
    max_sum = -Inf

    for (idx, val) in pairs(eachindex(arr))
        if val == 1
            coord_sum = sum(idx)
            if coord_sum < min_sum
                min_sum = coord_sum
                min_coords = idx
            end
            if coord_sum > max_sum
                max_sum = coord_sum
                max_coords = idx
            end
        end
    end

    return  max_coords - min_coords
end

function compare(board, dog)
    valids = []
    x = size(board)[1]
    y = size(board)[2]
    z = size(board)[3]
    everything = reduce(vcat,generate_all_translations.(dog.rots,Ref(x),Ref(y),Ref(z)))
    everything = unique(everything)
    for e in everything
        res = board .+ e
        if any(res .> 1)
            continue
        end
        push!(valids, (e,res))
    end
    return valids
end

function get_symbol_mat(dogshape, symbol)
    symbol_mat = [x == 1 ? symbol : "" for x in dogshape]
    # Base.print_array(stdout, symbol_mat)
    # println("\n")
    return symbol_mat
end


# dogwise eliminate anything that overlaps with the resultant

function solve_puzzle_recursive(board, dogs; shapes=[])
    checksum = sum(board) + sum([sum(dog.shape) for dog in dogs])
    if checksum != size(board)[1]*size(board)[2]*size(board)[3]
        return "Check dogs and board - mismatch"
    end
    if isempty(dogs)
        if all(board .== 1)
            res = fill(" ",size(board))
            for (shape, dog) in shapes
                res .*= get_symbol_mat(shape, dog.symbol)
            end
            Base.print_array(stdout, res)
            return ""
        else
            return nothing
        end
    end
    dog = first(dogs)
    remaining_dogs = dogs[2:end]
    possible = compare(board, dog)
    count = 0
    possible = reverse(possible)
    for p in possible
        count += 1
        new_shape = p[1]
        new_board = p[2]
        new_shapes = copy(shapes)
        push!(new_shapes, (new_shape, dog))
        result = solve_puzzle_recursive(new_board, remaining_dogs, shapes=new_shapes)
        if !(result === nothing)
            return result
        end
    end
    return nothing
end

board, dogs = problem27()
@time solve_puzzle_recursive(board,dogs)





