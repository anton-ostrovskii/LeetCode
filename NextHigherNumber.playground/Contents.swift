/**
 Compute the next higher number of a given integer using the same digits.
 It is also known as next higher permutation of a given number
 */

import Foundation

typealias TestData = (input: Int, output: Int?)

let s1: TestData = (input: 1234, output: 1243)
let s2: TestData = (input: 4132, output: 4213)
let s3: TestData = (input: 4321, output: nil)
let s4: TestData = (input: 32876, output: 36278)
let s5: TestData = (input: 32841, output: 34128)

func getNextHigherPermutation(_ input: Int) -> Int? {
    var inputArray = String(describing: input).compactMap { Int(String($0)) }
    
    var i1 = -1
    
    for i in stride(from: inputArray.count - 1, to: 1, by: -1) {
        if inputArray[i - 1] < inputArray[i] {
            i1 = i - 1
            break
        }
    }
    
    guard i1 >= 0 else { return nil }
    
    var i2 = -1
    
    for i in i1+1..<inputArray.count {
        if inputArray[i] > inputArray[i1] {
            if i2 < 0 || inputArray[i] < inputArray[i2] {
                i2 = i
            }
        }
    }
    
    inputArray.swapAt(i1, i2)
    
    var resultArray = inputArray[0...i1]
    let sortedSlice = inputArray[i1+1..<inputArray.count].sorted()
    resultArray.append(contentsOf: sortedSlice)
    
    var result = 0
    for i in 0..<resultArray.count {
        result += resultArray[i] * Int(pow(10.0, Double(resultArray.count - i - 1)))
    }
    
    return result
}

func test(_ s: TestData) {
    let i = s.input
    let o = s.output
    let permutation = getNextHigherPermutation(i)
    let pass = permutation == o
    print("Pass: \(pass). Input: \(i). Output: \(permutation). Expected: \(o)")
}

test(s1)
test(s2)
test(s3)
test(s4)
test(s5)
