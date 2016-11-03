//
//  main.swift
//  TypeClass
//
//  Created by Databox on 11/1/16.
//  Copyright © 2016 BTi. All rights reserved.
//

import Foundation

protocol Num {
    associatedtype A
    static func add(x:A, y:A) -> A
}

extension Int:Num {
    static func add(x:Int, y:Int) -> Int { return x + y }
}

extension Double:Num {
    static func add(x:Double, y:Double) -> Double { return x + y }
}

func add<A: Num>(x:A, y:A) -> A where A.A == A
    { return A.add(x: x, y: y) }

let r1 = add(x: 1, y: 2)
let r2 = add(x: 1.0, y: 2.0)

//let r3 = add(x: "hello", y:"world")

print("r1:\(r1) r2:\(r2)")

protocol Show {
    associatedtype A
    static func show(x:A) -> String
}

extension Int:Show {
    static func show(x:Int) -> String { return "\(x)" }
}

extension Double:Show {
    static func show(x:Double) -> String { return "\(x)" }
}

//let xs:[Show] = [1, 1.0, 2, 2.0]

/*
enum ShowBoxNum {
    case num(Num)
}

enum ShowBox<A:Num> {
    case num(A)
}

let xs:[ShowBox] = [ShowBox.num(1), ShowBox.num(1.0), ShowBox.num(2), ShowBox.num(2.0)]


*/
enum ShowBox {
    case int(Int)
    case double(Double)
}

let xs:[ShowBox] = [ShowBox.int(1), ShowBox.double(1.0), ShowBox.int(2), ShowBox.double(2.0)]

extension ShowBox:Show {
    static func show(x:ShowBox) -> String {
        switch x {
        case let .int(value):
            return Int.show(x: value)
        case let .double(value):
            return Double.show(x: value)
        }
    }
}

for x in xs {
    print(ShowBox.show(x: x))
}

enum ShowBoxAny {
    case num(Any)
}

func SB<A: Show>(x:A) -> ShowBoxAny where A.A == A { return ShowBoxAny.num(x) }
func showSB<A: Show>(x:A) -> String where A.A == A { return A.show(x: x) }

let xsa:[ShowBoxAny] = [SB(x: 1), SB(x: 1.0), SB(x: 2), SB(x: 2.0)]

/*
extension ShowBoxAny:Show {
    static func show(x:ShowBoxAny) -> String {
        switch x {
        case let .num(value):
            return showSB(x: value)
        }
    }
}
*/
