/**
 562. Longest Line of Consecutive One in Matrix
 https://leetcode.com/problems/longest-line-of-consecutive-one-in-matrix/
 
 Given an m x n binary matrix mat, return the length of the longest line of consecutive one in the matrix.

 The line could be horizontal, vertical, diagonal, or anti-diagonal.

  
 Example 1:

 Input: mat = [[0,1,1,0],[0,1,1,0],[0,0,0,1]]
 Output: 3
 
 Example 2:

 Input: mat = [[1,1,1,1],[0,1,1,0],[0,0,0,1]]
 Output: 4
  
 Constraints:

 m == mat.length
 n == mat[i].length
 1 <= m, n <= 10^4
 1 <= m * n <= 10^4
 mat[i][j] is either 0 or 1.
 */

import Foundation

// Speed: O(1), Complexity: O(m*n)
class Solution {
    func longestLine(_ mat: [[Int]]) -> Int {

        var maxLen = 0

        struct State {
            var rowChecked = false
            var columnChecked = false
            var mainDiagonalChecked = false
            var subDiagonalChecked = false

            var checked: Bool { rowChecked && columnChecked && mainDiagonalChecked && subDiagonalChecked }
        }

        let rows = mat.count
        let cols = mat[0].count
        var states: [[State]] = Array(repeating: Array(repeating: State(), count: cols), count: rows)

        func checkRow(_ r: Int, _ c: Int) {
            var len = 0
            for ci in c..<cols {
                if mat[r][ci] == 1 {
                    states[r][ci].rowChecked = true
                    len += 1
                } else {
                    break
                }
            }
            maxLen = max(maxLen, len)
        }

        func checkCol(_ r: Int, _ c: Int) {
            var len = 0
            for ri in r..<rows {
                if mat[ri][c] == 1 {
                    states[ri][c].columnChecked = true
                    len += 1
                } else {
                    break
                }
            }
            maxLen = max(maxLen, len)
        }

        func chekMainDiagonal(_ r: Int, _ c: Int) {
            var len = 0
            for (ri, ci) in zip(r..<rows, c..<cols) {
                if mat[ri][ci] == 1 {
                    states[ri][ci].mainDiagonalChecked = true
                    len += 1
                } else {
                    break
                }
            }
            maxLen = max(maxLen, len)
        }

        func chekSubDiagonal(_ r: Int, _ c: Int) {
            var len = 0
            for (ri, ci) in zip(r..<rows, (0...c).reversed()) {
                if mat[ri][ci] == 1 {
                    states[ri][ci].subDiagonalChecked = true
                    len += 1
                } else {
                    break
                }
            }
            maxLen = max(maxLen, len)
        }

        for ri in 0..<rows {
            for ci in 0..<cols {
                if mat[ri][ci] == 1 {
                    if !states[ri][ci].rowChecked {
                        checkRow(ri, ci)
                    }
                    if !states[ri][ci].columnChecked {
                        checkCol(ri, ci)
                    }
                    if !states[ri][ci].mainDiagonalChecked {
                        chekMainDiagonal(ri, ci)
                    }
                    if !states[ri][ci].subDiagonalChecked {
                        chekSubDiagonal(ri, ci)
                    }
                }
            }
        }

        return maxLen
    }
}

let mat1 = [[0,1,1,0],[0,1,1,0],[0,0,0,1]]
let mat2 = [[1,1,1,1],[0,1,1,0],[0,0,0,1]]
let mat3 = [[0,1,0,1,1],[1,1,0,0,1],[0,0,0,1,0],[1,0,1,1,1],[1,0,0,0,1]]

let solution = Solution()
print(solution.longestLine(mat1))
print(solution.longestLine(mat2))
print(solution.longestLine(mat3))

