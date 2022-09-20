import Foundation

/**
 Find the lower common ancestor (aka lca), i.e., ancestor with maximal depth,
 of a pair of nodes in a rooted tree.
 */

// Common code - simple Integer binary tree
class Node {
    let val: Int
    var left: Node?
    var right: Node?
    
    init(_ v: Int, left: Node? = nil, right: Node? = nil) {
        self.val = v
        self.left = left
        self.right = right
    }
}

// Test Tree
let root = Node(1,
                left: Node(2,
                           left: Node(4),
                           right: Node(5,
                                       left: Node(8),
                                       right: Node(9))),
                right: Node(3,
                            left: Node(6),
                            right: Node(7)))

// Simplest approach. Find paths to both nodes into 2 arrays. Look on first node missmatch in arrays and return a previous one
// Speed: O(N), Space: O(N)
// We are also making sure that both node exists in the tree
class SimpleLCAFinder {
    private var pathN1: [Int] = []
    private var pathN2: [Int] = []
    
    private func reset() {
        self.pathN1.removeAll()
        self.pathN2.removeAll()
    }
    
    private func findPath(root: Node, val: Int, path: inout [Int]) -> Bool {
        path.append(root.val)
        
        if root.val == val {
            return true
        }
        
        if let left = root.left, findPath(root: left, val: val, path: &path) {
            return true
        }
        
        if let right = root.right, findPath(root: right, val: val, path: &path) {
            return true
        }
        
        path.removeLast()
        return false
    }
    
    func findLCA(root: Node, n1: Int, n2: Int) -> Int? {
        self.reset()
        
        guard self.findPath(root: root, val: n1, path: &pathN1),
              self.findPath(root: root, val: n2, path: &pathN2) else {
            return nil
        }
        
        var i: Int = 0
        while i < min(pathN1.indices.endIndex, pathN2.indices.endIndex) && pathN1[i] == pathN2[i] {
            i += 1
        }
        
        return pathN1[i-1]
    }
}

print("SimpleLCAFinder")
let slcaFinder = SimpleLCAFinder()
print(slcaFinder.findLCA(root: root, n1: 4, n2: 9))
print(slcaFinder.findLCA(root: root, n1: 2, n2: 5))
print(slcaFinder.findLCA(root: root, n1: 5, n2: 7))

// Optimized solution with a single traverse
// Speed O(N), Space O(1)
// We are going through the tree one time recursively
class SingleTraverseLCAFinder {
    private func _findLCA(node: Node?, n1: Int, n2: Int) -> Node? {
        guard let node = node else { return nil }
        
        if [n1, n2].contains(node.val) { return node }
        
        let leftLCA = _findLCA(node: node.left, n1: n1, n2: n2)
        let rightLCA = _findLCA(node: node.right, n1: n1, n2: n2)
        
        if leftLCA != nil && rightLCA != nil {
            return node
        }
        
        return leftLCA != nil ? leftLCA : rightLCA
    }
    
    func findLCA(root: Node, n1: Int, n2: Int) -> Int? {
        _findLCA(node: root, n1: n1, n2: n2)?.val
    }
}

print("SingleTraverseLCAFinder")
let stFinder = SingleTraverseLCAFinder()
print(stFinder.findLCA(root: root, n1: 4, n2: 9))
print(stFinder.findLCA(root: root, n1: 2, n2: 5))
print(stFinder.findLCA(root: root, n1: 5, n2: 7))






// Remind both algorithms

class RRSimpleLCAFinder {
    private var pathN1: [Int] = []
    private var pathN2: [Int] = []
    
    private func reset() {
        pathN1.removeAll()
        pathN2.removeAll()
    }
    
    private func findPath(curr: Node, n: Int, path: inout [Int]) -> Bool {
        path.append(curr.val)
        
        if curr.val == n {
            return true
        }
        
        if let ln = curr.left, findPath(curr: ln, n: n, path: &path) {
            return true
        }
        
        if let rn = curr.right, findPath(curr: rn, n: n, path: &path) {
            return true
        }
        
        path.removeLast()
        return false
    }
    
    func findLCA(root: Node, n1: Int, n2: Int) -> Int? {
        reset()
        guard findPath(curr: root, n: n1, path: &pathN1) else { return nil }
        guard findPath(curr: root, n: n2, path: &pathN2) else { return nil }
        
        var idx: Int = 0
        while idx < min(pathN1.indices.endIndex, pathN2.indices.endIndex) && pathN1[idx] == pathN2[idx] {
            idx += 1
        }
        
        return pathN1[idx-1]
    }
}

print("RRSimpleLCAFinder")
let rrSimpleLCA = RRSimpleLCAFinder()
print(rrSimpleLCA.findLCA(root: root, n1: 4, n2: 9))
print(rrSimpleLCA.findLCA(root: root, n1: 2, n2: 5))
print(rrSimpleLCA.findLCA(root: root, n1: 5, n2: 7))


class RROptimizedSingleTraceLCAFinder {
    func findLCA(root: Node?, n1: Int, n2: Int) -> Node? {
        guard let node = root else { return nil }
        
        if [n1, n2].contains(node.val) {
            return node
        }
        
        let left = findLCA(root: node.left, n1: n1, n2: n2)
        let right = findLCA(root: node.right, n1: n1, n2: n2)
        
        if left != nil && right != nil {
            return node
        }
        
        return left != nil ? left : right
    }
}

print("RROptimizedSingleTraceLCAFinder")
let rrOptimizedLCA = RROptimizedSingleTraceLCAFinder()
print(rrOptimizedLCA.findLCA(root: root, n1: 4, n2: 9)?.val)
print(rrOptimizedLCA.findLCA(root: root, n1: 2, n2: 5)?.val)
print(rrOptimizedLCA.findLCA(root: root, n1: 5, n2: 7)?.val)

