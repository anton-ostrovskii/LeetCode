/**

 Design and implement an effiient algorithm to search for a given integer x in
 a 2-dimensional sorted array a[0..m][0..n]. Please note that it is sorted ro-wise
 and column-wise in ascending order.
 
 Solution: saddleback search
 */

import Foundation

// First - row, then - column

let input = [[2, 2, 3, 5],
             [3, 4, 5, 6],
             [3, 5, 6, 8],
             [3, 6, 7, 9]]

let m = 4   // number of rows
let n = 4   // number of columns

// Space complexity O(N), time complexity: O(n+m)
func search(a: [[Int]], m: Int, n: Int, x: Int) -> (Int, Int) {
    var i = 0
    var j = n - 1
    while i < m && j >= 0 {
        if a[i][j] == x {
            return (i, j)
        } else if a[i][j] < x {
            i = i + 1
        } else {
            j = j - 1
        }
    }
    return (-1, -1)
}

print(search(a: input, m: m, n: n, x: 6))
