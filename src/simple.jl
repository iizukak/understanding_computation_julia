# ex. Num(10).value
# ex. Add(Num(10), Num(2))

type Num
    value::Number
end

type Add
    left::Num
    right::Num
end

type Mult
    left::Num
    right::Num
end


