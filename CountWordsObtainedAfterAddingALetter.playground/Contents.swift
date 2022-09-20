/**
 2135. Count Words Obtained After Adding a Letter
 https://leetcode.com/problems/count-words-obtained-after-adding-a-letter/
 
 You are given two 0-indexed arrays of strings startWords and targetWords. Each string consists of lowercase English letters only.

 For each string in targetWords, check if it is possible to choose a string from startWords and perform a conversion operation on it to be equal to that from targetWords.

 The conversion operation is described in the following two steps:

 Append any lowercase letter that is not present in the string to its end.
 For example, if the string is "abc", the letters 'd', 'e', or 'y' can be added to it, but not 'a'. If 'd' is added, the resulting string will be "abcd".
 Rearrange the letters of the new string in any arbitrary order.
 For example, "abcd" can be rearranged to "acbd", "bacd", "cbda", and so on. Note that it can also be rearranged to "abcd" itself.
 Return the number of strings in targetWords that can be obtained by performing the operations on any string of startWords.

 Note that you will only be verifying if the string in targetWords can be obtained from a string in startWords by performing the operations. The strings in startWords do not actually change during this process.

  

 Example 1:

 Input: startWords = ["ant","act","tack"], targetWords = ["tack","act","acti"]
 Output: 2
 Explanation:
 - In order to form targetWords[0] = "tack", we use startWords[1] = "act", append 'k' to it, and rearrange "actk" to "tack".
 - There is no string in startWords that can be used to obtain targetWords[1] = "act".
   Note that "act" does exist in startWords, but we must append one letter to the string before rearranging it.
 - In order to form targetWords[2] = "acti", we use startWords[1] = "act", append 'i' to it, and rearrange "acti" to "acti" itself.
 
 Example 2:

 Input: startWords = ["ab","a"], targetWords = ["abc","abcd"]
 Output: 1
 Explanation:
 - In order to form targetWords[0] = "abc", we use startWords[0] = "ab", add 'c' to it, and rearrange it to "abc".
 - There is no string in startWords that can be used to obtain targetWords[1] = "abcd".
  

 Constraints:

 1 <= startWords.length, targetWords.length <= 5 * 10^4
 1 <= startWords[i].length, targetWords[j].length <= 26
 Each string of startWords and targetWords consists of lowercase English letters only.
 No letter occurs more than once in any string of startWords or targetWords.
 
 */

import Foundation

// Size: O(N), Speed: O(NlogN)
class Solution {
    func wordCount(_ startWords: [String], _ targetWords: [String]) -> Int {
        let startWordsSet = Set(startWords.map { String($0.sorted()) })

        var result = 0
        for targetWord in targetWords {
inner:      for i in 0..<targetWord.count {
                var twCopy = String(targetWord.sorted())
                let idx = twCopy.index(twCopy.startIndex, offsetBy: i)
                twCopy.remove(at: idx)
                if startWordsSet.contains(twCopy) {
                    result += 1
                    break inner
                }
            }
        }

        return result
    }
}

let startWords1 = ["ant","act","tack"]
let targetWords1 = ["tack","act","acti"]

let startWords2 = ["ab","a"]
let targetWords2 = ["abc","abcd"]

let solution = Solution()
print(solution.wordCount(startWords1, targetWords1))
print(solution.wordCount(startWords2, targetWords2))

// better solution is a bitmask
