/**
 The array b[0...n-1] has n elements, mat have duplicate elements, and may be sorted.
 A plateau of length p is a sequence of p consecutive elements with the same value.
 Find the length of the longest plateau in b.
 */

import Foundation

let arr1: [Int] = [1,4,2,3,3,3,3,4,4,4,5,1,1]   // 4
let arr2: [Int] = [1,2,1,2,1,1,2]   // 2
let arr3: [Int] = [0,1,1,1,2,2,2,3,3,3,3]   // 4
let arr4: [Int] = [1,1,1,2,2,3,2,2] // 5

func plateau(_ arr: [Int]) -> Int {
    var i = 0
    var p = 0
    while i < arr.count {
        print("arr[\(i)] = \(arr[i]), p = \(p), arr[i-p] = \(arr[i - p])")
        if arr[i] == arr[i - p] {
            p += 1
        }
        i += 1
    }
    return p
}

/*print(plateau(arr1))
print(plateau(arr2))
print(plateau(arr3))*/

print(plateau(arr4))
