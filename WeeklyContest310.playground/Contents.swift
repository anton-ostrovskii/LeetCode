/**
 Weekly Cntest 310 sponsored by Motorola
 */

import Foundation

/**
 6176. Most Frequent Even Element
 User Accepted:0
 User Tried:0
 Total Accepted:0
 Total Submissions:0
 Difficulty:Easy
 Given an integer array nums, return the most frequent even element.

 If there is a tie, return the smallest one. If there is no such element, return -1.

 Example 1:

 Input: nums = [0,1,2,2,4,4,1]
 Output: 2
 Explanation:
 The even elements are 0, 2, and 4. Of these, 2 and 4 appear the most.
 We return the smallest one, which is 2.
 Example 2:

 Input: nums = [4,4,4,9,2,4]
 Output: 4
 Explanation: 4 is the even element appears the most.
 Example 3:

 Input: nums = [29,47,21,41,13,37,25,7]
 Output: -1
 Explanation: There is no even element.
  
 Constraints:

 1 <= nums.length <= 2000
 0 <= nums[i] <= 105
 */

class Solution1 {
    func mostFrequentEven(_ nums: [Int]) -> Int {
        let numsSorted = (nums.filter { $0 % 2 == 0 } ).sorted()
        guard numsSorted.count > 0 else { return -1 }
        var prev = numsSorted[0]
        var minRepeated = prev
        var maxReps = 1
        var curReps = 1
        for i in 1..<numsSorted.count {
            if numsSorted[i] == prev {
                curReps += 1
            } else {
                if curReps > maxReps {
                    maxReps = curReps
                    minRepeated = prev
                }
                curReps = 1
            }
            prev = numsSorted[i]
        }

        if curReps > maxReps {
            maxReps = curReps
            minRepeated = prev
        }

        return minRepeated
    }
}

let nums1 = [0,1,2,2,4,4,1]
let nums2 = [4,4,4,9,2,4]
let nums3 = [29,47,21,41,13,37,25,7]
let nums4 = [0,0,0,0]
let nums5 = [1000]
let nums6 = [9145,1967,6704,9262,5684,2726,7740,95,25,3475,9425,9279,3967,4137,8298,2413,7734,4042,720,9597,913,1928,5818,7473,6696,2010,5452,8750,4930,7092,758,9594,7723,8015,5474,2595,3475,9996,1447,5563,9266,8706,7228,6679,3913,5400,7728,1005,6361,4259,7940,6055,1594,3942,4786,3939,8557,5621,206,6660,3964,4979,9439,3304,744,1912,8597,6016,7128,4580,8339,3060,4299,547,296,2981,4309,2685,8091,1832,6740,7429,8971,3798,7524,2243,4837,6811,2127,5670,5167,9624,8002,6682,2797,5665,8627,6436,1500,346,407,9493,5102,3110,9280,5152,6439,2007,3079,752,7104,905,2793,1851,3842,389,4815,5386,6483,7423,8685,3780,722,5756,7217,2851,7573,411,8961,1644,664,1695,2660,7404,2102,6762,5841,7098,9950,2571,6182,1725,9210,7714,3038,5047,9505,9086,9099,2057,3664,6264,2324,922,4339,6863,50,9856,8933,1676,1028,1257,9590,6019,3226,7547,7742,978,6742,1012,3392,4445,7338,9190,6443,1477,2559,6149,9965,5106,3972,8941,47,7020,1800,6325,2401,2974,5678,1385,4336,7060,9584,5120,5903,5501,1678,5993,6431,1780,491,3196,9430,7155,1816,2643,9056,6102,1373,3562,979,7761,4074,6950,1676,6087,9623,9816,2865,7661,7239,5128,4373,5201,362,4236,8583,9827,6164,4978,3917]
let solution1 = Solution1()
//print(solution1.mostFrequentEven(nums1))
//print(solution1.mostFrequentEven(nums2))
//print(solution1.mostFrequentEven(nums3))
//print(solution1.mostFrequentEven(nums4))
//print(solution1.mostFrequentEven(nums5))
//print(solution1.mostFrequentEven(nums6))





/**
 6177. Optimal Partition of String
 
 Given a string s, partition the string into one or more substrings such that the characters in each substring are unique. That is, no letter appears in a single substring more than once.

 Return the minimum number of substrings in such a partition.

 Note that each character should belong to exactly one substring in a partition.

  

 Example 1:

 Input: s = "abacaba"
 Output: 4
 Explanation:
 Two possible partitions are ("a","ba","cab","a") and ("ab","a","ca","ba").
 It can be shown that 4 is the minimum number of substrings needed.
 Example 2:

 Input: s = "ssssss"
 Output: 6
 Explanation:
 The only valid partition is ("s","s","s","s","s","s").
  

 Constraints:

 1 <= s.length <= 10^5
 s consists of only English lowercase letters.
 
 */

class Solution2 {
    func partitionString(_ s: String) -> Int {
        var partitions = 1
        let chars = Array(s)
        var partition: Set<Character> = []
        for char in chars {
            if !partition.insert(char).inserted {
                partitions += 1
                partition.removeAll()
                partition.insert(char)
            }
        }
        return partitions
    }
}

let solution2 = Solution2()
let s1 = "abacaba"
let s2 = "ssssss"
//print(solution2.partitionString(s1))
//print(solution2.partitionString(s2))



/**
 
 6178. Divide Intervals Into Minimum Number of Groups
 
 You are given a 2D integer array intervals where intervals[i] = [lefti, righti] represents the inclusive interval [lefti, righti].

 You have to divide the intervals into one or more groups such that each interval is in exactly one group, and no two intervals that are in the same group intersect each other.

 Return the minimum number of groups you need to make.

 Two intervals intersect if there is at least one common number between them. For example, the intervals [1, 5] and [5, 8] intersect.

  

 Example 1:

 Input: intervals = [[5,10],[6,8],[1,5],[2,3],[1,10]]
 Output: 3
 Explanation: We can divide the intervals into the following groups:
 - Group 1: [1, 5], [6, 8].
 - Group 2: [2, 3], [5, 10].
 - Group 3: [1, 10].
 It can be proven that it is not possible to divide the intervals into fewer than 3 groups.
 
 Example 2:

 Input: intervals = [[1,3],[5,6],[8,10],[11,13]]
 Output: 1
 Explanation: None of the intervals overlap, so we can put all of them in one group.
  

 Constraints:

 1 <= intervals.length <= 10^5
 intervals[i].length == 2
 1 <= lefti <= righti <= 10^6
 
 */

class Solution3 {
    func minGroups(_ intervals: [[Int]]) -> Int {
        func isOverlapping(_ int1: [Int], _ int2: [Int]) -> Bool {
            max(int1[0], int2[0]) <= min(int1[1], int2[1])
        }

        func isOverlapping(_ int: [Int], _ ints: Set<[Int]>) -> Bool {
            for exst in ints {
                if isOverlapping(int, exst) {
                    return true
                }
            }
            return false
        }

        var groups = 0
        var mutableIntervals = intervals.sorted { $0[0] < $1[0] }
        var currInts = Set<[Int]>()
        while !mutableIntervals.isEmpty {
            groups += 1
            let curr = mutableIntervals.removeFirst()
            var i = 0
            currInts.removeAll()
            currInts.insert(curr)
            while i < mutableIntervals.count {
                let other = mutableIntervals[i]
                if !isOverlapping(other, currInts) {
                    currInts.insert(other)
                    mutableIntervals.remove(at: i)
                    i -= 1
                }
                i += 1
            }

        }

        return groups
    }
}

let solution3 = Solution3()
let intervals1 = [[5,10],[6,8],[1,5],[2,3],[1,10]]
let intervals2 = [[1,3],[5,6],[8,10],[11,13]]
let intervals3 = [[441459,446342],[801308,840640],[871890,963447],[228525,336985],[807945,946787],[479815,507766],[693292,944029],[751962,821744]]
let intervals4 = [[229966,812955],[308778,948377],[893612,952735],[395781,574123],[478514,875165],[766513,953839],[460683,491583],[133951,212694],[376149,838265],[541380,686845],[461394,568742],[804546,904032],[422466,467909],[557048,758709],[680460,899053],[110928,267321],[470258,650065],[534607,921875],[292993,994721],[645020,692560],[898840,947977],[33584,330630],[903142,970252],[17375,626775],[804313,972796],[582079,757160],[785002,987823],[599263,997719],[486500,527956],[566481,813653],[211239,863969],[808577,883125],[21880,516436],[264747,412144],[327175,772333],[984807,988224],[758172,916673],[23583,406006],[954674,956043],[379202,544291],[688869,785368],[841735,983869],[99836,916620],[332504,740696],[740840,793924],[896607,920924],[868540,922727],[125849,550941],[433284,685766]]
let intervals5 = [[935387,971021],[866648,882725],[617324,668847],[207490,229649],[678354,738786]]
//print(solution3.minGroups(intervals1))
//print(solution3.minGroups(intervals2))
//print(solution3.minGroups(intervals3))
//print(solution3.minGroups(intervals4))
print(solution3.minGroups(intervals5))

class Solution3A {
    func minGroups(_ intervals: [[Int]]) -> Int {
        func isOverlapping(_ int1: [Int], _ int2: [Int]) -> Bool {
            max(int1[0], int2[0]) <= min(int1[1], int2[1])
        }

        var groups = 0
        var mutableIntervals = intervals//.sorted { $0[0] < $1[0] }
        while !mutableIntervals.isEmpty {
            let curr = mutableIntervals.removeFirst()
            var i = 0
            var currInt = curr
            //var overlapped = true
            print(mutableIntervals.count)
            while i < mutableIntervals.count {
                let other = mutableIntervals[i]
                print(other)
                if !isOverlapping(currInt, other) {
                    mutableIntervals.remove(at: i)
                    i -= 1
                    currInt[0] = min(currInt[0], other[0])
                    currInt[1] = max(currInt[1], other[1])
                    //overlapped = false
                } else {
                    print("catch!")
                }
                i += 1
            }
            //if !mutableIntervals.isEmpty || (mutableIntervals.isEmpty && overlapped) {
                groups += 1
            //}
            print(mutableIntervals.count)
        }

        if groups == 0 {
            groups = 1
        }

        return groups
    }
}
let solution3a = Solution3A()
//print(solution3a.minGroups(intervals1))
//print(solution3a.minGroups(intervals2))
//print(solution3a.minGroups(intervals3))
//print(solution3a.minGroups(intervals4))
print(solution3a.minGroups(intervals5))



/**
 6206. Longest Increasing Subsequence II
 User Accepted:526
 User Tried:3954
 Total Accepted:570
 Total Submissions:8667
 Difficulty:Hard
 You are given an integer array nums and an integer k.

 Find the longest subsequence of nums that meets the following requirements:

 The subsequence is strictly increasing and
 The difference between adjacent elements in the subsequence is at most k.
 Return the length of the longest subsequence that meets the requirements.

 A subsequence is an array that can be derived from another array by deleting some or no elements without changing the order of the remaining elements.

  

 Example 1:

 Input: nums = [4,2,1,4,3,4,5,8,15], k = 3
 Output: 5
 Explanation:
 The longest subsequence that meets the requirements is [1,3,4,5,8].
 The subsequence has a length of 5, so we return 5.
 Note that the subsequence [1,3,4,5,8,15] does not meet the requirements because 15 - 8 = 7 is larger than 3.
 Example 2:

 Input: nums = [7,4,5,1,8,12,4,7], k = 5
 Output: 4
 Explanation:
 The longest subsequence that meets the requirements is [4,5,8,12].
 The subsequence has a length of 4, so we return 4.
 Example 3:

 Input: nums = [1,5], k = 1
 Output: 1
 Explanation:
 The longest subsequence that meets the requirements is [1].
 The subsequence has a length of 1, so we return 1.
  

 Constraints:

 1 <= nums.length <= 105
 1 <= nums[i], k <= 105
 */
