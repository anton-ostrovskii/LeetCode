/**
 146. LRU Cache
 
 https://leetcode.com/problems/lru-cache/
 
 Design a data structure that follows the constraints of a Least Recently Used (LRU) cache.

 Implement the LRUCache class:

 LRUCache(int capacity) Initialize the LRU cache with positive size capacity.
 int get(int key) Return the value of the key if the key exists, otherwise return -1.
 void put(int key, int value) Update the value of the key if the key exists. Otherwise, add the key-value pair to the cache. If the number of keys exceeds the capacity from this operation, evict the least recently used key.
 The functions get and put must each run in O(1) average time complexity.

  

 Example 1:

 Input
 ["LRUCache", "put", "put", "get", "put", "get", "put", "get", "get", "get"]
 [[2], [1, 1], [2, 2], [1], [3, 3], [2], [4, 4], [1], [3], [4]]
 Output
 [null, null, null, 1, null, -1, null, -1, 3, 4]

 Explanation
 LRUCache lRUCache = new LRUCache(2);
 lRUCache.put(1, 1); // cache is {1=1}
 lRUCache.put(2, 2); // cache is {1=1, 2=2}
 lRUCache.get(1);    // return 1
 lRUCache.put(3, 3); // LRU key was 2, evicts key 2, cache is {1=1, 3=3}
 lRUCache.get(2);    // returns -1 (not found)
 lRUCache.put(4, 4); // LRU key was 1, evicts key 1, cache is {4=4, 3=3}
 lRUCache.get(1);    // return -1 (not found)
 lRUCache.get(3);    // return 3
 lRUCache.get(4);    // return 4
  

 Constraints:

 1 <= capacity <= 3000
 0 <= key <= 10^4
 0 <= value <= 10^5
 At most 2 * 10^5 calls will be made to get and put.
 */

import Foundation
import Darwin

class LRUCache {

    class Node {
        let key: Int
        var value: Int
        var prev: Node?
        var next: Node?

        init(_ key: Int, _ value: Int) {
            self.key = key
            self.value = value
        }
    }

    private var data: [Int: Node] = [:]
    private let capacity: Int
    private var head: Node?
    private var tail: Node?

    init(_ capacity: Int) {
        self.capacity = capacity
    }
    
    func get(_ key: Int) -> Int {
        guard let node = data[key] else { return -1 }

        makeHead(node)
        return node.value
    }
    
    func put(_ key: Int, _ value: Int) {
        if let node = data[key] {
            node.value = value
            makeHead(node)
        } else {
            let node = Node(key, value)
            
            node.next = head
            head?.prev = node
            head = node
            data[key] = node
            if tail == nil {
                tail = head
            }
        }
        
        if data.count > capacity {
            data.removeValue(forKey: tail!.key)
            tail = tail?.prev
            tail?.next = nil
        }
    }

    private func makeHead(_ node: Node) {
        guard !(node === head) else { return }

        node.prev?.next = node.next
        node.next?.prev = node.prev
        node.next = head
        head?.prev = node
        head = node

        if node === tail {
            tail = tail?.prev
            tail?.next = nil
        }
    }
}

/*let lruCache = LRUCache(2)
lruCache.put(1, 1)
lruCache.put(2, 2)
print(lruCache.get(1))
lruCache.put(3, 3)
print(lruCache.get(2))
lruCache.put(4, 4)
print(lruCache.get(1))
print(lruCache.get(3))
print(lruCache.get(4))*/

/*let lruCache = LRUCache(2)
lruCache.put(2, 1)
lruCache.put(1, 1)
print(lruCache.get(2))
lruCache.put(3, 1)
print(lruCache.get(1))
print(lruCache.get(2))*/

let lruCache = LRUCache(1)
lruCache.put(2, 1)
print(lruCache.get(2))
lruCache.put(3, 2)
print(lruCache.get(2))
print(lruCache.get(3))

class LRUCacheWrong {

    struct VFPair {
        let value: Int
        var frequency: Int = 0
    }

    private let capacity: Int
    private var frequencies: ContiguousArray<Set<Int>> = []
    private var data: [Int : VFPair] = [:]

    init(_ capacity: Int) {
        self.capacity = capacity
        frequencies.append([])
    }

    func get(_ key: Int) -> Int {
        guard let result = data[key] else { return -1 }
        let frequency = result.frequency
        data[key]?.frequency = frequency + 1
        frequencies[frequency].remove(key)
        if !frequencies.indices.contains(frequency + 1) {
            frequencies.append([])
        }
        frequencies[frequency + 1].insert(key)
        return result.value
    }

    func put(_ key: Int, _ value: Int) {
        if data.count == capacity && data[key] == nil {
            removeLRU()
        }
        data[key] = VFPair(value: value)
        frequencies[0].insert(key)
    }

    private func removeLRU() {
        for i in 0..<frequencies.count {
            if !frequencies[i].isEmpty {
                let key = frequencies[i].removeFirst()
                data.removeValue(forKey: key)
                break
            }
        }
    }
}

/**
 * Your LRUCache object will be instantiated and called as such:
 * let obj = LRUCache(capacity)
 * let ret_1: Int = obj.get(key)
 * obj.put(key, value)
 */
