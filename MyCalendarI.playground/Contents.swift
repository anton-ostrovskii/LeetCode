/**
 
 729. My Calendar I
 
 https://leetcode.com/problems/my-calendar-i/
 
 You are implementing a program to use as your calendar. We can add a new event if adding the event will not cause a double booking.

 A double booking happens when two events have some non-empty intersection (i.e., some moment is common to both events.).

 The event can be represented as a pair of integers start and end that represents a booking on the half-open interval [start, end), the range of real numbers x such that start <= x < end.

 Implement the MyCalendar class:

 MyCalendar() Initializes the calendar object.
 boolean book(int start, int end) Returns true if the event can be added to the calendar successfully without causing a double booking. Otherwise, return false and do not add the event to the calendar.
  

 Example 1:

 Input
 ["MyCalendar", "book", "book", "book"]
 [[], [10, 20], [15, 25], [20, 30]]
 Output
 [null, true, false, true]

 Explanation
 MyCalendar myCalendar = new MyCalendar();
 myCalendar.book(10, 20); // return True
 myCalendar.book(15, 25); // return False, It can not be booked because time 15 is already booked by another event.
 myCalendar.book(20, 30); // return True, The event can be booked, as the first event takes every time less than 20, but not including 20.
  

 Constraints:

 0 <= start < end <= 10^9
 At most 1000 calls will be made to book.
 
 */

import Foundation

// Time limit exceeded. Speed: O(N^2), Memory: O(N)
class MyCalendarSimple {

    init() {
        
    }

    private var data = Set<Set<Int>>()

    func book(_ start: Int, _ end: Int) -> Bool {
        let booking = Set<Int>(stride(from: start, to: end, by: 1))

        if !(data.contains { $0.intersection(booking).count > 0 }) {
            data.insert(booking)
            return true
        }

        return false
    }
}

class MyCalendarOptimized {

    init() {
        
    }

    private var data = Set<Int>()

    func book(_ start: Int, _ end: Int) -> Bool {
        for i in start..<end {
            if data.contains(i) {
                return false
            }
        }

        let booking = Set<Int>(stride(from: start, to: end, by: 1))
        data.formUnion(booking)

        /*if data.intersection(booking).count == 0 {
            data.formUnion(booking)
            return true
        }*/

        return true
    }
}

// Some wrong answers
class MyCalendarBinarySearch {
    
    struct Booking: CustomStringConvertible {
        var description: String { "[\(start), \(end)]" }

        let start: Int
        let end: Int
    }
    
    struct BookingHeap {
        private var data = [Booking]()

        private func parent(_ child: Int) -> Int {
            (child - 1) / 2
        }

        private func left(_ parent: Int) -> Int {
            parent * 2 + 1
        }

        private func right(_ parent: Int) -> Int {
            (parent + 1) * 2
        }

        mutating private func heapifyUp() {
            var currIndex = data.endIndex - 1
            while currIndex > 0 {
                let parentIndex = parent(currIndex)
                if data[currIndex].start < data[parentIndex].start {
                    data.swapAt(currIndex, parentIndex)
                    currIndex = parentIndex
                } else {
                    break
                }
            }
        }

        mutating func insert(_ booking: Booking) -> Bool {
            guard canInsert(booking) else { return false }
            data.append(booking)
            heapifyUp()
            return true
        }

        private func canInsert(_ booking: Booking) -> Bool {
            guard !data.isEmpty else { return true }
            var curr = 0
            while curr < data.count {
                let currB = data[curr]
                if isOverlapping(currB, booking) {
                    return false
                }

                let left = left(curr)
                let right = right(curr)
                if left >= data.count {
                    break
                } else if right >= data.count {
                    if isOverlapping(data[left], currB) {
                        return false
                    }
                    curr = left
                } else {
                    if isOverlapping(currB, data[left]) || isOverlapping(currB, data[right]) {
                        return false
                    }

                    if let nextCurr = (([left, right].filter { !isOverlapping(data[curr], data[$0]) }).min { data[$0].start > data[$1].start }) {
                        curr = nextCurr
                    } else {
                        return false
                    }
                }
            }
            return true
        }

        private func isOverlapping(_ b1: Booking, _ b2: Booking) -> Bool {
            var result = false

            if max(b1.start, b1.start) < min(b1.end, b2.end) {
                result = false
            }

            //print("Bookings \(b1) and \(b2) are overlapping: \(result)")
            
            return result
        }
    }
    
    var bookings = BookingHeap()

    init() {
        
    }
    
    func book(_ start: Int, _ end: Int) -> Bool {
        bookings.insert(Booking(start: start, end: end))
    }
    
}

let example1: [[Int]] = [[47,50],[33,41],[39,45],[33,42],[25,32],[26,35],[19,25],[3,8],[8,13],[18,27]]


class MyCalendarShort {

    init() {
        
    }
    
    private var bookings = [[Int]]()
    func book(_ start: Int, _ end: Int) -> Bool {
        for booking in bookings where max(booking[0], start) < min(booking[1], end) {
            return false
        }
        bookings.append([start, end])
        return true
    }
}

/**
 * Your MyCalendar object will be instantiated and called as such:
 * let obj = MyCalendar()
 * let ret_1: Bool = obj.book(start, end)
 */

final class MyCalendarWithSegmentTree { // for some reason doesn't give tight answers
    final class SegmentTree {
        final class Node {
            var begin: Int
            var end: Int
            var state: Bool
            var left: Node?
            var right: Node?
            init(begin: Int, end: Int, state: Bool, left: Node? = nil, right: Node? = nil) {
                self.begin = begin
                self.end = end
                self.state = state
                self.left = left
                self.right = right
            }
        }
        
        private var root = Node(begin: 0, end: 1_000_000_000, state: false)
        
        private func getMid(_ begin: Int, _ end: Int) -> Int {
            begin + (end - begin) / 2
        }
        
        func update(begin: Int, end: Int, state: Bool) {
            update(node: root, begin: begin, end: end, state: state)
        }
        
        private func update(node: Node?, begin: Int, end: Int, state: Bool) {
            guard let node = node else { return }
            
            if node.begin == begin && node.end == end {
                node.state = state
                node.left = nil
                node.right = nil
            } else {
                let mid = getMid(node.begin, node.end)
                
                if node.left == nil {
                    node.left = Node(begin: node.begin, end: mid, state: node.state)
                    node.right = Node(begin: mid + 1, end: node.end, state: node.state)
                }
                
                if mid < begin {
                    update(node: node.right, begin: begin, end: end, state: state)
                } else if mid + 1 > end {
                    update(node: node.left, begin: begin, end: end, state: state)
                } else {
                    update(node: node.left, begin: begin, end: mid, state: state)
                    update(node: node.right, begin: mid + 1, end: end, state: state)
                }
                node.state = (node.left?.state ?? false) && (node.right?.state ?? false)
            }
        }
        
        func search(begin: Int, end: Int) -> Bool {
            search(node: root, begin: begin, end: end)
        }
        
        private func search(node: Node?, begin: Int, end: Int) -> Bool {
            guard let node = node else { return false }
            if node.left == nil || node.begin == begin && node.end == end {
                return node.state
            } else {
                let mid = getMid(node.begin, node.end)
                if mid < begin {
                    return search(node: node.right, begin: begin, end: end)
                } else if mid + 1 > end {
                    return search(node: node.left, begin: begin, end: end)
                } else {
                    return search(node: node.left, begin: begin, end: mid) && search(node: node.right, begin: mid + 1, end: end)
                }
            }
        }
    }
    
    init() {
        
    }
    
    private var tree = SegmentTree()
    
    func book(_ start: Int, _ end: Int) -> Bool {
        guard !tree.search(begin: start, end: end - 1) else { return false }
        
        tree.update(begin: start, end: end - 1, state: true)
        return true
    }
}
