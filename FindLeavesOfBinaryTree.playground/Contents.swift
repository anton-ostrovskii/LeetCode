/**
366. Find Leaves of Binary Tree
 https://leetcode.com/problems/find-leaves-of-binary-tree/
 
 Given the root of a binary tree, collect a tree's nodes as if you were doing this:
 Collect all the leaf nodes.
 Remove all the leaf nodes.
 Repeat until the tree is empty.

 Example 1:
 Input: root = [1,2,3,4,5]
 Output: [[4,5,3],[2],[1]]
 Explanation:
 [[3,5,4],[2],[1]] and [[3,4,5],[2],[1]] are also considered correct answers since per each level it does not matter the order on which elements are returned.
 
 Example 2:
 Input: root = [1]
 Output: [[1]]
 
 Constraints:
 The number of nodes in the tree is in the range [1, 100].
 -100 <= Node.val <= 100
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

let ex1 = TreeNode(1, TreeNode(2, TreeNode(4), TreeNode(5)), TreeNode(3))
let ex2 = TreeNode(1)
let ex3: TreeNode? = nil

func printLeaves(_ node: TreeNode?) {
    guard let node = node else { return }
    printLeaves(node.left)
    printLeaves(node.right)
    if node.left == nil && node.right == nil {
        print(node.val)
    }
}

// Complexity: Speed: O(N), Memory: O(N)
func findLeavesSimple(_ root: TreeNode?) -> [[Int]] {
    var result: [[Int]] = []
    
    func trim(_ node: TreeNode?, parent: TreeNode?) -> [Int] {
        var trimmed: [Int] = []
        guard let node = node else { return trimmed }
        if node.left == nil && node.right == nil {
            trimmed.append(node.val)
            if parent?.left === node {
                parent?.left = nil
            } else {
                parent?.right = nil
            }
        } else {
            trimmed.append(contentsOf: trim(node.left, parent: node))
            trimmed.append(contentsOf: trim(node.right, parent: node))
        }
        return trimmed
    }
    
    while (root?.left != nil || root?.right != nil) {
        let trimmed = trim(root, parent: nil)
        if !trimmed.isEmpty {
            result.append(trimmed)
        }
    }
    
    if let rootVal = root?.val {
        result.append([rootVal])
    }
    
    return result
}

//print(findLeavesSimple(ex1))
//print(findLeavesSimple(ex2))
//print(findLeavesSimple(ex3))

// Complexity: Speed: O(NlogN), Memory: O(N)
func findLeavesDFSSorting(_ root: TreeNode?) -> [[Int]] {
    var result: [[Int]] = []
    
    var pairs: [(height: Int, val: Int)] = []
    @discardableResult func getHeight(_ node: TreeNode?) -> Int {
        guard let node = node else { return -1 }
        
        let height = 1 + max(getHeight(node.left), getHeight(node.right))
        pairs.append((height, node.val))
        
        return height
    }
    
    getHeight(root)
    pairs.sort { $0.height < $1.height }
    
    var currHeight = 0
    var i = 0
    while i < pairs.count {
        var partial: [Int] = []
        while i < pairs.count && pairs[i].height == currHeight {
            partial.append(pairs[i].val)
            i += 1
        }
        result.append(partial)
        currHeight += 1
    }
    
    return result
}

//print(findLeavesDFSSorting(ex1))
//print(findLeavesDFSSorting(ex2))
//print(findLeavesDFSSorting(ex3))

// Complexity: Speed: O(N), Memory: O(N)
func findLeavesDFSNoSorting(_ root: TreeNode?) -> [[Int]] {
    var result: [[Int]] = []
    
    @discardableResult func getHeight(_ node: TreeNode?) -> Int {
        guard let node = node else { return -1 }
        
        let height = 1 + max(getHeight(node.left), getHeight(node.right))
        
        if result.count == height {
            result.append([])
        }
        
        result[height].append(node.val)
        
        return height
    }
    
    getHeight(root)
    
    return result
}

print(findLeavesDFSNoSorting(ex1))
print(findLeavesDFSNoSorting(ex2))
print(findLeavesDFSNoSorting(ex3))
