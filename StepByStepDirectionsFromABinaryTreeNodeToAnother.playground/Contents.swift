/**

 2096. Step-By-Step Directions From a Binary Tree Node to Another
 
 You are given the root of a binary tree with n nodes. Each node is uniquely assigned a value from 1 to n. You are also given an integer startValue representing the value of the start node s, and a different integer destValue representing the value of the destination node t.

 Find the shortest path starting from node s and ending at node t. Generate step-by-step directions of such path as a string consisting of only the uppercase letters 'L', 'R', and 'U'. Each letter indicates a specific direction:

 'L' means to go from a node to its left child node.
 'R' means to go from a node to its right child node.
 'U' means to go from a node to its parent node.
 Return the step-by-step directions of the shortest path from node s to node t.
 
 Example 1:
 
 Input: root = [5,1,2,3,null,6,4], startValue = 3, destValue = 6
 Output: "UURL"
 Explanation: The shortest path is: 3 → 1 → 5 → 2 → 6.
 
 Example 2:
 
 Input: root = [2,1], startValue = 2, destValue = 1
 Output: "L"
 Explanation: The shortest path is: 2 → 1.
 
 Constraints:

 The number of nodes in the tree is n.
 2 <= n <= 10^5
 1 <= Node.val <= n
 All the values in the tree are unique.
 1 <= startValue, destValue <= n
 startValue != destValue
 
 */

import Foundation

class TreeNode {
  var val: Int
  var left: TreeNode?
  var right: TreeNode?
  
  init() {
    self.val = 0
  }
  
  init(val: Int) {
    self.val = val
  }
  
  init(val: Int, left: TreeNode?, right: TreeNode?) {
    self.val = val
    self.left = left
    self.right = right
  }
}

let sample1 = TreeNode(val: 5,
                       left: TreeNode(val: 1,
                                      left: TreeNode(val: 3),
                                      right: nil),
                       right: TreeNode(val: 2,
                                       left: TreeNode(val: 6),
                                       right: TreeNode(val: 4)))

let sample2 = TreeNode(val: 2, left: TreeNode(val: 1), right: nil)

let sample3 = TreeNode(val: 1,
                       left: nil,
                       right: TreeNode(val: 10,
                                       left: TreeNode(val: 12,
                                                      left: TreeNode(val: 4),
                                                      right: TreeNode(val: 6)),
                                       right: TreeNode(val: 13,
                                                       left: nil,
                                                       right: TreeNode(val: 15,
                                                                       left: TreeNode(val: 5,
                                                                                      left: nil,
                                                                                      right: TreeNode(val: 2,
                                                                                                      left: nil,
                                                                                                      right: TreeNode(val: 8,
                                                                                                                      left: TreeNode(val: 3),
                                                                                                                      right: nil)
                                                                                                     )
                                                                                     ),
                                                                       right: TreeNode(val: 11,
                                                                                       left: TreeNode(val: 14),
                                                                                       right: TreeNode(val: 7,
                                                                                                       left: nil,
                                                                                                       right: TreeNode(val: 9)
                                                                                                      )
                                                                                      )
                                                                      )
                                                      )
                                       )
                       )

// Speed: O(N). Size: O(N)
class Solution {
  
  typealias PathFromLCA = (Int, Character)
  
  private var lcaToStart: [PathFromLCA] = []
  private var lcaToDest: [PathFromLCA] = []
  
  private func findLCA(curr: TreeNode, lastDirection: Character, target: Int, path: inout [PathFromLCA]) -> Bool {
    path.append((curr.val, lastDirection))
    
    if curr.val == target {
      return true
    }
    
    if let left = curr.left, findLCA(curr: left, lastDirection: "L", target: target, path: &path) {
      return true
    }
    
    if let right = curr.right, findLCA(curr: right, lastDirection: "R", target: target, path: &path) {
      return true
    }
    
    path.removeLast()
    return false
  }
  
  private func getDirections(_ path: [PathFromLCA]) -> String {
    String(path.map { $0.1 }).trimmingCharacters(in: .whitespacesAndNewlines)
  }
  
  func getDirections(_ root: TreeNode?, _ startValue: Int, _ destValue: Int) -> String {
    guard let root = root else { return "" }
    
    lcaToStart = []
    lcaToDest = []
    guard findLCA(curr: root, lastDirection: " ", target: startValue, path: &lcaToStart),
          findLCA(curr: root, lastDirection: " ", target: destValue, path: &lcaToDest) else {
      return ""
    }
    
    if let startIndexInDestLCA = (lcaToDest.firstIndex { $0.0 == startValue }) {
      // Case 1: Start is parent of Dest
      return String(String((lcaToDest[startIndexInDestLCA..<lcaToDest.endIndex].map { $0.1 })).dropFirst())
    } else if let destIndexInStartLCA = (lcaToStart.firstIndex { $0.0 == destValue } ) {
      // Case 2: Dest is parent of Start
      return String(repeating: "U", count: lcaToStart.count - destIndexInStartLCA - 1)
    } else {
      // Case 3: Start and Dest has LCA
      var lcaIndex = 0
      while lcaIndex < min(lcaToStart.count, lcaToDest.count) && lcaToStart[lcaIndex] == lcaToDest[lcaIndex] {
        lcaIndex += 1
      }
      return String(repeating: "U", count: lcaToStart.count - lcaIndex) + String((lcaToDest.map { $0.1 }).dropFirst(lcaIndex))
    }
  }
}

let solution = Solution()
print(solution.getDirections(sample1, 3, 6))
print(solution.getDirections(sample2, 2, 1))
print(solution.getDirections(sample2, 1, 2))
print(solution.getDirections(sample3, 6, 15))
