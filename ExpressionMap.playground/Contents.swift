//: ## Expression Map
//
//: 10 = 10
//: 10 = 5 * 2
//: 12 = 3 * 4


indirect enum Expression {
    case value(Int)
    case expression(Expression, Expression)
}

func evaluate(_ expression: Expression) -> Int? {
    switch expression {
    case .value(let value):
        return value
    case .expression(let ex1, let ex2):
        return (ex1, ex2) ☎︎ { $0 * $1 }
    }
}

func map(_ ex1: Expression, _ ex2: Expression, _ transform: (Int, Int) -> Int) -> Int? {
    guard let a = evaluate(ex1) else { return nil }
    guard let b = evaluate(ex2),
        b > 0 else { return nil }
    return .some(transform(a, b))
}

precedencegroup Apply {
    associativity: left
}

infix operator ☎︎: Apply

func ☎︎(_ input: (Expression, Expression), _ transform: (Int, Int) -> Int) -> Int? {
    let a = input.0
    let b = input.1
    return map(a, b, transform)
}

evaluate(Expression.value(4))
evaluate(Expression.expression(Expression.value(10), Expression.value(2)))

//: [Next](@next)
