/**
 
 2128. Remove All Ones With Row and Column Flips
 
 https://leetcode.com/problems/remove-all-ones-with-row-and-column-flips/
 
 ou are given an m x n binary matrix grid.

 In one operation, you can choose any row or column and flip each value in that row or column (i.e., changing all 0's to 1's, and all 1's to 0's).

 Return true if it is possible to remove all 1's from grid using any number of operations or false otherwise.

  

 Example 1:


 Input: grid = [[0,1,0],[1,0,1],[0,1,0]]
 Output: true
 Explanation: One possible way to remove all 1's from grid is to:
 - Flip the middle row
 - Flip the middle column
 
 Example 2:


 Input: grid = [[1,1,0],[0,0,0],[0,0,0]]
 Output: false
 Explanation: It is impossible to remove all 1's from grid.
 
 Example 3:


 Input: grid = [[0]]
 Output: true
 Explanation: There are no 1's in grid.
  

 Constraints:

 m == grid.length
 n == grid[i].length
 1 <= m, n <= 300
 grid[i][j] is either 0 or 1.
 */

import Foundation

// Every row should match a first one, or a first one "inverted". So, we could flip them with a column eliminator
class Solution {
    // Speed: O(N*M), Size: O(N*M)
    func removeOnes(_ grid: [[Int]]) -> Bool {
        guard grid.count > 1 else { return true }

        let pattern = grid[0]
        let patternReversed = pattern.map { $0 == 0 ? 1 : 0 }

        for i in 1..<grid.count {
            if grid[i] != pattern && grid[i] != patternReversed {
                return false
            }
        }

        return true
    }
}
