/*
 
 https://leetcode.com/problems/race-car/
 
 Your car starts at position 0 and speed +1 on an infinite number line. Your car can go into negative positions. Your car drives automatically according to a sequence of instructions 'A' (accelerate) and 'R' (reverse):

 When you get an instruction 'A', your car does the following:
 position += speed
 speed *= 2
 When you get an instruction 'R', your car does the following:
 If your speed is positive then speed = -1
 otherwise speed = 1
 Your position stays the same.
 For example, after commands "AAR", your car goes to positions 0 --> 1 --> 3 --> 3, and your speed goes to 1 --> 2 --> 4 --> -1.

 Given a target position target, return the length of the shortest sequence of instructions to get there.
  
 Example 1:

 Input: target = 3
 Output: 2
 Explanation:
 The shortest instruction sequence is "AA".
 Your position goes from 0 --> 1 --> 3.
 
 Example 2:

 Input: target = 6
 Output: 5
 Explanation:
 The shortest instruction sequence is "AAARA".
 Your position goes from 0 --> 1 --> 3 --> 7 --> 7 --> 6.
  

 Constraints:

 1 <= target <= 10^4
 
 */

import Foundation

class Solution {
    func racecar(_ target: Int) -> Int {
        var dp: [Int] = Array(repeating: Int.max, count: target + 3)
        dp[0] = 0
        dp[1] = 1
        dp[2] = 4
        
        for t in 0...target {
            let k = 64 - t.leadingZeroBitCount
            
            // First case: t == 2^k - 1     => k
            if t == 1<<k - 1 {
                dp[t] = k
                continue
            }
            
            // Second case: A^(k-1) R A^j R     => k - 1 + j + 2
            for j in 0..<k-1 {
                dp[t] = min(dp[t], dp[t - 1<<(k-1) + 1<<j] + k - 1 + j + 2)
            }
            
            // Third case: A^k R        => k + 1
            if 1<<k - 1 - t < t {
                dp[t] = min(dp[t], dp[1<<k - 1 - t] + k + 1)
            }
        }
        
        return dp[target]
    }
}

let rc = Solution()
print(rc.racecar(5))
print(rc.racecar(12))
print(rc.racecar(31))
