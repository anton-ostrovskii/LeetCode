/**
 
 2034. Stock Price Fluctuation
 
 https://leetcode.com/problems/stock-price-fluctuation/
 
 You are given a stream of records about a particular stock. Each record contains a timestamp and the corresponding price of the stock at that timestamp.

 Unfortunately due to the volatile nature of the stock market, the records do not come in order. Even worse, some records may be incorrect. Another record with the same timestamp may appear later in the stream correcting the price of the previous wrong record.

 Design an algorithm that:

 Updates the price of the stock at a particular timestamp, correcting the price from any previous records at the timestamp.
 Finds the latest price of the stock based on the current records. The latest price is the price at the latest timestamp recorded.
 Finds the maximum price the stock has been based on the current records.
 Finds the minimum price the stock has been based on the current records.
 Implement the StockPrice class:

 StockPrice() Initializes the object with no price records.
 void update(int timestamp, int price) Updates the price of the stock at the given timestamp.
 int current() Returns the latest price of the stock.
 int maximum() Returns the maximum price of the stock.
 int minimum() Returns the minimum price of the stock.
 

 Example 1:

 Input
 ["StockPrice", "update", "update", "current", "maximum", "update", "maximum", "update", "minimum"]
 [[], [1, 10], [2, 5], [], [], [1, 3], [], [4, 2], []]
 Output
 [null, null, null, 5, 10, null, 5, null, 2]

 Explanation
 StockPrice stockPrice = new StockPrice();
 stockPrice.update(1, 10); // Timestamps are [1] with corresponding prices [10].
 stockPrice.update(2, 5);  // Timestamps are [1,2] with corresponding prices [10,5].
 stockPrice.current();     // return 5, the latest timestamp is 2 with the price being 5.
 stockPrice.maximum();     // return 10, the maximum price is 10 at timestamp 1.
 stockPrice.update(1, 3);  // The previous timestamp 1 had the wrong price, so it is updated to 3.
                           // Timestamps are [1,2] with corresponding prices [3,5].
 stockPrice.maximum();     // return 5, the maximum price is 5 after the correction.
 stockPrice.update(4, 2);  // Timestamps are [1,2,4] with corresponding prices [3,5,2].
 stockPrice.minimum();     // return 2, the minimum price is 2 at timestamp 4.
 

 Constraints:

 1 <= timestamp, price <= 10^9
 At most 105 calls will be made in total to update, current, maximum, and minimum.
 current, maximum, and minimum will be called only after update has been called at least once.
 
 */

import Foundation

// Update: O(1). Current: O(N), max: O(N), min: O(N)
class StockPrice {  // Time limit exceeded

  private var _recMin: (Int, Int)?
  private var _recMax: (Int, Int)?
  private var _recCurr: (Int, Int)?

 

  private var dict: [Int : Int] = [:]
 
  init() {
     
  }

  func update(_ timestamp: Int, _ price: Int) {
    dict[timestamp] = price
    if _recCurr != nil {
      if timestamp >= _recCurr!.0 {
        _recCurr = (timestamp, price)
      }
     
      if price < _recMin!.1 {
        _recMin = (timestamp, price)
      }
     
      if price > _recMax!.1 {
        _recMax = (timestamp, price)
      }
     
      if _recMin!.0 == timestamp {
        _recMin = (dict.min { $0.value < $1.value })
      }

      if _recMax!.0 == timestamp {
        _recMax = (dict.max { $0.value < $1.value })
      }
    } else {
      _recCurr = (timestamp, price)
      _recMin = (timestamp, price)
      _recMax = (timestamp, price)
    }
  }

  func current() -> Int {
    _recCurr!.1
  }

  func maximum() -> Int {
    _recMax!.1
  }

  func minimum() -> Int {
    _recMin!.1
  }
}

struct Heap<P, T> where P: Comparable {
  private var arr: [(P, T)] = []
  private let comparator: (P, P) -> Bool

  private func left(for i: Int) -> Int { 2*i + 1 }
  private func right(for i: Int) -> Int { 2*i + 2 }
  private func parent(for i: Int) -> Int { (i - 1)/2 }

  private mutating func heapifyUp() {
    guard arr.count > 0 else { return }
    var currIdx = arr.endIndex - 1
    var parentIdx = parent(for: currIdx)
    while currIdx != 0 && parentIdx >= 0 && comparator(arr[currIdx].0, arr[parentIdx].0) {
      arr.swapAt(currIdx, parentIdx)
      currIdx = parentIdx
      parentIdx = parent(for: currIdx)
    }
  }

  private mutating func heapifyDown() {
    guard arr.count > 0 else { return }
    var currIdx = 0
    var leftIdx = left(for: currIdx)
    var rightIdx = right(for: currIdx)
    while currIdx < arr.endIndex && leftIdx < arr.endIndex {
      var swapIdx = leftIdx
      if rightIdx < arr.endIndex && comparator(arr[rightIdx].0, arr[leftIdx].0) {
        swapIdx = rightIdx
      }
      if comparator(arr[swapIdx].0, arr[currIdx].0) {
        arr.swapAt(currIdx, swapIdx)
        currIdx = swapIdx
        leftIdx = left(for: currIdx)
        rightIdx = right(for: currIdx)
      } else {
        break
      }
    }
  }

  init(_ comparator: @escaping (P, P) -> Bool) {
    self.comparator = comparator
  }

  func peek() -> (P, T)? {
    guard arr.count > 0 else { return nil }
    return arr[0]
  }

  @discardableResult mutating func pop() -> (P, T)? {
    guard arr.count > 0 else { return nil }
    let result = arr.removeFirst()
    guard arr.count > 1 else { return result }
    arr.insert(arr.last!, at: 0)
    heapifyDown()
    arr.removeLast()
    return result
  }

  mutating func push(_ item: (P, T)) {
    arr.append(item)
    if arr.count > 1 {
      heapifyUp()
    }
  }
}

typealias Entry = (Int, Int)

class StockPriceOptimized {
 
  private var curr: Entry?
  private var minHeap = Heap<Int, Int>(<)
  private var maxHeap = Heap<Int, Int>(>)
  private var all = [Int : Int]()
 
  func update(_ timestamp: Int, _ price: Int) {
    all[timestamp] = price
    if curr == nil || timestamp >= curr!.0 {
      curr = (timestamp, price)
    }
    minHeap.push((price, timestamp))
    maxHeap.push((price, timestamp))
  }
 
  func current() -> Int {
    curr!.1
  }
 
  // all: timestamp:price
  // max: price:timestamp
 
  func maximum() -> Int {
    var max = maxHeap.peek()
    while max != nil && all[max!.1] != max!.0 {
      maxHeap.pop()
      max = maxHeap.peek()
    }
    return max!.0
  }
 
  func minimum() -> Int {
    var min = minHeap.peek()
    while min != nil && all[min!.1] != min!.0 {
      minHeap.pop()
      min = minHeap.peek()
    }
    return min!.0
  }
}

let spo = StockPriceOptimized()
spo.update(63, 7626)
spo.maximum()
spo.current()
spo.minimum()
spo.update(87, 9207)
spo.update(47, 8547)
spo.maximum()
spo.current()
spo.current()
spo.minimum()
spo.minimum()
spo.maximum()
spo.current()
spo.maximum()
spo.current()
spo.maximum()
spo.update(93, 4215)
spo.minimum()
spo.current()
spo.current()
spo.maximum()
spo.update(87, 2453)
spo.minimum()
spo.maximum() // should be 8547
spo.minimum()
spo.minimum()
spo.update(65, 9645)
spo.maximum()
spo.update(44, 7696)
spo.maximum()
spo.current()
spo.current()
spo.maximum()
spo.maximum()
spo.minimum()
spo.update(70, 2959)
spo.update(33, 393)
spo.maximum()
spo.update(77, 7333)
spo.current()
spo.minimum()
spo.minimum()
spo.maximum()
spo.minimum()
spo.maximum()
spo.update(62, 7696)
spo.update(29, 3348)
spo.minimum()
spo.update(75, 3348)
spo.current()
spo.maximum()





func getTestData() {
  let commands = ["update","maximum","current","minimum","update","update","maximum","current","current","minimum","minimum","maximum","current","maximum","current","maximum","update","minimum","current","current","maximum","update","minimum","maximum","minimum","minimum","update","maximum","update","maximum","current","current","maximum","maximum","minimum","update","update","maximum","update","current","minimum","minimum","maximum","minimum","maximum","update","update","minimum","update","current","maximum"]
  let inputs: [[Int]] = [[63,7626],[],[],[],[87,9207],[47,8547],[],[],[],[],[],[],[],[],[],[],[93,4215],[],[],[],[],[87,2453],[],[],[],[],[65,9645],[],[44,7696],[],[],[],[],[],[],[70,2959],[33,393],[],[77,7333],[],[],[],[],[],[],[62,7696],[29,3348],[],[75,3348],[],[]]
  for i in 0..<commands.count {
    if commands[i] == "update" {
      print("spo.update(\(inputs[i][0]), \(inputs[i][1]))")
    } else {
      print("spo.\(commands[i])()")
    }
  }
}

getTestData()

/***/
