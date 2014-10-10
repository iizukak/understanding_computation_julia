# ex. Num(10).value
# ex. Add(Num(10), Num(2))

immutable Num
    value::Number
end

type Add
    left
    right
end

type Mult
    left
    right
end

is_reducible(expression::Union(Mult, Add)) = true
is_reducible(Num) = false

function reduce(exp::Add)
    if is_reducible(exp.left)
        return reduce(Add(reduce(exp.left), exp.right))
    elseif is_reducible(exp.right)
        return reduce(Add(exp.left, reduce(exp.right)))
    else
        return Num(exp.left.value + exp.right.value)
    end
end

function reduce(exp::Mult)
    if is_reducible(exp.left)
        return reduce(Mult(reduce(exp.left), exp.right))
    elseif is_reducible(exp.right)
        return reduce(Mult(exp.left, reduce(exp.right)))
    else
        return Num(exp.left.value * exp.right.value)
    end
end

