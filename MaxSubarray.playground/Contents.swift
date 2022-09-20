/**
 Design and implement an efficient progam to find a contiguous subarray within a one-dimensional array
 of integers which has the largest sum. Please note that there is at least one positive integer in the input array.
 */

import Foundation

let arr1 = [-2, 1, -3, 4, -1, 2, 1, -5, 4]
let arr2 = [-2, -3, 4, -1, -2, 1, 5, -3]
let arr3 = [-1, 4, -2, 5, -5, 2, -20, 6]
let arr4 = [-2, 1, -3, 4, -1, 2, 1, -5, 4]
let arr5 = [1, 2, 3, 4, 5, -2, -3, 0, 8, 8, 8, 8, 8, 8, 8, 8]

// Complexity O(N)
func simpleKadanesAlgorithm(array: [Int]) -> Int {
    var localMax = 0
    var globalMax = Int.min
    for i in 0..<array.count {
        localMax = max(array[i], localMax + array[i])
        if localMax > globalMax {
            globalMax = localMax
        }
    }
    return globalMax
}

print("simpleKadanesAlgorithm:")
print("arr1 => \(simpleKadanesAlgorithm(array: arr1))")
print("arr2 => \(simpleKadanesAlgorithm(array: arr2))")
print("arr3 => \(simpleKadanesAlgorithm(array: arr3))")
print("arr4 => \(simpleKadanesAlgorithm(array: arr4))")
print("arr5 => \(simpleKadanesAlgorithm(array: arr5))")

func kadanesWithIndicies(array: [Int]) -> (max: Int, startIndex: Int, endIndex: Int) {
    var startIndex = Int.min
    var endIndex = Int.max
    var localMax = 0
    var globalMax = Int.min
    
    for i in 0..<array.count {
        if array[i] > localMax + array[i] {
            //startIndex = i
            localMax = array[i]
        } else {
            localMax = localMax + array[i]
        }
        
        if localMax > globalMax {
            globalMax = localMax
            if startIndex == Int.min {
                startIndex = i
            }
            endIndex = i
        }
    }
    
    if startIndex > endIndex {
        startIndex = endIndex
    }
    return (max: globalMax, startIndex: startIndex, endIndex: endIndex)
}

print("kadanesWithIndicies:")
print("arr1 => \(kadanesWithIndicies(array: arr1))")
print("arr2 => \(kadanesWithIndicies(array: arr2))")
print("arr3 => \(kadanesWithIndicies(array: arr3))")
print("arr4 => \(kadanesWithIndicies(array: arr4))")
print("arr5 => \(kadanesWithIndicies(array: arr5))")
