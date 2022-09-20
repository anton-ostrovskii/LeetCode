/**
 715. Range Module
 
 https://leetcode.com/problems/range-module/
 
 A Range Module is a module that tracks ranges of numbers. Design a data structure to track the ranges represented as half-open intervals and query about them.

 A half-open interval [left, right) denotes all the real numbers x where left <= x < right.

 Implement the RangeModule class:

 RangeModule() Initializes the object of the data structure.
 void addRange(int left, int right) Adds the half-open interval [left, right), tracking every real number in that interval. Adding an interval that partially overlaps with currently tracked numbers should add any numbers in the interval [left, right) that are not already tracked.
 boolean queryRange(int left, int right) Returns true if every real number in the interval [left, right) is currently being tracked, and false otherwise.
 void removeRange(int left, int right) Stops tracking every real number currently being tracked in the half-open interval [left, right).
  

 Example 1:

 Input:
 ["RangeModule", "addRange", "removeRange", "queryRange", "queryRange", "queryRange"]
 [[], [10, 20], [14, 16], [10, 14], [13, 15], [16, 17]]
 
 Output:
 [null, null, null, true, false, true]

 Explanation:
 RangeModule rangeModule = new RangeModule();
 rangeModule.addRange(10, 20);
 rangeModule.removeRange(14, 16);
 rangeModule.queryRange(10, 14); // return True,(Every number in [10, 14) is being tracked)
 rangeModule.queryRange(13, 15); // return False,(Numbers like 14, 14.03, 14.17 in [13, 15) are not being tracked)
 rangeModule.queryRange(16, 17); // return True, (The number 16 in [16, 17) is still being tracked, despite the remove operation)
  

 Constraints:

 1 <= left < right <= 10^9
 At most 10^4 calls will be made to addRange, queryRange, and removeRange.
 */

import Foundation

// memory limit exceeded
class RangeModuleSimple {

    init() {
        
    }

    private var data = Array(repeating: false, count: 1_000_000_000)

    func addRange(_ left: Int, _ right: Int) {
        for i in left..<right {
            data[i] = true
        }
    }
    
    func queryRange(_ left: Int, _ right: Int) -> Bool {
        for i in left..<right where !data[i] {
            return false
        }
        return true
    }
    
    func removeRange(_ left: Int, _ right: Int) {
        for i in left..<right {
            data[i] = false
        }
    }
}

class RangeModuleOptimized {
    
    class SegmentTree {
        class Node {
            var start: Int  // including
            var end: Int    // excluding
            var state: Bool
            var left: Node?
            var right: Node?
            init(start: Int, end: Int, state: Bool) {
                self.start = start
                self.end = end
                self.state = state
            }
        }

        private var root: Node = Node(start: 0, end: 1_000_000_000, state: false)

        // should always be taken from the node's start/end, not input params
        private func mid(_ start: Int, _ end: Int) -> Int {
            start + (end - start) / 2
        }

        func update(start: Int, end: Int, state: Bool) {
            update(node: root, start: start, end: end, state: state)
        }

        private func update(node: Node?, start: Int, end: Int, state: Bool) {
            guard let node = node else { return }

            // First check if we're updating the current segment
            if node.start == start && node.end == end {
                node.state = state
                node.left = nil     // cut leafs since we set a current segment
                node.right = nil    // cut leafs since we set a current segment
            } else {
                let mid = mid(node.start, node.end)

                if node.left == nil {
                    node.left = Node(start: node.start, end: mid, state: node.state) // curr node state set here
                    node.right = Node(start: mid + 1, end: node.end, state: node.state) // curr node state set here
                }

                if mid < start {
                    update(node: node.right, start: start, end: end, state: state) // full range here
                } else if mid + 1 > end {
                    update(node: node.left, start: start, end: end, state: state) // full range here
                } else {
                    // partial ranges here
                    update(node: node.left, start: start, end: mid, state: state)
                    update(node: node.right, start: mid + 1, end: end, state: state)
                }
                node.state = (node.left?.state ?? false) && (node.right?.state ?? false)
            }
        }

        func search(start: Int, end: Int) -> Bool {
            search(node: root, start: start, end: end)
        }

        private func search(node: Node?, start: Int, end: Int) -> Bool {
            guard let node = node else { return false }
            if node.left == nil || node.start == start && node.end == end {
                // if we canot split anymore, or if we're in the current range - return current state
                return node.state
            } else {
                let mid = mid(node.start, node.end)
                if mid < start {
                    return search(node: node.right, start: start, end: end)  // full range
                } else if mid + 1 > end {
                    return search(node: node.left, start: start, end: end)  // full range
                } else {
                    return search(node: node.left, start: start, end: mid) && search(node: node.right, start: mid + 1, end: end)
                }
            }
        }
    }

    private let tree = SegmentTree()

    init() {
        
    }
    
    func addRange(_ left: Int, _ right: Int) {
        tree.update(start: left, end: right - 1, state: true)
    }
    
    func queryRange(_ left: Int, _ right: Int) -> Bool {
        tree.search(start: left, end: right - 1)
    }
    
    func removeRange(_ left: Int, _ right: Int) {
        tree.update(start: left, end: right - 1, state: false)
    }
}

let solution = RangeModuleOptimized()
solution.addRange(10, 20)
solution.removeRange(14, 16)
print(solution.queryRange(10, 14))
print(solution.queryRange(13, 15))
print(solution.queryRange(16, 17))

/**
 * Your RangeModule object will be instantiated and called as such:
 * let obj = RangeModule()
 * obj.addRange(left, right)
 * let ret_2: Bool = obj.queryRange(left, right)
 * obj.removeRange(left, right)
 */

