using Memoize

function threedify(mat)
    z3d = zeros(Int,5,5,4)
    return cat(mat,z3d,dims=3)
end

function xrot(mat)
    rows,cols = size(mat)
    rotated_matrix = zeros(Int,rows,cols)
    for i in 1:rows
        for j in 1:cols
            rotated_matrix[j, rows+1-i] = mat[i, j]
        end
    end
    return rotated_matrix
end

function isin(list, item)
    for i in list
        if all(i .== item)
            return true
        end
    end
    return false
end



function d1(mat)
    fresh = copy(mat)
    rows = size(mat)[1]
    oldrow = fresh[rows,:,:]
    if any(oldrow .== 1)
        return fresh
    end
    fresh[2:rows,:,:] = fresh[1:rows-1,:,:]
    fresh[1,:,:] = oldrow
    return fresh
end

function u1(mat)
    fresh = copy(mat)
    rows = size(mat)[1]
    oldrow = fresh[1,:,:]
    if any(oldrow .== 1)
        return fresh
    end
    fresh[1:rows-1,:,:] = fresh[2:rows,:,:]
    fresh[rows,:,:] = oldrow
    return fresh
end



function l1(mat)
    fresh = copy(mat)
    cols = size(mat)[2]
    oldcol = fresh[:,1,:]
    if any(oldcol .== 1)
        return fresh
    end
    fresh[:,1:cols-1,:] = fresh[:,2:cols,:]
    fresh[:,cols,:] = oldcol
    return fresh
end




function repeat(f, x, n)
    for i in 1:n
        x = f(x)
    end
    return x
end

function r1(mat)
    fresh = copy(mat)
    cols = size(mat)[2]
    oldcol = fresh[:,cols,:]
    if any(oldcol .== 1)
        return fresh
    end
    fresh[:,2:cols,:] = fresh[:,1:cols-1,:]
    fresh[:,1,:] = oldcol
    return fresh
end

@memoize function generate_all_translations(mat,x,y,z)
    add_rows = x - size(mat)[1]
    mat = cat(mat,zeros(Int,add_rows,size(mat)[2]),dims=1)
    add_cols = y - size(mat)[2]
    mat = cat(mat,zeros(Int,size(mat)[1],add_cols),dims=2)
    all_x = vcat([repeat(r1,mat,i) for i in 0:x],[repeat(l1,mat,i) for i in 0:x])
    all_xy = vcat([repeat(d1,x,i) for x in all_x for i in 0:y],
                    [repeat(u1,x,i) for x in all_x for i in 0:y])
    return unique(all_xy)
end

function reflectx(mat)
    fresh = copy(mat)
    dim = size(mat)[1]
    for i in 1:dim÷2
        fresh[:,i], fresh[:,dim+1-i] = fresh[:,dim+1-i], fresh[:,i]
    end
    return fresh
end

struct Dog
    symbol::String
    shape::Array{Int,2}
    rots::Array{Array{Int,2},1}
    function Dog(symbol, shape)
        # shape = cat(shape,zeros(Int,5,2),dims=2)
        # shape = cat(shape,zeros(Int,2,5),dims=1)
        # println(size(shape))
        rots = vcat([repeat(xrot,shape,i) for i in 1:4],
                [repeat(xrot,reflectx(shape),j) for j in 1:4])
        rots = unique(rots)
        new(symbol, shape, rots)
    end
end

#define the dogs here

yellow = Dog(
    "y",
    [1 1 1 0 ;
     1 1 1 0 ;
     0 0 1 1 ;
     0 0 0 0 ;]
)

grey = Dog(
    "gy",
    [1 1 0;
     1 0 0;
     1 0 0]
)

orange = Dog(
    "o",
    [1 1 1;
     1 1 1;
     0 0 1]
)

blue = Dog(
    "b",
    [1 1;
     1 1]
)

white = Dog(
    "w",
    [1 1;
     0 0]

)

azure = Dog(
    "a",
    [1 1 1 0;
     0 0 1 1;
     0 0 1 0;
     0 0 0 0]
)

lime = Dog(
    "l",
    [1 0 0;
     1 0 0;
     1 0 0]
)

green = Dog(
    "g",
    [1 1 1;
     1 1 1;
     1 1 0]
)

pink = Dog(
    "pk",
    [1 1 1 0;
     1 1 0 0;
     1 1 0 0;
     1 1 0 0]
)

red = Dog(
    "r",
    [1 1;
     1 0]
)

teal = Dog(
    "t",
    [1 1 1 1;
     0 1 1 0;
     0 1 1 0;
     1 1 1 0;]
)

purple = Dog(
    "pl",
    [1 0 1 0;
     1 1 1 0;
     0 0 1 1;
     0 0 0 0;]
)
