/**
 552. Student Attendance Record II
 https://leetcode.com/problems/student-attendance-record-ii/
 
 An attendance record for a student can be represented as a string where each character signifies whether the student was absent, late, or present on that day. The record only contains the following three characters:

 'A': Absent.
 'L': Late.
 'P': Present.
 Any student is eligible for an attendance award if they meet both of the following criteria:

 The student was absent ('A') for strictly fewer than 2 days total.
 The student was never late ('L') for 3 or more consecutive days.
 Given an integer n, return the number of possible attendance records of length n that make a student eligible for an attendance award. The answer may be very large, so return it modulo 10^9 + 7.

 Example 1:

 Input: n = 2
 Output: 8
 Explanation: There are 8 records with length 2 that are eligible for an award:
 "PP", "AP", "PA", "LP", "PL", "AL", "LA", "LL"
 Only "AA" is not eligible because there are 2 absences (there need to be fewer than 2).
 
 Example 2:

 Input: n = 1
 Output: 3
 
 Example 3:

 Input: n = 10101
 Output: 183236316
  

 Constraints:

 1 <= n <= 10^5
 */

import Foundation

// Time limit exceeded. Complexity: O(N^2). Size: O(N)
class Solution {
    private let modular = 1_000_000_000 + 7

    func checkRecord(_ n: Int) -> Int {
        var vals = Array(repeating: 0, count: n + 1)    // starting from "1" (day 1) hence "n+1"

        // calculate for L and P only
        for i in 1...n {
            vals[i] = lpCheck(i)
        }

        var combinations = vals[n]

        // now only one "A" could appear somewhere. Add more combinations:
        for i in 1...n {
            combinations += (lpCheck(i - 1) * 1 * lpCheck(n-i))// % modular
        }

        return combinations % modular
    }

    // returns the list of combinations with L and P only
    private func lpCheck(_ n: Int) -> Int {
        switch n {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 4
        case 3:
            return 7
        default:
            // 2 combinations: (n-1)L and (n-1)P minus (n-4) of "LLL" ending combinations
            return (2 * lpCheck(n - 1) - lpCheck(n - 4))// % modular
        }
    }
}

// Time limit exceeded. Complexity: O(N). Size: O(N)
class SolutionOptimized {
    private let modular = 1_000_000_000 + 7
    
    func checkRecord(_ n: Int) -> Int {
        var vals: [Int] = Array(repeating: 0, count: n <= 5 ? 6 : n + 1)    // starting from "1" (day 1) hence "n+1"
        vals[0] = 1
        vals[1] = 2
        vals[2] = 4
        vals[3] = 7
        if n >= 4 {
            for i in 4...n {
                vals[i] = (2 * vals[i - 1] % modular + (modular - vals[i - 4])) % modular
            }
        }
        var combinations = vals[n]
        for i in 1...n {
            combinations += (vals[i - 1] * 1 * vals[n - i]) % modular
        }
        return combinations % modular
    }
}

let solution = SolutionOptimized()
print(solution.checkRecord(2))
print(solution.checkRecord(1))
print(solution.checkRecord(10101))
