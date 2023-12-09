include("pieces.jl")

function problem3()
    board = zeros(Int,5,5,1)
    dogs = [yellow,orange,grey,white,blue]
    return board, dogs
end

function problem4()
    board = zeros(Int,6,6,1)
    dogs = [orange,green,teal,white,grey,blue]
    return board, dogs
end


function problem11()
    board = zeros(Int,6,7,1)
    board[:,:,1] = [1 1 1 0 1 1 1;
            1 1 0 0 0 1 1;
            1 0 0 0 0 0 1;
            0 0 0 0 0 0 0;
            0 0 0 0 0 0 0;
            0 0 0 0 0 0 0]
    dogs = [orange,white,yellow,azure,grey,lime]
    return board, dogs
end
function problem13()
    board = zeros(Int,5,11,1)
    dogs = [orange,lime,red,teal,blue,pink,azure,yellow,grey]
    return board, dogs
end

function problem14()
    board = zeros(Int,5,5,5)
    board[:,:,3:5] .= 1
    board[1,:,:] .= 1
    board[:,1,:] .= 1
    dogs = [teal,orange,lime,grey,white,blue]
    goal = (4,4,2)
    return board, dogs, goal
end

function problem27()
    board = zeros(Int,8,7,1)
    board[1,:,:] = [0, 1, 1, 0, 1, 1, 0]
    board[8,:,:] = [0, 1, 1, 0, 1, 1, 0]
    dogs = [teal,pink,blue,grey,orange,green,lime,white]
    return board, dogs
end