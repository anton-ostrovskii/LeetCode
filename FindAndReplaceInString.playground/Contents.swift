/**
 833. Find And Replace in String
 https://leetcode.com/problems/find-and-replace-in-string/
 
 You are given a 0-indexed string s that you must perform k replacement operations on. The replacement operations are given as three 0-indexed parallel arrays, indices, sources, and targets, all of length k.

 To complete the ith replacement operation:

 Check if the substring sources[i] occurs at index indices[i] in the original string s.
 If it does not occur, do nothing.
 Otherwise if it does occur, replace that substring with targets[i].
 For example, if s = "abcd", indices[i] = 0, sources[i] = "ab", and targets[i] = "eee", then the result of this replacement will be "eeecd".

 All replacement operations must occur simultaneously, meaning the replacement operations should not affect the indexing of each other. The testcases will be generated such that the replacements will not overlap.

 For example, a testcase with s = "abc", indices = [0, 1], and sources = ["ab","bc"] will not be generated because the "ab" and "bc" replacements overlap.
 Return the resulting string after performing all replacement operations on s.

 A substring is a contiguous sequence of characters in a string.

 Example 1:

 Input: s = "abcd", indices = [0, 2], sources = ["a", "cd"], targets = ["eee", "ffff"]
 Output: "eeebffff"
 Explanation:
 "a" occurs at index 0 in s, so we replace it with "eee".
 "cd" occurs at index 2 in s, so we replace it with "ffff".
 
 Example 2:

 Input: s = "abcd", indices = [0, 2], sources = ["ab","ec"], targets = ["eee","ffff"]
 Output: "eeecd"
 Explanation:
 "ab" occurs at index 0 in s, so we replace it with "eee".
 "ec" does not occur at index 2 in s, so we do nothing.
  
 Constraints:

 1 <= s.length <= 1000
 k == indices.length == sources.length == targets.length
 1 <= k <= 100
 0 <= indexes[i] < s.length
 1 <= sources[i].length, targets[i].length <= 50
 s consists of only lowercase English letters.
 sources[i] and targets[i] consist of only lowercase English letters.
 
 */

import Foundation

// Accepted. Speed: O(N), Space: O(N)
class Solution {
    func findReplaceString(_ s: String, _ indices: [Int], _ sources: [String], _ targets: [String]) -> String {
        var output = s
        let k = indices.count
        let sortedIndices = zip(indices, indices.indices).sorted { $0.0 < $1.0 }
        var diff = 0
        for i in 0..<k {
            let offset = sortedIndices[i].0
            let src = sources[sortedIndices[i].1]
            let trg = targets[sortedIndices[i].1]
            let srcLen = src.count
            if offset > s.count || offset + srcLen > s.count {
                continue
            }
            let srcRange = s.index(s.startIndex, offsetBy: offset)..<s.index(s.startIndex, offsetBy: offset + srcLen)
            if s[srcRange] == src {
                print("2")
                let outRange = output.index(output.startIndex, offsetBy: offset + diff)..<output.index(output.startIndex, offsetBy: offset + diff + srcLen)
                output.replaceSubrange(outRange, with: trg)
                let trgLen = trg.count
                diff += (trgLen - srcLen)
            }
        }
        return output
    }
}

let s1 = "abcd"
let indices1 = [0, 2]
let sources1 = ["a", "cd"]
let targets1 = ["eee", "ffff"]

let s2 = "abcd"
let indices2 = [0, 2]
let sources2 = ["ab","ec"]
let targets2 = ["eee","ffff"]

let s3 = "vmokgggqzp"
let indices3 = [3,5,1]
let sources3 = ["kg","ggq","mo"]
let targets3 = ["s","so","bfr"]

let s4 = "abcde"
let indices4 = [2,2]
let sources4 = ["cdef","bc"]
let targets4 = ["f","fe"]

let solution = Solution()
//print(solution.findReplaceString(s1, indices1, sources1, targets1))
print(solution.findReplaceString(s2, indices2, sources2, targets2))
print(solution.findReplaceString(s3, indices3, sources3, targets3))
print(solution.findReplaceString(s4, indices4, sources4, targets4))
