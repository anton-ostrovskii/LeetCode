/**
 Guess The Word
 
 https://leetcode.com/problems/guess-the-word/
 
 843. Guess the Word

 You are given an array of unique strings words where words[i] is six letters long. One word of words was chosen as a secret word.

 You are also given the helper object Master. You may call Master.guess(word) where word is a six-letter-long string, and it must be from words. Master.guess(word) returns:

 -1 if word is not from words, or
 an integer representing the number of exact matches (value and position) of your guess to the secret word.
 There is a parameter allowedGuesses for each test case where allowedGuesses is the maximum number of times you can call Master.guess(word).

 For each test case, you should call Master.guess with the secret word without exceeding the maximum number of allowed guesses. You will get:

 "Either you took too many guesses, or you did not find the secret word." if you called Master.guess more than allowedGuesses times or if you did not call Master.guess with the secret word, or
 "You guessed the secret word correctly." if you called Master.guess with the secret word with the number of calls to Master.guess less than or equal to allowedGuesses.
 The test cases are generated such that you can guess the secret word with a reasonable strategy (other than using the bruteforce method).

  

 Example 1:

 Input: secret = "acckzz", words = ["acckzz","ccbazz","eiowzz","abcczz"], allowedGuesses = 10
 Output: You guessed the secret word correctly.
 Explanation:
 master.guess("aaaaaa") returns -1, because "aaaaaa" is not in wordlist.
 master.guess("acckzz") returns 6, because "acckzz" is secret and has all 6 matches.
 master.guess("ccbazz") returns 3, because "ccbazz" has 3 matches.
 master.guess("eiowzz") returns 2, because "eiowzz" has 2 matches.
 master.guess("abcczz") returns 4, because "abcczz" has 4 matches.
 We made 5 calls to master.guess, and one of them was the secret, so we pass the test case.
 Example 2:

 Input: secret = "hamada", words = ["hamada","khaled"], allowedGuesses = 10
 Output: You guessed the secret word correctly.
 Explanation: Since there are two words, you can guess both.
  

 Constraints:

 1 <= words.length <= 100
 words[i].length == 6
 words[i] consist of lowercase English letters.
 All the strings of wordlist are unique.
 secret exists in words.
 10 <= allowedGuesses <= 30
 */

import Foundation


// This is the Master's API interface.
// You should not implement it, or speculate about its implementation
class Master {
    public func guess(_ word: String) -> Int {
        0
    }
}

class SimpleSolution {
    // Time exceeded, Complexity O(N^2)
    func findSecretWord(_ words: [String], _ master: Master) {
        var wordsSet = Set<String>(words)
        var word = wordsSet.popFirst()
        while word != nil {
            let guessed = master.guess(word!)
            if guessed == 6 { return }
            if guessed <= 0 {
                word = wordsSet.popFirst()
                continue
            }

            let combs = 6 - guessed + 1
            for i in 0..<combs {
                let startIndex = word!.index(word!.startIndex, offsetBy: i)
                let endIndex = word!.index(startIndex, offsetBy: guessed)
                let pattern = String(word![startIndex..<endIndex])
                let subWords = wordsSet.filter { $0.contains(pattern) }
                let candidate = subWords.first { cand in
                    for j in 0..<combs {
                        let cSI = cand.index(cand.startIndex, offsetBy: j)
                        let cEI = cand.index(cSI, offsetBy: guessed)
                        if pattern == cand[cSI..<cEI] { // regex would be better
                            return true
                        }
                    }
                    return false
                }
                if candidate != nil {
                    word = candidate
                    wordsSet.remove(word!)
                    break
                }
            }
            if word == nil {
                word = wordsSet.popFirst()
            }
        }
    }
}

class Solution {
    // This worked. Optimization - prioritize words with min number of matches with others
    func findSecretWord(_ words: [String], _ master: Master) {
        var wordsSet = Set(words)

        for _ in 0..<10 {
            if let word = wordsSet.randomElement() {
                wordsSet.remove(word)
                let guessed = master.guess(word)
                if guessed == 6 { break }
                if guessed > 0 {
                    wordsSet = wordsSet.filter({ candidate in
                        var matches = 0
                        for i in 0..<6 {
                            if word[word.index(word.startIndex, offsetBy: i)] == candidate[candidate.index(candidate.startIndex, offsetBy: i)] {
                                matches += 1
                            }
                        }
                        return matches == guessed
                    })
                }
            } else {
                break
            }
        }
    }
}
