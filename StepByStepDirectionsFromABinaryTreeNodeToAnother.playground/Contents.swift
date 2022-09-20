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

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

class Solution {
    
    /*class Path {
        private var path: [[Int : String]] = []
        
        func
    }*/
    
    typealias state = (val: Int, step:String)
    
    func findPath(to val: Int, root: TreeNode?) -> [state] {
        guard let root = root else { return [] }
        
        func find(curr: TreeNode, path: inout [state]) -> [state]? {
            if curr.val == val {
                path.append((val, ""))
                return path
            } else {
                if let left = curr.left {
                    path.append((left.val, "L"))
                    return find(curr: left, path: &path)
                }
                if let right = curr.right {
                    path.append((right.val, "R"))
                    return find(curr: right, path: &path)
                }
            }
            return nil
        }
        
        var path: [state] = []
        return find(curr: root, path: &<#T##[Solution.state]#>)
    }
    
    func getDirections(_ root: TreeNode?, _ startValue: Int, _ destValue: Int) -> String {
        
        
        
        fatalError()
    }
}

var root1 = TreeNode(5)
root1.left = TreeNode(1, TreeNode(3), nil)
root1.right = TreeNode(2, TreeNode(6), TreeNode(4))


