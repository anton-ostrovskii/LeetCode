/**
 539. Minimum Time Difference
 https://leetcode.com/problems/minimum-time-difference/
 
 Given a list of 24-hour clock time points in "HH:MM" format, return the minimum minutes difference between any two time-points in the list.
  

 Example 1:

 Input: timePoints = ["23:59","00:00"]
 Output: 1
 
 Example 2:

 Input: timePoints = ["00:00","23:59","00:00"]
 Output: 0
  

 Constraints:

 2 <= timePoints.length <= 2 * 10^4
 timePoints[i] is in the format "HH:MM".
 */

import Foundation

class Solution {
    func mins(_ t: String) -> Int {
        guard let colonIndex = t.firstIndex(of: ":") else {
            return 0
        }

        let hours = t[t.startIndex..<colonIndex]
        let minutes = t[t.index(after: colonIndex)..<t.endIndex]

        guard let hrs = Int(hours),
              let mns = Int(minutes) else {
            return 0
        }

        return hrs * 60 + mns
    }

    func diff(_ t1: Int, _ t2: Int) -> Int {
        let sameDay = abs(t1 - t2)
        let diffDay = 1440 - max(t1, t2) + min(t1, t2)

        return min(sameDay, diffDay)
    }
    
    func findMinDifference(_ timePoints: [String]) -> Int {
        let minutes = (timePoints.map { mins($0) }).sorted()
        
        var minDiff = Int.max
        for i in 1..<minutes.count {
            minDiff = min(minDiff, minutes[i] - minutes[i - 1])
        }

        minDiff = min(minDiff, diff(minutes[0], minutes[minutes.endIndex - 1]))
        return minDiff
    }
}
