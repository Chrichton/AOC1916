//
//  main.swift
//  AOC1916
//
//  Created by Heiko Goes on 28.12.19.
//  Copyright © 2019 Heiko Goes. All rights reserved.
//

import Foundation
         
infix operator |>
func |> <A, B>(a: A, f: (A) -> B) -> B {
  return f(a)
}

func getRepeatingPattern(pattern: [Int], length: Int) -> [Int] {
    return pattern.count >= length
        ? Array(pattern.prefix(length))
        : Array((1...length/pattern.count + 1).reduce([Int]()){ accu, _ in
            accu + pattern
        }.prefix(length))
}

func duplicateElements(array: [Int], numberOfDuplicates: Int) -> [Int] {
    return array.reduce([Int]()){ accu, current in
        accu + Array(repeating: current, count: numberOfDuplicates)
    }
}

func getRepeatingPattern(pattern: [Int], forLineNo: Int, length: Int) -> [Int] {
    let duplicatedPattern = Array(duplicateElements(
        array: pattern,
        numberOfDuplicates:
        forLineNo))
            
    return Array(getRepeatingPattern(
        pattern: duplicatedPattern,
        length: length + 1)
            .dropFirst())
}

func getLastDigit(number: Int) -> Int {
    return Int(String(String(number).last!))!
}

func getLine(signal: [Int], lineNo: Int, basePattern: [Int]) -> [Int] {
    let pattern = getRepeatingPattern(pattern: basePattern, forLineNo: lineNo, length: signal.count)
    return zip(signal, pattern).map{ $0.0 * $0.1 }
}

func getLineResult(signal: [Int], lineNo: Int, basePattern: [Int]) -> Int {
    getLine(signal: signal, lineNo: lineNo, basePattern: basePattern)
        .reduce(0, +)
        |> getLastDigit
}

func getNextSequence(signal: [Int], basePattern: [Int]) -> [Int] {
    (1...signal.count).map{ getLineResult(signal: signal, lineNo: $0, basePattern: basePattern)}
}


let basePattern = [0,1,0,-1]

//let signal = [1,2,3,4,5,6,7,8]
//
//let rp = getRepeatingPattern(pattern: basePattern, forLineNo: 1, length: signal.count)
//print(rp)
//
//let l = getLine(signal: signal, lineNo: 1, basePattern: basePattern)
//print(l)
//
//let lr = getLineResult(signal: signal, lineNo: 1, basePattern: basePattern)
//print(lr)
//
//let result = (1...4).reduce(signal){ accu, _ in
//    getNextSequence(signal: accu, basePattern: basePattern)
//}
//
//print(result)

let signalString = """
59791911701697178620772166487621926539855976237879300869872931303532122404711706813176657053802481833015214226705058704017099411284046473395211022546662450403964137283487707691563442026697656820695854453826690487611172860358286255850668069507687936410599520475680695180527327076479119764897119494161366645257480353063266653306023935874821274026377407051958316291995144593624792755553923648392169597897222058613725620920233283869036501950753970029182181770358827133737490530431859833065926816798051237510954742209939957376506364926219879150524606056996572743773912030397695613203835011524677640044237824961662635530619875905369208905866913334027160178
"""

//let signal = signalString
//    .map{ Int(String($0))! }
//
//let startingPoint = Date()
//
//let result = (1...100).reduce(signal){ accu, _ in
//    getNextSequence(signal: accu, basePattern: basePattern)
//}
//
//print(result.prefix(8).map{ String($0) }.joined())
//
//print("\(startingPoint.timeIntervalSinceNow * -1) seconds elapsed")

// ----------------------------------

let signal2: [Int] = String(repeating: signalString, count: 10000).map{ Int(String($0))! }

let startingPoint2 = Date()

let result2 = (1...100).reduce(signal2){ accu, current in
        print(current, "  \(startingPoint2.timeIntervalSinceNow * -1) seconds elapsed")
    
    return getNextSequence(signal: accu, basePattern: basePattern)
}

print(result2.prefix(8).map{ String($0) }.joined())

print("\(startingPoint2.timeIntervalSinceNow * -1) seconds elapsed")
