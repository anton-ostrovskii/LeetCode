/**

 https://leetcode.com/problems/logger-rate-limiter/
 
 Design a logger system that receives a stream of messages along with their timestamps. Each unique message should only be printed at most every 10 seconds (i.e. a message printed at timestamp t will prevent other identical messages from being printed until timestamp t + 10).

 All messages will come in chronological order. Several messages may arrive at the same timestamp.

 Implement the Logger class:

 Logger() Initializes the logger object.
 bool shouldPrintMessage(int timestamp, string message) Returns true if the message should be printed in the given timestamp, otherwise returns false.
  

 Example 1:

 Input
 ["Logger", "shouldPrintMessage", "shouldPrintMessage", "shouldPrintMessage", "shouldPrintMessage", "shouldPrintMessage", "shouldPrintMessage"]
 [[], [1, "foo"], [2, "bar"], [3, "foo"], [8, "bar"], [10, "foo"], [11, "foo"]]
 Output
 [null, true, true, false, false, false, true]

 Explanation
 Logger logger = new Logger();
 logger.shouldPrintMessage(1, "foo");  // return true, next allowed timestamp for "foo" is 1 + 10 = 11
 logger.shouldPrintMessage(2, "bar");  // return true, next allowed timestamp for "bar" is 2 + 10 = 12
 logger.shouldPrintMessage(3, "foo");  // 3 < 11, return false
 logger.shouldPrintMessage(8, "bar");  // 8 < 12, return false
 logger.shouldPrintMessage(10, "foo"); // 10 < 11, return false
 logger.shouldPrintMessage(11, "foo"); // 11 >= 11, return true, next allowed timestamp for "foo" is 11 + 10 = 21
  

 Constraints:

 0 <= timestamp <= 10^9
 Every timestamp will be passed in non-decreasing order (chronological order).
 1 <= message.length <= 30
 At most 10^4 calls will be made to shouldPrintMessage.
 
 */

import Foundation

let ex1: [(timeStamp: Int, message: String)] = [(1, "foo"), (2, "bar"), (3, "foo"), (8, "bar"), (10, "foo"), (11, "foo")]
let ex2: [(timeStamp: Int, message: String)] = [(0,"A0"),(4,"A2"),(8,"A2"),(12,"A4"),(16,"A1"),(20,"A3"),(24,"A2"),(28,"A4"),(32,"A3"),(36,"A1")]

// Complexity: Speed: O(1), Memory: O(N). N - size of all messages
class LoggerSimple {

    init() {
    }
    
    var messages: [String : Int] = [:]
    
    func shouldPrintMessage(_ timestamp: Int, _ message: String) -> Bool {
        if let lastTimestamp = messages[message], timestamp - lastTimestamp < 10 {
            return false
        }
        messages[message] = timestamp
        return true
    }
}

let loggerSimple = LoggerSimple()
var resultSimple = ""
ex2.forEach {
    resultSimple += loggerSimple.shouldPrintMessage($0.timeStamp, $0.message).description + ","
}
print(resultSimple)

// Complexity: Speed: O(N), Memory: O(N). N - size of messages in a queue
class LoggerQueueSet {
    
    class Entry {
        let timeStamp: Int
        let message: String
        var next: Entry?
        init(timeStamp: Int, message: String) {
            self.timeStamp = timeStamp
            self.message = message
        }
    }
    
    class Queue {
        var first: Entry?
        var last: Entry?
        
        init() { }
        
        func enqueue(_ entry: Entry) {
            if let last = last {
                last.next = entry
                self.last = entry
            } else {
                first = entry
                last = entry
            }
        }
        
        @discardableResult func dequeue() -> Entry? {
            guard let first = first else { return nil }
            self.first = first.next
            return first
        }
    }
    
    var messageQueue = Queue()
    var messageWindow: Set<String> = []
    
    init() {
    }
    
    func shouldPrintMessage(_ timestamp: Int, _ message: String) -> Bool {
        while messageQueue.first != nil {
            if let t = messageQueue.first?.timeStamp, timestamp - t >= 10, let m = messageQueue.dequeue()?.message {
                messageWindow.remove(m)
            } else {
                break
            }
        }
        
        if messageWindow.insert(message).inserted {
            messageQueue.enqueue(Entry(timeStamp: timestamp, message: message))
            return true
        } else {
            return false
        }
    }
}

let loggerQueueSet = LoggerQueueSet()
var resultQueueSet = ""
ex2.forEach {
    resultQueueSet += loggerQueueSet.shouldPrintMessage($0.timeStamp, $0.message).description + ","
}
print(resultQueueSet)
