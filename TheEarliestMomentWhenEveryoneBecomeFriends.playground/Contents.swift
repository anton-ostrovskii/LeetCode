/**
 1101. The Earliest Moment When Everyone Become Friends

 There are n people in a social group labeled from 0 to n - 1. You are given an array logs where logs[i] = [timestampi, xi, yi] indicates that xi and yi will be friends at the time timestampi.

 Friendship is symmetric. That means if a is friends with b, then b is friends with a. Also, person a is acquainted with a person b if a is friends with b, or a is a friend of someone acquainted with b.

 Return the earliest time for which every person became acquainted with every other person. If there is no such earliest time, return -1.

 Example 1:

 Input: logs = [[20190101,0,1],[20190104,3,4],[20190107,2,3],[20190211,1,5],[20190224,2,4],[20190301,0,3],[20190312,1,2],[20190322,4,5]], n = 6
 Output: 20190301
 Explanation:
 The first event occurs at timestamp = 20190101 and after 0 and 1 become friends we have the following friendship groups [0,1], [2], [3], [4], [5].
 The second event occurs at timestamp = 20190104 and after 3 and 4 become friends we have the following friendship groups [0,1], [2], [3,4], [5].
 The third event occurs at timestamp = 20190107 and after 2 and 3 become friends we have the following friendship groups [0,1], [2,3,4], [5].
 The fourth event occurs at timestamp = 20190211 and after 1 and 5 become friends we have the following friendship groups [0,1,5], [2,3,4].
 The fifth event occurs at timestamp = 20190224 and as 2 and 4 are already friends anything happens.
 The sixth event occurs at timestamp = 20190301 and after 0 and 3 become friends we have that all become friends.
 
 Example 2:

 Input: logs = [[0,2,0],[1,0,1],[3,0,3],[4,1,2],[7,3,1]], n = 4
 Output: 3
  

 Constraints:

 2 <= n <= 100
 1 <= logs.length <= 10^4
 logs[i].length == 3
 0 <= timestampi <= 10^9
 0 <= xi, yi <= n - 1
 xi != yi
 All the values timestampi are unique.
 All the pairs (xi, yi) occur at most one time in the input.
 */

import Foundation
import Darwin

// Speed: O(NlogN). Space: O(N)
class Solution {
    struct Friends {
        private(set) var timestamp: Int = Int.min
        private var data = [Set<Int>]()
        private(set) var totalFriends: Int = 0
        var everyoneKnownsEachOther: Bool { data.count == 1 }

        @discardableResult mutating func append(entry: [Int]) -> Int {
            var time = entry[0]
            let a = entry[1]
            let b = entry[2]

            let ia = data.firstIndex { $0.contains(a) }
            let ib = data.firstIndex { $0.contains(b) }

            if let ia = ia, let ib = ib {
                // both sets exists
                if ia != ib {
                    // different sets - we need to merge
                    data[ia].formUnion(data[ib])
                    data.remove(at: ib)
                } else {
                    // same sets - do nothing
                    time = Int.min
                }
            } else if let ia = ia, ib == nil {
                // set with "a" exists. Add "b" to this set
                data[ia].insert(b)
                totalFriends += 1
            } else if let ib = ib, ia == nil {
                // set with "b" exists. Add "a" to this set
                data[ib].insert(a)
                totalFriends += 1
            } else {
                // no set exists. Form a new set
                data.append([a, b])
                totalFriends += 2
            }

            updateTimestampIfNeeded(time)
            return totalFriends
        }

        private mutating func updateTimestampIfNeeded(_ other: Int) {
            timestamp = max(timestamp, other)
        }
    }
    
    func earliestAcq(_ logs: [[Int]], _ n: Int) -> Int {
        var friends = Friends()
        var totalFriends = 0
        let sortedLogs = logs.sorted { $0[0] < $1[0] }
        for entry in sortedLogs where !(totalFriends == n && friends.everyoneKnownsEachOther) {
            totalFriends = friends.append(entry: entry)
        }

        if totalFriends == n && friends.everyoneKnownsEachOther {
            return friends.timestamp
        } else {
            return -1
        }
    }
}

let ex1: [[Int]] = [[20190101,0,1],[20190104,3,4],[20190107,2,3],[20190211,1,5],[20190224,2,4],[20190301,0,3],[20190312,1,2],[20190322,4,5]]
let n1 = 6

let ex2: [[Int]]  = [[0,2,0],[1,0,1],[3,0,3],[4,1,2],[7,3,1]]
let n2 = 4

let ex3: [[Int]] = [[7,3,1],[2,3,0],[3,2,1],[6,0,1],[0,2,0],[4,3,2]]
let n3 = 4

let solution = Solution()
print(solution.earliestAcq(ex1, n1))
print(solution.earliestAcq(ex2, n2))
print(solution.earliestAcq(ex3, n3))

