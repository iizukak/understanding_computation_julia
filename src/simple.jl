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

type LessThan
    left
    right
end

type Or
    left
    right
end

type And
    left
    right
end

typealias NumberOperator Union(Mult, Add, LessThan)
typealias BoolOperator Union(Or, And)
typealias Operator Union(NumberOperator, BoolOperator)
typealias Value Union(MyNumber, MyBool)

is_reducible(expression::Operator) = true
is_reducible(expression::Value) = false

function reduce(exp::Operator)
    if typeof(exp) == Add 
        operator = (+)
    elseif typeof(exp) == Mult
        operator = (*)
    elseif typeof(exp) == LessThan
        operator = (<)
    elseif typeof(exp) == And
        operator = (&)
    elseif typeof(exp) == Or
        operator = (|)
    end

    if is_reducible(exp.left)
        return reduce(typeof(exp)(reduce(exp.left), exp.right))
    elseif is_reducible(exp.right)
        return reduce(typeof(exp)(exp.left, reduce(exp.right)))
    end

    if typeof(exp) <: NumberOperator
        return MyNumber(operator(exp.left.value, exp.right.value))
    elseif typeof(exp) <: BoolOperator
        return MyBool(operator(exp.left.value, exp.right.value))
    end
end

function to_s(exp::Operator)
    if typeof(exp) == Add 
         operator = (" + ")
    elseif typeof(exp) == Mult
         operator = (" * ")
    elseif typeof(exp) == LessThan
         operator = (" < ")
    elseif typeof(exp) == Or
         operator = (" & ")
    elseif typeof(exp) == And
         operator = (" | ")
    end

    return string("(", to_s(exp.left), operator, to_s(exp.right), ")")
end

function to_s(exp::Value)
    return string(exp.value)
end

