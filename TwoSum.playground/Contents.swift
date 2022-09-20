/**
 Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.
 You may assume that each input would have exactly one solution, and you may not use the same element twice.
 You can return the answer in any order.

 Example 1:
 Input: nums = [2,7,11,15], target = 9
 Output: [0,1]
 Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].
 
 Example 2:
 Input: nums = [3,2,4], target = 6
 Output: [1,2]
 
 Example 3:
 Input: nums = [3,3], target = 6
 Output: [0,1]

 Constraints:

 2 <= nums.length <= 10^4
 -10^9 <= nums[i] <= 10^9
 -10^9 <= target <= 10^9
 Only one valid answer exists.
  
 Follow-up: Can you come up with an algorithm that is less than O(n2) time complexity?
 */

import Foundation

let array1 = [2,7,11,15]
let target1 = 9

let array2 = [3,2,4]
let target2 = 6

let array3 = [3,3]
let target3 = 6

/**
 # Simple solution
 
 Time: O(N^2)
 Space: O(1)
 */
func twoSumON2(_ nums: [Int], _ target: Int) -> [Int] {
    guard nums.count >= 2 else { return [] }
    for j in 1..<nums.count {
        for i in 0..<j {
            if nums[i] + nums[j] == target {
                return [i, j]
            }
        }
    }
    return []
}
print("O(N^2) Example 1: \(twoSumON2(array1, target1))")
print("O(N^2) Example 2: \(twoSumON2(array2, target3))")
print("O(N^2) Example 3: \(twoSumON2(array3, target3))")

/**
 # Optimized solution

 Time: O(2*N) ?
 Space: O(N)
*/
func twoSumOptimized(_ nums: [Int], _ target: Int) -> [Int] {
    guard nums.count >= 2 else { return [] }
    var numsDict: [Int:[Int]] = [:]
    for i in 0..<nums.count {
        if numsDict[nums[i]] == nil {
            numsDict[nums[i]] = [i]
        } else {
            numsDict[nums[i]]?.append(i)
        }
    }
    
    for i in 0..<nums.count {
        let search = target - nums[i]
        if let j = (numsDict[search]?.first { $0 != i }) {
            return [i, j]
        }
    }
    
    return []
}
print("Optimized Example 1: \(twoSumOptimized(array1, target1))")
print("Optimized Example 2: \(twoSumOptimized(array2, target3))")
print("Optimized Example 3: \(twoSumOptimized(array3, target3))")

/**
 # The best solution
 
  Time: O(N)
  Space: O(N)
 */
func twoSumON(_ nums: [Int], _ target: Int) -> [Int] {
    var dict: [Int:Int] = [:]
    for i in 0..<nums.count {
        let search = target - nums[i]
        if let j = dict[search] {
            return [i, j]
        } else {
            dict[nums[i]] = i
        }
    }
    return []
}
print("O(N) Example 1: \(twoSumON(array1, target1))")
print("O(N) Example 2: \(twoSumON(array2, target3))")
print("O(N) Example 3: \(twoSumON(array3, target3))")
