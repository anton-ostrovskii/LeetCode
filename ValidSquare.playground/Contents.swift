/**

 https://leetcode.com/problems/valid-square/
 
 Given the coordinates of four points in 2D space p1, p2, p3 and p4, return true if the four points construct a square.

 The coordinate of a point pi is represented as [xi, yi]. The input is not given in any order.

 A valid square has four equal sides with positive length and four equal angles (90-degree angles).

 Example 1:

 Input: p1 = [0,0], p2 = [1,1], p3 = [1,0], p4 = [0,1]
 Output: true
 
 Example 2:

 Input: p1 = [0,0], p2 = [1,1], p3 = [1,0], p4 = [0,12]
 Output: false
 
 Example 3:

 Input: p1 = [1,0], p2 = [-1,0], p3 = [0,1], p4 = [0,-1]
 Output: true
  

 Constraints:

 p1.length == p2.length == p3.length == p4.length == 2
 -10^4 <= xi, yi <= 10^4
 
 */

import Foundation

let ex1p1: [Int] = [0,0]
let ex1p2: [Int] = [1,1]
let ex1p3: [Int] = [1,0]
let ex1p4: [Int] = [0,1]

let ex2p1: [Int] = [0,0]
let ex2p2: [Int] = [1,1]
let ex2p3: [Int] = [1,0]
let ex2p4: [Int] = [0,12]

let ex3p1: [Int] = [1, 0]
let ex3p2: [Int] = [-1, 0]
let ex3p3: [Int] = [0, 1]
let ex3p4: [Int] = [0, -1]

let ex4p1: [Int] = [0,1]
let ex4p2: [Int] = [1,2]
let ex4p3: [Int] = [0,2]
let ex4p4: [Int] = [0,0]

// Complexity: O(1), space: O(1)
class SimpleSolution {
    func validSquare(_ p1: [Int], _ p2: [Int], _ p3: [Int], _ p4: [Int]) -> Bool {
        func distance(_ point1: [Int], _ point2: [Int]) -> Double {
            return sqrt(pow(Double(point1[0] - point2[0]), 2) + pow(Double(point1[1] - point2[1]), 2))
        }
        
        func oneLine(_ v1: [Int], _ v2: [Int], _ v3: [Int]) -> Bool {
            return (v1[1] - v2[1]) * (v1[0] - v3[0]) == (v1[1] - v3[1]) * (v1[0] - v2[0])
        }
        
        if oneLine(p1, p2, p3) || oneLine(p1, p2, p4) || oneLine(p2, p3, p4) {
            return false
        }
        
        var distances: Set<Double> = []
        let dp1p2 = distance(p1, p2)
        let dp1p3 = distance(p1, p3)
        let dp1p4 = distance(p1, p4)
        let dp2p3 = distance(p2, p3)
        let dp2p4 = distance(p2, p4)
        let dp3p4 = distance(p3, p4)
        
        distances.insert(dp1p2)
        distances.insert(dp1p3)
        distances.insert(dp1p4)
        distances.insert(dp2p3)
        distances.insert(dp2p4)
        distances.insert(dp3p4)
        
        return distances.count == 2
    }
}

let simpleSolution = SimpleSolution()
print(simpleSolution.validSquare(ex1p1, ex1p2, ex1p3, ex1p4))
print(simpleSolution.validSquare(ex2p1, ex2p2, ex2p3, ex2p4))
print(simpleSolution.validSquare(ex3p1, ex3p2, ex3p3, ex3p4))
print(simpleSolution.validSquare(ex4p1, ex4p2, ex4p3, ex4p4))
