import Foundation

/**
 You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order, and each of their nodes contains a single digit. Add the two numbers and return the sum as a linked list.

 You may assume the two numbers do not contain any leading zero, except the number 0 itself.
 
 Example 1:
 Input: l1 = [2,4,3], l2 = [5,6,4]
 Output: [7,0,8]
 Explanation: 342 + 465 = 807.
 
 Example 2:
 Input: l1 = [0], l2 = [0]
 Output: [0]
 
 Example 3:
 Input: l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
 Output: [8,9,9,9,0,0,0,1]
 
 Constraints:
 The number of nodes in each linked list is in the range [1, 100].
 0 <= Node.val <= 9
 It is guaranteed that the list represents a number that does not have leading zeros.
 */

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

extension ListNode {
    func toString() -> String {
        var str = ""
        var curr: ListNode? = self
        while curr != nil {
            str += String(curr!.val)
            curr = curr?.next
        }
        return str
    }
}

let ex1L1 = ListNode(2, ListNode(4, ListNode(3)))
let ex1L2 = ListNode(5, ListNode(6, ListNode(4)))

let ex2L1 = ListNode()
let ex2L2 = ListNode()

let ex3L1 = ListNode(9, ListNode(9, ListNode(9, ListNode(9, ListNode(9, ListNode(9, ListNode(9)))))))
let ex3L2 = ListNode(9, ListNode(9, ListNode(9, ListNode(9))))

// Complexity: Speed: O(3*N), Memory: O(N). Unnecessary "align" and "length"
func addTwoNumbersSimple(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    guard var l1 = l1, var l2 = l2 else { return nil }
    
    func length(l: ListNode) -> Int {
        var length = 0
        var current: ListNode? = l
        while current != nil {
            length += 1
            current = current?.next
        }
        return length
    }
    
    func align(l: ListNode, offset: Int) -> ListNode {
        guard offset > 0 else { return l }
        var last: ListNode? = l
        while last?.next != nil {
            last = last?.next
        }
        for _ in 0..<offset {
            let node = ListNode(0)
            last?.next = node
            last = node
        }
        return l
    }
    
    let l1Length = length(l: l1)
    let l2Length = length(l: l2)
    
    if l1Length > l2Length {
        l2 = align(l: l2, offset: l1Length - l2Length)
    } else if l2Length > l1Length {
        l1 = align(l: l1, offset: l2Length - l1Length)
    }
    
    let result = ListNode()
    var carry = false
    var l1Curr: ListNode? = l1
    var l2Curr: ListNode? = l2
    var resultCurr = result
    while (l1Curr != nil && l2Curr != nil) {
        var sum = l1Curr!.val + l2Curr!.val
        if carry {
            sum += 1
        }
        carry = false
        if sum >= 10 {
            carry = true
            sum = sum % 10
        }
        resultCurr.val = sum
        
        l1Curr = l1Curr?.next
        l2Curr = l2Curr?.next
        if (l1Curr != nil && l2Curr != nil) {
            let nextResult = ListNode()
            resultCurr.next = nextResult
            resultCurr = nextResult
        } else if carry {
            let nextResult = ListNode(1)
            resultCurr.next = nextResult
            resultCurr = nextResult
        }
    }
    
    return result
}

print(addTwoNumbersSimple(ex1L1, ex1L2)?.toString())
print(addTwoNumbersSimple(ex2L1, ex2L2)?.toString())
print(addTwoNumbersSimple(ex3L1, ex3L2)?.toString())

// Complexity. Speed: O(max(m,n)). Memory: O(max(m,n))
func addTwoNumbersBetter(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    
}

print(addTwoNumbersBetter(ex1L1, ex1L2)?.toString())
print(addTwoNumbersBetter(ex2L1, ex2L2)?.toString())
print(addTwoNumbersBetter(ex3L1, ex3L2)?.toString())
