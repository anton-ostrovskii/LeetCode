/**
 
 1055. Shortest Way to Form String
 https://leetcode.com/problems/shortest-way-to-form-string/
 
 A subsequence of a string is a new string that is formed from the original string by deleting some (can be none) of the characters without disturbing the relative positions of the remaining characters. (i.e., "ace" is a subsequence of "abcde" while "aec" is not).

 Given two strings source and target, return the minimum number of subsequences of source such that their concatenation equals target. If the task is impossible, return -1.

  

 Example 1:

 Input: source = "abc", target = "abcbc"
 Output: 2
 Explanation: The target "abcbc" can be formed by "abc" and "bc", which are subsequences of source "abc".
 
 Example 2:

 Input: source = "abc", target = "acdbc"
 Output: -1
 Explanation: The target string cannot be constructed from the subsequences of source string due to the character "d" in target string.
 
 Example 3:

 Input: source = "xyz", target = "xzyxz"
 Output: 3
 Explanation: The target string can be constructed as follows "xz" + "y" + "xz".
  

 Constraints:

 1 <= source.length, target.length <= 1000
 source and target consist of lowercase English letters.
 
 */

import Foundation
import Darwin

/// Time limit exceeded. Complexity O(N^2) where N - length of target
class SimpleSolution {
    func isSubsequence(_ sub: String, source: String) -> Bool {
        var subI = 0
        var srcI = 0
        var matches = 0

        while subI < sub.count && srcI < source.count {
            if source[source.index(source.startIndex, offsetBy: srcI)] == sub[sub.index(sub.startIndex, offsetBy: subI)] {
                subI += 1
                matches += 1
            }
            srcI += 1
        }

        return matches == sub.count
    }
    
    func shortestWay(_ source: String, _ target: String) -> Int {
        var targetCopy = target
        var seq = 0

        while targetCopy.count > 0 {
            var sub = targetCopy
            while targetCopy.count > 0 && sub.count > 0 {
                if isSubsequence(sub, source: source) {
                    seq += 1
                    targetCopy.removeFirst(sub.count)
                    break
                }
                sub.popLast()
            }
            if sub.count == 0 {
                return -1
            }
        }

        return seq
    }
}

// Complexity O(N*M)
class OptimizedSolution {
    func shortestWay(_ source: String, _ target: String) -> Int {
        var seq = 0
        var ti = 0
        
        while ti < target.count {
            var sti = ti
            for si in 0..<source.count where ti < target.count {
                if target[target.index(target.startIndex, offsetBy: ti)] == source[source.index(source.startIndex, offsetBy: si)] {
                    ti += 1
                }
            }
            
            if sti == ti {
                return -1
            }
            
            seq += 1
        }
        
        return seq
    }
}

let solution = OptimizedSolution()
print(solution.shortestWay("abc", "abcbc"))
print(solution.shortestWay("abc", "acdbc"))
print(solution.shortestWay("xyz", "xzyxz"))
