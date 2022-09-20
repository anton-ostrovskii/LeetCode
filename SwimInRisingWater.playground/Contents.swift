/**
 778. Swim in Rising Water
 https://leetcode.com/problems/swim-in-rising-water/
 
 You are given an n x n integer matrix grid where each value grid[i][j] represents the elevation at that point (i, j).

 The rain starts to fall. At time t, the depth of the water everywhere is t. You can swim from a square to another 4-directionally adjacent square if and only if the elevation of both squares individually are at most t. You can swim infinite distances in zero time. Of course, you must stay within the boundaries of the grid during your swim.

 Return the least time until you can reach the bottom right square (n - 1, n - 1) if you start at the top left square (0, 0).

  

 Example 1:


 Input: grid = [[0,2],[1,3]]
 Output: 3
 Explanation:
 At time 0, you are in grid location (0, 0).
 You cannot go anywhere else because 4-directionally adjacent neighbors have a higher elevation than t = 0.
 You cannot reach point (1, 1) until time 3.
 When the depth of water is 3, we can swim anywhere inside the grid.
 
 Example 2:

 Input: grid = [[0,1,2,3,4],[24,23,22,21,5],[12,13,14,15,16],[11,17,18,19,20],[10,9,8,7,6]]
 Output: 16
 Explanation: The final route is shown.
 We need to wait until time 16 so that (0, 0) and (4, 4) are connected.
  

 Constraints:

 n == grid.length
 n == grid[i].length
 1 <= n <= 50
 0 <= grid[i][j] < n^2
 Each value grid[i][j] is unique.
 */

import Foundation

// Size: O(N), Speed: O(N*N)
class Solution {
    func swimInWater(_ grid: [[Int]]) -> Int {
        let n = grid.count
        var depths: [[Int]] = Array(repeating: Array(repeating: -1, count: n), count: n)

        func check(_ i: Int, _ j: Int, maxDepth: Int) {
            func checkNext(_ newMaxDepth: Int) {
                guard !(i == n - 1 && j == n - 1) else { return }

                let ii = [-1, 0, 1, 0]
                let jj = [0, -1, 0, 1]
                for k in 0..<4 {
                    let newI = i + ii[k]
                    let newJ = j + jj[k]
                    if newI >= 0 && newI < n && newJ >= 0 && newJ < n {
                        check(newI, newJ, maxDepth: newMaxDepth)
                    }
                }
            }

            if depths[i][j] == -1 {
                depths[i][j] = max(grid[i][j], maxDepth)
                checkNext(depths[i][j])
            } else if depths[i][j] > maxDepth {
                let depth = max(maxDepth, grid[i][j])
                if depth < depths[i][j] {
                    depths[i][j] = depth
                    checkNext(depth)
                }
            }
        }

        check(0, 0, maxDepth: grid[0][0])

        return depths[n-1][n-1]
    }
}

let grid1 = [[0,2],[1,3]]
let grid2 = [[0,1,2,3,4],[24,23,22,21,5],[12,13,14,15,16],[11,17,18,19,20],[10,9,8,7,6]]

let solution = Solution()
print(solution.swimInWater(grid1))
print(solution.swimInWater(grid2))
