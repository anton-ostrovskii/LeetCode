/**
 1146. Snapshot Array
 
 https://leetcode.com/problems/snapshot-array/
 
 Implement a SnapshotArray that supports the following interface:

 SnapshotArray(int length) initializes an array-like data structure with the given length.  Initially, each element equals 0.
 void set(index, val) sets the element at the given index to be equal to val.
 int snap() takes a snapshot of the array and returns the snap_id: the total number of times we called snap() minus 1.
 int get(index, snap_id) returns the value at the given index, at the time we took the snapshot with the given snap_id
 
 Example 1:

 Input: ["SnapshotArray","set","snap","set","get"]
 [[3],[0,5],[],[0,6],[0,0]]
 Output: [null,null,0,null,5]
 Explanation:
 SnapshotArray snapshotArr = new SnapshotArray(3); // set the length to be 3
 snapshotArr.set(0,5);  // Set array[0] = 5
 snapshotArr.snap();  // Take a snapshot, return snap_id = 0
 snapshotArr.set(0,6);
 snapshotArr.get(0,0);  // Get the value of array[0] with snap_id = 0, return 5
 
 Constraints:

 1 <= length <= 50000
 At most 50000 calls will be made to set, snap, and get.
 0 <= index < length
 0 <= snap_id < (the total number of times we call snap())
 0 <= val <= 10^9
 */

import Foundation

// Speed: O(1). Complexity O(N * M), N - length of array, M - snaps count
// This solution exceeds memory constraints
class SnapshotArraySimple {
    
    private var curData: [Int]
    private var data: [[Int]] = []
    private var snapCount: Int = -1

    init(_ length: Int) {
        curData = [Int](repeating: 0, count: length)
    }
    
    func set(_ index: Int, _ val: Int) {
        curData[index] = val
    }
    
    func snap() -> Int {
        snapCount += 1
        let curDataCopy = curData
        data.append(curDataCopy)
        return snapCount
    }
    
    func get(_ index: Int, _ snap_id: Int) -> Int {
        data[snap_id][index]
    }
}

// This solution exceeds time constraints
class SnapshotArrayOptimized {
    
    struct Node {
        var curValue: Int = 0
        var history: [Int: Set<Int>] = [:]
    }
    
    private var snapCount: Int
    private var data: [Node]
    
    init(_ length: Int) {
        data = [Node](repeating: Node(), count: length)
        snapCount = -1
    }
    
    func set(_ index: Int, _ val: Int) {
        data[index].curValue = val
    }
    
    func snap() -> Int {
        snapCount = snapCount + 1
        for i in 0..<data.count {
            if data[i].history[data[i].curValue] == nil {
                data[i].history[data[i].curValue] = [snapCount]
            } else {
                data[i].history[data[i].curValue]?.insert(snapCount)
            }
        }
        return snapCount
    }
    
    func get(_ index: Int, _ snap_id: Int) -> Int {
        (data[index].history.first { $0.value.contains(snap_id) })?.key ?? 0
    }
}

class SnapshotArrayOptimizedFaster {
    
    struct Node {
        var curValue: Int = 0
        var history: [Int: Int] = [:]
    }
    
    private var snapCount: Int
    private var data: [Node]
    
    init(_ length: Int) {
        data = [Node](repeating: Node(), count: length)
        snapCount = 0
    }
    
    func set(_ index: Int, _ val: Int) {
        guard index < data.count else { return }
        
        data[index].curValue = val
        data[index].history[snapCount] = val
    }
    
    func snap() -> Int {
        snapCount = snapCount + 1
        return snapCount - 1
    }
    
    func get(_ index: Int, _ snap_id: Int) -> Int {
        guard index < data.count && snap_id < snapCount else { preconditionFailure() }
        
        for s in (0...snap_id).reversed() {
            if let val = data[index].history[s] {
                return val
            }
        }
        
        return 0
    }
}
