# ex. MyNumber(10).value
# ex. Add(MyNumber(10), Num(2))

immutable MyNumber
    value::Number
end

immutable MyBool
    value::Bool
end

type Add
    left
    right
end

type Mult
    left
    right
end

typealias Operator Union(Mult, Add)
typealias Value Union(MyNumber, MyBool)

is_reducible(expression::Operator) = true
is_reducible(expression::Value) = false

function reduce(exp::Operator)
    if typeof(exp) == Add 
        operator = (+)
    elseif typeof(exp) == Mult
        operator = (*)
    end

    if is_reducible(exp.left)
        return reduce(typeof(exp)(reduce(exp.left), exp.right))
    elseif is_reducible(exp.right)
        return reduce(typeof(exp)(exp.left, reduce(exp.right)))
    else
        return MyNumber(operator(exp.left.value, exp.right.value))
    end
end

function to_s(exp::Operator)
    operator = typeof(exp) == Add ? " + " : " * "
    return string("(", to_s(exp.left), operator, to_s(exp.right), ")")
end

function to_s(exp::Value)
    return string(exp.value)
end

