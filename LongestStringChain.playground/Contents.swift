/**

 

 1048. Longest String Chain

 

 https://leetcode.com/problems/longest-string-chain/

 

 You are given an array of words where each word consists of lowercase English letters.



 wordA is a predecessor of wordB if and only if we can insert exactly one letter anywhere in wordA without changing the order of the other characters to make it equal to wordB.



 For example, "abc" is a predecessor of "abac", while "cba" is not a predecessor of "bcad".

 A word chain is a sequence of words [word1, word2, ..., wordk] with k >= 1, where word1 is a predecessor of word2, word2 is a predecessor of word3, and so on. A single word is trivially a word chain with k == 1.



 Return the length of the longest possible word chain with words chosen from the given list of words.



  



 Example 1:



 Input: words = ["a","b","ba","bca","bda","bdca"]

 Output: 4

 Explanation: One of the longest word chains is ["a","ba","bda","bdca"].

 Example 2:



 Input: words = ["xbc","pcxbcf","xb","cxbc","pcxbc"]

 Output: 5

 Explanation: All the words can be put in a word chain ["xb", "xbc", "cxbc", "pcxbc", "pcxbcf"].

 Example 3:



 Input: words = ["abcd","dbqca"]

 Output: 1

 Explanation: The trivial word chain ["abcd"] is one of the longest word chains.

 ["abcd","dbqca"] is not a valid word chain because the ordering of the letters is changed.

  



 Constraints:



 1 <= words.length <= 1000

 1 <= words[i].length <= 16

 words[i] only consists of lowercase English letters.

 

 */





import Foundation



let example1 = ["a","b","ba","bca","bda","bdca"]

let example2 = ["xbc","pcxbcf","xb","cxbc","pcxbc"]

let example3 = ["abcd","dbqca"]

let example4 = ["a","ab","ac","bd","abc","abd","abdd"]



class Solution {

    // Space: O(N), Speed: O(L^2 * N)   L - max word length, N - number of words

    func longestStrChain(_ words: [String]) -> Int {

        let wordsSet = Set(words)

        var sequences = [String:Int]()

        

        func getChainLength(from word: String) -> Int {

            if let len = sequences[word] {

                return len

            }



            var maxChain = 1

            for i in 0..<word.count {

                var newWord = word

                newWord.remove(at: newWord.index(newWord.startIndex, offsetBy: i))

                if wordsSet.contains(newWord) {

                    maxChain = max(maxChain, 1 + getChainLength(from: newWord))

                }

            }

            sequences[word] = maxChain

            return maxChain

        }



        var maxChain = 0

        for word in wordsSet {

            maxChain = max(maxChain, getChainLength(from: word))

        }



        return maxChain

    }

}



let solution = Solution()

print(solution.longestStrChain(example1))

print(solution.longestStrChain(example2))

print(solution.longestStrChain(example3))

print(solution.longestStrChain(example4))
