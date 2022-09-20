/**
 
 68. Text Justification
 https://leetcode.com/problems/text-justification/
 
 Given an array of strings words and a width maxWidth, format the text such that each line has exactly maxWidth characters and is fully (left and right) justified.

 You should pack your words in a greedy approach; that is, pack as many words as you can in each line. Pad extra spaces ' ' when necessary so that each line has exactly maxWidth characters.

 Extra spaces between words should be distributed as evenly as possible. If the number of spaces on a line does not divide evenly between words, the empty slots on the left will be assigned more spaces than the slots on the right.

 For the last line of text, it should be left-justified, and no extra space is inserted between words.

 Note:

 A word is defined as a character sequence consisting of non-space characters only.
 Each word's length is guaranteed to be greater than 0 and not exceed maxWidth.
 The input array words contains at least one word.
  

 Example 1:

 Input: words = ["This", "is", "an", "example", "of", "text", "justification."], maxWidth = 16
 Output:
 [
    "This    is    an",
    "example  of text",
    "justification.  "
 ]
 
 Example 2:

 Input: words = ["What","must","be","acknowledgment","shall","be"], maxWidth = 16
 Output:
 [
   "What   must   be",
   "acknowledgment  ",
   "shall be        "
 ]
 Explanation: Note that the last line is "shall be    " instead of "shall     be", because the last line must be left-justified instead of fully-justified.
 Note that the second line is also left-justified because it contains only one word.
 
 Example 3:

 Input: words = ["Science","is","what","we","understand","well","enough","to","explain","to","a","computer.","Art","is","everything","else","we","do"], maxWidth = 20
 Output:
 [
   "Science  is  what we",
   "understand      well",
   "enough to explain to",
   "a  computer.  Art is",
   "everything  else  we",
   "do                  "
 ]
  

 Constraints:

 1 <= words.length <= 300
 1 <= words[i].length <= 20
 words[i] consists of only English letters and symbols.
 1 <= maxWidth <= 100
 words[i].length <= maxWidth
 
 */

import Foundation

class Solution {
    private func formWordsLine(_ words: [String]) -> ([String], Int) {
        var wordsLine = [String]()
        var len = 0
        for word in words {
            wordsLine.append(word)
            wordsLine.append(" ")
            len += word.count + 1
        }
        wordsLine.removeLast()
        len -= 1
        return (wordsLine, len)
    }
    
    private func formLine(_ words: [String], _ width: Int) -> String {
        let prep = formWordsLine(words)
        var wordsLine = prep.0
        let len = prep.1
        let spacesNeeded = width - len
        var insertIdx = 1
        var insertedSpaces = 0
        if wordsLine.count == 1 {
            return wordsLine[0].padding(toLength: width, withPad: " ", startingAt: 0)
        } else {
            while insertedSpaces < spacesNeeded {
                if !wordsLine.indices.contains(insertIdx) {
                    insertIdx = 1
                }
                wordsLine[insertIdx] += " "
                insertedSpaces += 1
                insertIdx += 2
            }
            return wordsLine.joined()
        }
    }
    
    private func formLastLine(_ words: [String], _ width: Int) -> String {
        let prep = formWordsLine(words)
        let wordsLine = prep.0
        return wordsLine.joined().padding(toLength: width, withPad: " ", startingAt: 0)
    }
    
    func fullJustify(_ words: [String], _ maxWidth: Int) -> [String] {
        var text = [String]()
        var curr = [String]()
        var currLen = 0
        for i in 0..<words.count {
            let word = words[i]
            if currLen + word.count + curr.count - 1 < maxWidth {
                curr.append(word)
                currLen += word.count
                if i == words.endIndex - 1 {
                    text.append(formLastLine(curr, maxWidth))
                }
            } else {
                text.append(formLine(curr, maxWidth))
                curr = [word]
                currLen = word.count
                if i == words.endIndex - 1 {
                    text.append(formLastLine(curr, maxWidth))
                }
            }
        }

        return text
    }
}

let ex1 = ["This", "is", "an", "example", "of", "text", "justification."]
let mw1 = 16
let ex2 = ["What","must","be","acknowledgment","shall","be"]
let mw2 = 16
let ex3 = ["Science","is","what","we","understand","well","enough","to","explain","to","a","computer.","Art","is","everything","else","we","do"]
let mw3 = 20

let solution = Solution()
print(solution.fullJustify(ex1, mw1))
print(solution.fullJustify(ex2, mw2))
print(solution.fullJustify(ex3, mw3))
