/**
  https://leetcode.com/problems/happy-number/
 
 Write an algorithm to determine if a number n is happy.

 A happy number is a number defined by the following process:

 Starting with any positive integer, replace the number by the sum of the squares of its digits.
 Repeat the process until the number equals 1 (where it will stay), or it loops endlessly in a cycle which does not include 1.
 Those numbers for which this process ends in 1 are happy.
 Return true if n is a happy number, and false if not.

 Example 1:

 Input: n = 19
 Output: true
 Explanation:
 1^2 + 9^2 = 82
 8^2 + 2^2 = 68
 6^2 + 8^2 = 100
 1^2 + 0^2 + 0^2 = 1
 
 Example 2:

 Input: n = 2
 Output: false
  

 Constraints:

 1 <= n <= 231 - 1
 
 */

import Foundation

var str = "Hello, playground"

typealias SampleData = (n: Int, output: Bool)

let e1 = SampleData(19, true)
let e2 = SampleData(2, false)

func checksum(_ n: Int) -> Int {
    var result = 0
    var remaining = n
    while remaining > 0 {
        let p = remaining % 10
        result += p*p
        remaining /= 10
    }
    return result
}

/// Simple solution with a hashset for checking for loops. Speed: O(logN). Space: O(logN)
func isHappySimple(_ n: Int) -> Bool {
    var seen: Set<Int> = []
    var h = n
    while h != 1 && seen.insert(h).inserted {
        h = checksum(h)
    }
    return h == 1
}

print(isHappySimple(19))
print(isHappySimple(2))

/// Advanced solution which doesn't require additional set. Speed: O(logN). Space: O(1)
func isHappyAdvanced(_ n: Int) -> Bool {
    var turtle = checksum(n)
    var hare = checksum(turtle)
    while hare != 1 && hare != turtle {
        turtle = checksum(turtle)
        hare = checksum(checksum(hare))
    }
    return hare == 1
}

print(isHappyAdvanced(19))
print(isHappyAdvanced(2))
