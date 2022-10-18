import Foundation

// MARK: - Add Two Numbers
/**
 You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order, and each of their nodes contains a single digit. Add the two numbers and return the sum as a linked list.
 You may assume the two numbers do not contain any leading zero, except the number 0 itself.
 
 Keywords: linked list, sum, carry
 */
final class AddTwoNumbers {
  final class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
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

  func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
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
}



// MARK: - Amount of New Area Painted Each Day
/**
 There is a long and thin painting that can be represented by a number line. You are given a 0-indexed 2D integer array paint of length n, where paint[i] = [starti, endi]. This means that on the ith day you need to paint the area between starti and endi.
 Painting the same area multiple times will create an uneven painting so you only want to paint each area of the painting at most once.
 Return an integer array worklog of length n, where worklog[i] is the amount of new area that you painted on the ith day.
 
 Keywords: segments, overlappings
 */
final class AmountOfNewAreaPaintedEachDay {
  func amountPainted(_ paint: [[Int]]) -> [Int] {
    var result = [Int]()
    result.reserveCapacity(paint.count)
    var painted: [Bool] = Array(repeating: false, count: 5 * 10000)

    for day in paint {
      var curr = 0
      let from = day[0]
      let to = day[1]
      for i in from..<to {
        if painted[i] == false {
          painted[i] = true
          curr += 1
        }
      }
      result.append(curr)
    }
    return result
  }
}



// MARK: - Count Words Obtained After Adding a Letter
/**
 You are given two 0-indexed arrays of strings startWords and targetWords. Each string consists of lowercase English letters only.
 For each string in targetWords, check if it is possible to choose a string from startWords and perform a conversion operation on it to be equal to that from targetWords.
 The conversion operation is described in the following two steps:
 Append any lowercase letter that is not present in the string to its end.
 For example, if the string is "abc", the letters 'd', 'e', or 'y' can be added to it, but not 'a'. If 'd' is added, the resulting string will be "abcd".
 Rearrange the letters of the new string in any arbitrary order.
 For example, "abcd" can be rearranged to "acbd", "bacd", "cbda", and so on. Note that it can also be rearranged to "abcd" itself.
 Return the number of strings in targetWords that can be obtained by performing the operations on any string of startWords.
 Note that you will only be verifying if the string in targetWords can be obtained from a string in startWords by performing the operations. The strings in startWords do not actually change during this process.
 
 Keywords: strings, combinations
 */
final class CountWordsObtainedAfterAddingaLetter {
  func wordCount(_ startWords: [String], _ targetWords: [String]) -> Int {
      let startWordsSet = Set(startWords.map { String($0.sorted()) })
      var result = 0
      for targetWord in targetWords {
inner:      for i in 0..<targetWord.count {
              var twCopy = String(targetWord.sorted())
              let idx = twCopy.index(twCopy.startIndex, offsetBy: i)
              twCopy.remove(at: idx)
              if startWordsSet.contains(twCopy) {
                  result += 1
                  break inner
              }
          }
      }
      return result
  }
}



// MARK: - Detect Squares
/**
 You are given a stream of points on the X-Y plane. Design an algorithm that:
 Adds new points from the stream into a data structure. Duplicate points are allowed and should be treated as different points.
 Given a query point, counts the number of ways to choose three points from the data structure such that the three points and the query point form an axis-aligned square with positive area.
 An axis-aligned square is a square whose edges are all the same length and are either parallel or perpendicular to the x-axis and y-axis.
 
 Keywords: math, geometry
 */
final class DetectSquares {
  struct Point: Hashable {
    let x: Int
    let y: Int

    public init(_ point: [Int]) {
      guard point.count == 2 else { preconditionFailure() }
      x = point[0]
      y = point[1]
    }
    
    public init(_ x: Int, _ y: Int) {
      self.x = x
      self.y = y
    }
  }

  init() { }

  private var points = [Point:Int]()

  func add(_ point: [Int]) {
    let p = Point(point)
    if let count = points[p] {
      points[p] = count + 1
    } else {
      points[p] = 1
    }
  }

  func count(_ point: [Int]) -> Int {
    guard point.count == 2 else { preconditionFailure() }
    let p1 = Point(point)

    var cnt = 0

    // filter everything in the same column
    let sameColumn = points.filter { $0.key.x == p1.x && $0.key.y != p1.y }

    // now for each candidate we need to check other 2 points
    for scP2 in sameColumn {
      let p2 = scP2.key
      let side = abs(p2.y - p1.y)

      let p31 = Point(p1.x + side, p1.y)
      let p41 = Point(p2.x + side, p2.y)

      let p32 = Point(p1.x - side, p1.y)
      let p42 = Point(p2.x - side, p2.y)

      if let scP31 = points[p31],
         let scP41 = points[p41] {
          cnt += 1 * scP2.value * scP31 * scP41
      }
      if let scP32 = points[p32],
         let scP42 = points[p42] {
          cnt += 1 * scP2.value * scP32 * scP42
      }
    }
    return cnt
  }
}



// MARK: - Evaluate Reverse Polish Notation
/**
 Evaluate the value of an arithmetic expression in Reverse Polish Notation.
 Valid operators are +, -, *, and /. Each operand may be an integer or another expression.
 Note that division between two integers should truncate toward zero.
 It is guaranteed that the given RPN expression is always valid. That means the expression would always evaluate to a result, and there will not be any division by zero operation.
 
 Keywords: stack, evaluation, math, expression, string
 */
final class EvaluateReversePolishNotation {
  struct Stack<T> where T: Comparable {
      private var items = [T]()

      mutating func push(_ val: T) {
          items.insert(val, at: 0)
      }

      mutating func pop() -> T {
          guard !items.isEmpty else { fatalError() }
          return items.removeFirst()
      }
  }

  func evalRPN(_ tokens: [String]) -> Int {
      var stack = Stack<Int>()

      for token in tokens {
          if let number = Int(token) {
              stack.push(number)
          } else {
              let rhs = stack.pop()
              let lhs = stack.pop()
              let result: Int = {
                  switch token {
                  case "+":
                      return lhs + rhs
                  case "-":
                      return lhs - rhs
                  case "*":
                      return lhs * rhs
                  case "/":
                      return lhs / rhs
                  default:
                      preconditionFailure()
                  }
              }()
              stack.push(result)
          }
      }

      return stack.pop()
  }
}



// MARK: - Find All Possible Recipes from Given Supplies
/**
 You have information about n different recipes. You are given a string array recipes and a 2D string array ingredients. The ith recipe has the name recipes[i], and you can create it if you have all the needed ingredients from ingredients[i]. Ingredients to a recipe may need to be created from other recipes, i.e., ingredients[i] may contain a string that is in recipes.
 You are also given a string array supplies containing all the ingredients that you initially have, and you have an infinite supply of all of them.
 Return a list of all the recipes that you can create. You may return the answer in any order.
 Note that two recipes may contain each other in their ingredients.
 */
final class FindAllPossibleRecipesFromGivenSupplies {
  func findAllRecipes(_ recipes: [String], _ ingredients: [[String]], _ supplies: [String]) -> [String] {

      var order = [String]()

      @discardableResult func canMake(recipieIndex: Int)  -> Bool {
          var cookChain = [String]()
          return canMake(recipieIndex: recipieIndex, cookChain: &cookChain)
      }

      @discardableResult func canMake(recipieIndex: Int, cookChain: inout [String]) -> Bool {
          guard !order.contains(recipes[recipieIndex]) else { return true }
          guard !cookChain.contains(recipes[recipieIndex]) else { return false }  // avoid infinite recursion

          var result = true
          for ingredientIndex in 0..<ingredients[recipieIndex].count where result {
              if supplies.contains(ingredients[recipieIndex][ingredientIndex]) {
                  continue
              } else if let compositeRecipieIndex = (recipes.firstIndex { $0 == ingredients[recipieIndex][ingredientIndex] }) {
                  cookChain.append(recipes[recipieIndex])
                  result = canMake(recipieIndex: compositeRecipieIndex, cookChain: &cookChain)
              } else {
                  result = false
              }
          }

          if result {
              order.append(recipes[recipieIndex])
          }

          return result
      }

      for i in 0..<recipes.count {
          canMake(recipieIndex: i)
      }

      return order
  }
}



// MARK: - Find And Replace in String
/**
 You are given a 0-indexed string s that you must perform k replacement operations on. The replacement operations are given as three 0-indexed parallel arrays, indices, sources, and targets, all of length k.
 To complete the ith replacement operation:
 Check if the substring sources[i] occurs at index indices[i] in the original string s.
 If it does not occur, do nothing.
 Otherwise if it does occur, replace that substring with targets[i].
 For example, if s = "abcd", indices[i] = 0, sources[i] = "ab", and targets[i] = "eee", then the result of this replacement will be "eeecd".
 All replacement operations must occur simultaneously, meaning the replacement operations should not affect the indexing of each other. The testcases will be generated such that the replacements will not overlap.
 For example, a testcase with s = "abc", indices = [0, 1], and sources = ["ab","bc"] will not be generated because the "ab" and "bc" replacements overlap.
 Return the resulting string after performing all replacement operations on s.
 A substring is a contiguous sequence of characters in a string.
 
 Keywords: String, replace, find in string, combinations
 */
final class FindAndReplaceInString {
  func findReplaceString(_ s: String, _ indices: [Int], _ sources: [String], _ targets: [String]) -> String {
      var output = s
      let k = indices.count
      let sortedIndices = zip(indices, indices.indices).sorted { $0.0 < $1.0 }
      var diff = 0
      for i in 0..<k {
          let offset = sortedIndices[i].0
          let src = sources[sortedIndices[i].1]
          let trg = targets[sortedIndices[i].1]
          let srcLen = src.count
          if offset > s.count || offset + srcLen > s.count {
              continue
          }
          let srcRange = s.index(s.startIndex, offsetBy: offset)..<s.index(s.startIndex, offsetBy: offset + srcLen)
          if s[srcRange] == src {
              print("2")
              let outRange = output.index(output.startIndex, offsetBy: offset + diff)..<output.index(output.startIndex, offsetBy: offset + diff + srcLen)
              output.replaceSubrange(outRange, with: trg)
              let trgLen = trg.count
              diff += (trgLen - srcLen)
          }
      }
      return output
  }
}



// MARK: - Find Leaves of Binary Tree
/**
 Given the root of a binary tree, collect a tree's nodes as if you were doing this:
 Collect all the leaf nodes.
 Remove all the leaf nodes.
 Repeat until the tree is empty.
 
 Keywords: binary tree, traverse, tree height
 */
final class FindLeavesOfBinaryTree {
  final class TreeNode {
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
}



// MARK: - Guess The Word
/**
 You are given an array of unique strings words where words[i] is six letters long. One word of words was chosen as a secret word.
 You are also given the helper object Master. You may call Master.guess(word) where word is a six-letter-long string, and it must be from words. Master.guess(word) returns:
 -1 if word is not from words, or
 an integer representing the number of exact matches (value and position) of your guess to the secret word.
 There is a parameter allowedGuesses for each test case where allowedGuesses is the maximum number of times you can call Master.guess(word).
 
 Keywords: guessing, random
 */
final class GuessTheWord {
  final class Master {
      public func guess(_ word: String) -> Int {
          0
      }
  }
  
  func findSecretWord(_ words: [String], _ master: Master) {
      var wordsSet = Set(words)

      for _ in 0..<10 {
          if let word = wordsSet.randomElement() {
              wordsSet.remove(word)
              let guessed = master.guess(word)
              if guessed == 6 { break }
              if guessed > 0 {
                  wordsSet = wordsSet.filter({ candidate in
                      var matches = 0
                      for i in 0..<6 {
                          if word[word.index(word.startIndex, offsetBy: i)] == candidate[candidate.index(candidate.startIndex, offsetBy: i)] {
                              matches += 1
                          }
                      }
                      return matches == guessed
                  })
              }
          } else {
              break
          }
      }
  }
}



// MARK: - Happy Number
/**
 Write an algorithm to determine if a number n is happy.
 A happy number is a number defined by the following process:
 Starting with any positive integer, replace the number by the sum of the squares of its digits.
 Repeat the process until the number equals 1 (where it will stay), or it loops endlessly in a cycle which does not include 1.
 Those numbers for which this process ends in 1 are happy.
 Return true if n is a happy number, and false if not.
 
 Keywords: numbers, combinations, turtle and hare
 */
final class HappyNumber {
  func checksum(_ n: Int) -> Int {
      var result = 0
      var remaining = n
      while remaining > 0 {
          let p = remaining % 10
          result += p*p
          remaining /= 10
      }
      return result
  }

  /// Advanced solution which doesn't require additional set. Speed: O(logN). Space: O(1)
  func isHappyNumber(_ n: Int) -> Bool {
      var turtle = checksum(n)
      var hare = checksum(turtle)
      while hare != 1 && hare != turtle {
          turtle = checksum(turtle)
          hare = checksum(checksum(hare))
      }
      return hare == 1
  }
}



// MARK: - Lower Common Ancestor
/**
 Find the lower common ancestor (aka lca), i.e., ancestor with maximal depth,
 of a pair of nodes in a rooted tree.
 
 Keywords: binary tree, tree traversal, lower common ancestor, LCA
 */
final class LowerCommonAncestor {
  final class Node {
      let val: Int
      var left: Node?
      var right: Node?

      init(_ v: Int, left: Node? = nil, right: Node? = nil) {
          self.val = v
          self.left = left
          self.right = right
      }
  }

  final class LCAFinderWithFullPath {
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
  
  final class SingleTraceLCAFinder {
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
}



// MARK: - Logger Rate Limiter
/**
 Design a logger system that receives a stream of messages along with their timestamps. Each unique message should only be printed at most every 10 seconds (i.e. a message printed at timestamp t will prevent other identical messages from being printed until timestamp t + 10).
 All messages will come in chronological order. Several messages may arrive at the same timestamp.
 
 Keywords: sliding window, set, queue, rate limiter, messages
 */
final class LoggerRateLimiter {
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



// MARK: - Longest Line of Consecutive One in Matrix
/**
 Given an m x n binary matrix mat, return the length of the longest line of consecutive one in the matrix.
 The line could be horizontal, vertical, diagonal, or anti-diagonal.
 
 Keywords: matrix, binary, sequence
 */
final class LongestLineOfConsecutiveOneInMatrix {
  func longestLine(_ mat: [[Int]]) -> Int {

      var maxLen = 0

      struct State {
          var rowChecked = false
          var columnChecked = false
          var mainDiagonalChecked = false
          var subDiagonalChecked = false

          var checked: Bool { rowChecked && columnChecked && mainDiagonalChecked && subDiagonalChecked }
      }

      let rows = mat.count
      let cols = mat[0].count
      var states: [[State]] = Array(repeating: Array(repeating: State(), count: cols), count: rows)

      func checkRow(_ r: Int, _ c: Int) {
          var len = 0
          for ci in c..<cols {
              if mat[r][ci] == 1 {
                  states[r][ci].rowChecked = true
                  len += 1
              } else {
                  break
              }
          }
          maxLen = max(maxLen, len)
      }

      func checkCol(_ r: Int, _ c: Int) {
          var len = 0
          for ri in r..<rows {
              if mat[ri][c] == 1 {
                  states[ri][c].columnChecked = true
                  len += 1
              } else {
                  break
              }
          }
          maxLen = max(maxLen, len)
      }

      func chekMainDiagonal(_ r: Int, _ c: Int) {
          var len = 0
          for (ri, ci) in zip(r..<rows, c..<cols) {
              if mat[ri][ci] == 1 {
                  states[ri][ci].mainDiagonalChecked = true
                  len += 1
              } else {
                  break
              }
          }
          maxLen = max(maxLen, len)
      }

      func chekSubDiagonal(_ r: Int, _ c: Int) {
          var len = 0
          for (ri, ci) in zip(r..<rows, (0...c).reversed()) {
              if mat[ri][ci] == 1 {
                  states[ri][ci].subDiagonalChecked = true
                  len += 1
              } else {
                  break
              }
          }
          maxLen = max(maxLen, len)
      }

      for ri in 0..<rows {
          for ci in 0..<cols {
              if mat[ri][ci] == 1 {
                  if !states[ri][ci].rowChecked {
                      checkRow(ri, ci)
                  }
                  if !states[ri][ci].columnChecked {
                      checkCol(ri, ci)
                  }
                  if !states[ri][ci].mainDiagonalChecked {
                      chekMainDiagonal(ri, ci)
                  }
                  if !states[ri][ci].subDiagonalChecked {
                      chekSubDiagonal(ri, ci)
                  }
              }
          }
      }

      return maxLen
  }
}



// MARK: - Longest Plateau
/**
 The array b[0...n-1] has n elements, mat have duplicate elements, and may be sorted.
 A plateau of length p is a sequence of p consecutive elements with the same value.
 Find the length of the longest plateau in b.
 
 Keywords: Plateau, sequence, array
 */
final class LongestPlateau {
  func plateau(_ arr: [Int]) -> Int {
      var i = 0
      var p = 0
      while i < arr.count {
          print("arr[\(i)] = \(arr[i]), p = \(p), arr[i-p] = \(arr[i - p])")
          if arr[i] == arr[i - p] {
              p += 1
          }
          i += 1
      }
      return p
  }
}



// MARK: - Longest String Chain
/**
 Return the length of the longest possible word chain with words chosen from the given list of words.
 
 Keywords: strings, arrays, chain, sequence
 */
final class LongestStringChain {
  func longestStrChain(_ words: [String]) -> Int {
      let wordsSet = Set(words)
      var sequences = [String:Int]()

      func getChainLength(from word: String) -> Int {
          if let len = sequences[word] {
              return len
          }

          var maxChain = 1
          for i in 0..<word.count {
              var newWord = word
              newWord.remove(at: newWord.index(newWord.startIndex, offsetBy: i))
              if wordsSet.contains(newWord) {
                  maxChain = max(maxChain, 1 + getChainLength(from: newWord))
              }
          }

          sequences[word] = maxChain
          return maxChain
      }

      var maxChain = 0
      for word in wordsSet {
          maxChain = max(maxChain, getChainLength(from: word))
      }

      return maxChain
  }
}



// MARK: - Least Recently Used Cache
/**
 Design a data structure that follows the constraints of a Least Recently Used (LRU) cache.
 Implement the LRUCache class:
 LRUCache(int capacity) Initialize the LRU cache with positive size capacity.
 int get(int key) Return the value of the key if the key exists, otherwise return -1.
 void put(int key, int value) Update the value of the key if the key exists. Otherwise, add the key-value pair to the cache. If the number of keys exceeds the capacity from this operation, evict the least recently used key.
 The functions get and put must each run in O(1) average time complexity.
 
 Keywords: cache, set, capacity, array, LRU
 */
final class LeastRecentlyUsedCache {
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



// MARK: - Maximum Number of Points with Cost
/**
 You are given an m x n integer matrix points (0-indexed). Starting with 0 points, you want to maximize the number of points you can get from the matrix.
 To gain points, you must pick one cell in each row. Picking the cell at coordinates (r, c) will add points[r][c] to your score.
 However, you will lose points if you pick a cell too far from the cell that you picked in the previous row. For every two adjacent rows r and r + 1 (where 0 <= r < m - 1), picking cells at coordinates (r, c1) and (r + 1, c2) will subtract abs(c1 - c2) from your score.
 Return the maximum number of points you can achieve.
 abs(x) is defined as:
 x for x >= 0.
 -x for x < 0.
 
 Keywords: array, traversal, obstacles, points
 */
final class MaximumNumberOfPointsWithCost {
  func maxPoints(_ points: [[Int]]) -> Int {
      var dp = points[0]  // previous calculation - first row as is
      let rows = points.count
      let cols = points[0].count
      for row in 1..<rows {
          var ltr = dp    // moving to curr from left to right
          var rtl = dp    // moving to curr from right to left
          for col in 1..<cols {
              // col[0] - same for ltr, col[m - 1] - same for rtl
              ltr[col] = max(ltr[col - 1] - 1, ltr[col])
              rtl[cols - col - 1] = max(rtl[cols - col - 1], rtl[cols - col] - 1)
          }
          for col in 0..<cols {
              dp[col] = points[row][col] + max(ltr[col], rtl[col])
          }
      }
      return dp.max()!
  }
}



// MARK: - Maximum Number of Visible Points
/**
 You are given an array points, an integer angle, and your location, where location = [posx, posy] and points[i] = [xi, yi] both denote integral coordinates on the X-Y plane.
 Initially, you are facing directly east from your position. You cannot move from your position, but you can rotate. In other words, posx and posy cannot be changed. Your field of view in degrees is represented by angle, determining how wide you can see from any given view direction. Let d be the amount in degrees that you rotate counterclockwise. Then, your field of view is the inclusive range of angles [d - angle/2, d + angle/2].
 You can see some set of points if, for each point, the angle formed by the point, your position, and the immediate east direction from your position is in your field of view.
 There can be multiple points at one coordinate. There may be points at your location, and you can always see these points regardless of your rotation. Points do not obstruct your vision to other points.
 Return the maximum number of points you can see.
 
 Keywords: math, geometry, points, coordinates, angles
 */
final class MaximumNumberOfVisiblePoints {
  func visiblePoints(_ points: [[Int]], _ angle: Int, _ location: [Int]) -> Int {
      var pointsAtOrigin = 0 // points which matching the start location
      var angles = [Double]() // list of angles for points
      for point in points {
          // moving calculation towards center of coordinates
          let x = point[0] - location[0]
          let y = point[1] - location[1]
          if x == 0 && y == 0 {
              pointsAtOrigin += 1
          }
          else {
              let angle = atan2(Double(x), Double(y)) * (180.0 / .pi)
              angles.append(angle)        // add an angle
              angles.append(angle + 360)   // add a rotation (?)
          }
      }

      angles.sort()
      let size = angles.count
      var slow = 0
      var fast = 0
      var maxPoints = 0
      // some voodoo magic below
      while fast < size && slow < size / 2 {
          if angles[fast] - angles[slow] <= Double(angle) {
              maxPoints = max(maxPoints, fast - slow + 1)
              if maxPoints >= size / 2 {
                  break
              }
              fast += 1
          } else {
              slow += 1
          }
      }

      return pointsAtOrigin + maxPoints
  }
}



// MARK: - Maximum Split Of Positive Even Integers
/**
 You are given an integer finalSum. Split it into a sum of a maximum number of unique positive even integers.
 For example, given finalSum = 12, the following splits are valid (unique positive even integers summing up to finalSum): (12), (2 + 10), (2 + 4 + 6), and (4 + 8). Among them, (2 + 4 + 6) contains the maximum number of integers. Note that finalSum cannot be split into (2 + 2 + 4 + 4) as all the numbers should be unique.
 Return a list of integers that represent a valid split containing a maximum number of integers. If no valid split exists for finalSum, return an empty list. You may return the integers in any order.
 
 Keywords: integers, splitting, array, combinations
 */
final class MaximumSplitOfPositiveEvenIntegers {
  func maximumEvenSplit(_ finalSum: Int) -> [Int] {
      guard finalSum.isMultiple(of: 2) else { return [] }

      var sum = 0
      var numbers = [Int]()
      var curr = 2
      while sum < finalSum {
          sum += curr
          numbers.append(curr)
          curr += 2
      }

      if sum != finalSum {
          let diff = sum - finalSum
          let index = (diff - 2) / 2
          numbers.remove(at: index)
      }

      return numbers
  }
}



// MARK: - Max Subarray
/**
 Design and implement an efficient progam to find a contiguous subarray within a one-dimensional array
 of integers which has the largest sum. Please note that there is at least one positive integer in the input array.
 
 Keywords: array, sequence, Karane's algorithm
 */
final class MaxSubarray {
  func simpleKadanesAlgorithm(array: [Int]) -> Int {
      var localMax = 0
      var globalMax = Int.min
      for i in 0..<array.count {
          localMax = max(array[i], localMax + array[i])
          if localMax > globalMax {
              globalMax = localMax
          }
      }
      return globalMax
  }

  func kadanesWithIndicies(array: [Int]) -> (max: Int, startIndex: Int, endIndex: Int) {
      var startIndex = Int.min
      var endIndex = Int.max
      var localMax = 0
      var globalMax = Int.min
      
      for i in 0..<array.count {
          if array[i] > localMax + array[i] {
              //startIndex = i
              localMax = array[i]
          } else {
              localMax = localMax + array[i]
          }
          
          if localMax > globalMax {
              globalMax = localMax
              if startIndex == Int.min {
                  startIndex = i
              }
              endIndex = i
          }
      }
      
      if startIndex > endIndex {
          startIndex = endIndex
      }
      return (max: globalMax, startIndex: startIndex, endIndex: endIndex)
  }
}



// MARK: - Minimum Time Difference
/**
 Given a list of 24-hour clock time points in "HH:MM" format, return the minimum minutes difference between any two time-points in the list.
 
 Keywords: time, intervals, overlapping
 */
final class MinimumTimeDifference {
  func mins(_ t: String) -> Int {
      guard let colonIndex = t.firstIndex(of: ":") else {
          return 0
      }

      let hours = t[t.startIndex..<colonIndex]
      let minutes = t[t.index(after: colonIndex)..<t.endIndex]

      guard let hrs = Int(hours),
            let mns = Int(minutes) else {
          return 0
      }

      return hrs * 60 + mns
  }

  func diff(_ t1: Int, _ t2: Int) -> Int {
      let sameDay = abs(t1 - t2)
      let diffDay = 1440 - max(t1, t2) + min(t1, t2)

      return min(sameDay, diffDay)
  }

  func findMinDifference(_ timePoints: [String]) -> Int {
      let minutes = (timePoints.map { mins($0) }).sorted()
      
      var minDiff = Int.max
      for i in 1..<minutes.count {
          minDiff = min(minDiff, minutes[i] - minutes[i - 1])
      }

      minDiff = min(minDiff, diff(minutes[0], minutes[minutes.endIndex - 1]))
      return minDiff
  }
}



// MARK: - My Calendar
/**
 You are implementing a program to use as your calendar. We can add a new event if adding the event will not cause a double booking.
 A double booking happens when two events have some non-empty intersection (i.e., some moment is common to both events.).
 The event can be represented as a pair of integers start and end that represents a booking on the half-open interval [start, end), the range of real numbers x such that start <= x < end.
 Implement the MyCalendar class:
 MyCalendar() Initializes the calendar object.
 boolean book(int start, int end) Returns true if the event can be added to the calendar successfully without causing a double booking. Otherwise, return false and do not add the event to the calendar.
 
 Keywords: time, calendar, booking, overlapping, segments, intervals, segment tree
 */
final class MyCalendar {
  final class MyCalendarShort {
      private var bookings = [[Int]]()
      func book(_ start: Int, _ end: Int) -> Bool {
          for booking in bookings where max(booking[0], start) < min(booking[1], end) {
              return false
          }
          bookings.append([start, end])
          return true
      }
  }

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
}



// MARK: - Next Higher Number
/**
 Compute the next higher number of a given integer using the same digits.
 It is also known as next higher permutation of a given number
 
 Keywords: numbers, permutation
 */
final class NextHigherNumber {
  func getNextHigherPermutation(_ input: Int) -> Int? {
      var inputArray = String(describing: input).compactMap { Int(String($0)) }
      
      var i1 = -1
      
      for i in stride(from: inputArray.count - 1, to: 1, by: -1) {
          if inputArray[i - 1] < inputArray[i] {
              i1 = i - 1
              break
          }
      }
      
      guard i1 >= 0 else { return nil }
      
      var i2 = -1
      
      for i in i1+1..<inputArray.count {
          if inputArray[i] > inputArray[i1] {
              if i2 < 0 || inputArray[i] < inputArray[i2] {
                  i2 = i
              }
          }
      }
      
      inputArray.swapAt(i1, i2)
      
      var resultArray = inputArray[0...i1]
      let sortedSlice = inputArray[i1+1..<inputArray.count].sorted()
      resultArray.append(contentsOf: sortedSlice)
      
      var result = 0
      for i in 0..<resultArray.count {
          result += resultArray[i] * Int(pow(10.0, Double(resultArray.count - i - 1)))
      }
      
      return result
  }
}



// MARK: - Race Car
/**
 Your car starts at position 0 and speed +1 on an infinite number line. Your car can go into negative positions. Your car drives automatically according to a sequence of instructions 'A' (accelerate) and 'R' (reverse):
 When you get an instruction 'A', your car does the following:
 position += speed
 speed *= 2
 When you get an instruction 'R', your car does the following:
 If your speed is positive then speed = -1
 otherwise speed = 1
 Your position stays the same.
 For example, after commands "AAR", your car goes to positions 0 --> 1 --> 3 --> 3, and your speed goes to 1 --> 2 --> 4 --> -1.
 Given a target position target, return the length of the shortest sequence of instructions to get there.
 
 Keywords: dynamic programming
 */
final class RaceCar {
  func racecar(_ target: Int) -> Int {
      var dp: [Int] = Array(repeating: Int.max, count: target + 3)
      dp[0] = 0
      dp[1] = 1
      dp[2] = 4
      
      for t in 0...target {
          let k = 64 - t.leadingZeroBitCount
          
          // First case: t == 2^k - 1     => k
          if t == 1<<k - 1 {
              dp[t] = k
              continue
          }
          
          // Second case: A^(k-1) R A^j R     => k - 1 + j + 2
          for j in 0..<k-1 {
              dp[t] = min(dp[t], dp[t - 1<<(k-1) + 1<<j] + k - 1 + j + 2)
          }
          
          // Third case: A^k R        => k + 1
          if 1<<k - 1 - t < t {
              dp[t] = min(dp[t], dp[1<<k - 1 - t] + k + 1)
          }
      }
      
      return dp[target]
  }
}



// MARK: - Random Pick with Weight
/**
 You are given a 0-indexed array of positive integers w where w[i] describes the weight of the ith index.
 You need to implement the function pickIndex(), which randomly picks an index in the range [0, w.length - 1] (inclusive) and returns it. The probability of picking an index i is w[i] / sum(w).
 For example, if w = [1, 3], the probability of picking index 0 is 1 / (1 + 3) = 0.25 (i.e., 25%), and the probability of picking index 1 is 3 / (1 + 3) = 0.75 (i.e., 75%).
 
 Keywords: random, array
 */
final class RandomPickWithWeight {
  var totalSum = 0
  var prefixSum = ContiguousArray<Int>()

  init(_ w: [Int]) {
      totalSum = 0
      prefixSum.reserveCapacity(w.count)
      for i in 0..<w.count {
          totalSum += w[i]
          prefixSum.append(totalSum)
      }
  }
  
  func pickIndex() -> Int {
      let target = Double.random(in: 0..<1) * Double(totalSum)

      var low = 0
      var high = prefixSum.count
      while (low < high) {
          let mid = low + (high - low) / 2
          if target > Double(prefixSum[mid]) {
              low = mid + 1
          } else {
              high = mid
          }
      }

      return low
  }
}



// MARK: - Range Module
/**
 A Range Module is a module that tracks ranges of numbers. Design a data structure to track the ranges represented as half-open intervals and query about them.
 A half-open interval [left, right) denotes all the real numbers x where left <= x < right.
 Implement the RangeModule class:
 RangeModule() Initializes the object of the data structure.
 void addRange(int left, int right) Adds the half-open interval [left, right), tracking every real number in that interval. Adding an interval that partially overlaps with currently tracked numbers should add any numbers in the interval [left, right) that are not already tracked.
 boolean queryRange(int left, int right) Returns true if every real number in the interval [left, right) is currently being tracked, and false otherwise.
 void removeRange(int left, int right) Stops tracking every real number currently being tracked in the half-open interval [left, right).
 
 Keywords: segments, intervals, segment tree, overlapping
 */
final class RangeModule {
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



// MARK: - Remove All Ones With Row and Column Flips
/**
 You are given an m x n binary matrix grid.
 In one operation, you can choose any row or column and flip each value in that row or column (i.e., changing all 0's to 1's, and all 1's to 0's).
 Return true if it is possible to remove all 1's from grid using any number of operations or false otherwise.
 
 Keywords: two dimension array, 2d array, flips, binary
 */
final class  RemoveAllOnesWithRowAndColumnFlips {
  func removeOnes(_ grid: [[Int]]) -> Bool {
      guard grid.count > 1 else { return true }

      let pattern = grid[0]
      let patternReversed = pattern.map { $0 == 0 ? 1 : 0 }

      for i in 1..<grid.count {
          if grid[i] != pattern && grid[i] != patternReversed {
              return false
          }
      }

      return true
  }
}



// MARK: - Robot Room Cleaner
/**
 You are controlling a robot that is located somewhere in a room. The room is modeled as an m x n binary grid where 0 represents a wall and 1 represents an empty slot.
 The robot starts at an unknown location in the room that is guaranteed to be empty, and you do not have access to the grid, but you can move the robot using the given API Robot.
 You are tasked to use the robot to clean the entire room (i.e., clean every empty cell in the room). The robot with the four given APIs can move forward, turn left, or turn right. Each turn is 90 degrees.
 When the robot tries to move into a wall cell, its bumper sensor detects the obstacle, and it stays on the current cell.
 Design an algorithm to clean the entire room using the following APIs:
 interface Robot {
   // returns true if next cell is open and robot moves into the cell.
   // returns false if next cell is obstacle and robot stays on the current cell.
   boolean move();
   // Robot will stay on the same cell after calling turnLeft/turnRight.
   // Each turn will be 90 degrees.
   void turnLeft();
   void turnRight();
   // Clean the current cell.
   void clean();
 }
 Note that the initial direction of the robot will be facing up. You can assume all four edges of the grid are all surrounded by a wall.
 Custom testing:
 The input is only given to initialize the room and the robot's position internally. You must solve this problem "blindfolded". In other words, you must control the robot using only the four mentioned APIs without knowing the room layout and the initial robot's position.
 
 Keywords: backtrace, graph, search, robot
 */
final class RobotRoomCleaner {
  public class Robot {
    // Returns true if the cell in front is open and robot moves into the cell.
    // Returns false if the cell in front is blocked and robot stays in the current cell.
    public func move() -> Bool { true }
 
    // Robot will stay in the same cell after calling turnLeft/turnRight.
    // Each turn will be 90 degrees.
    public func turnLeft() {}
    public func turnRight() {}
 
    // Clean the current cell.
    public func clean() {}
    
    @discardableResult public func moveBack() -> Bool {
        turnRight()
        turnRight()
        let result = move()
        turnRight()
        turnRight()
        return result
    }
  }
  
  struct Point: Hashable {
      let row: Int
      let col: Int
  }
  
  func cleanRoom(_ robot: Robot) {
      backtrace(robot: robot, point: Point(row: 0, col: 0), direction: 0)
  }

  // Directions in this strict order: up, right, down, left
  let directions: [[Int]] = [[-1, 0], [0, 1], [1, 0], [0, -1]]
  var visited = Set<Point>()

  // Explore
  func backtrace(robot: Robot, point: Point, direction: Int) {
      robot.clean()
      visited.insert(point)
      for i in 0..<4 {
          let newDirection = (direction + i) % 4 // d - from caller, i - current exploration
          let newPoint = Point(row: point.row + directions[newDirection][0],
                               col: point.col + directions[newDirection][1])

          if !visited.contains(newPoint) && robot.move() {
              backtrace(robot: robot, point: newPoint, direction: newDirection)
              robot.moveBack()
          }

          robot.turnRight()
      }
  }
}



// MARK: - Searching in 2D Sorted Array
/**
 Design and implement an effiient algorithm to search for a given integer x in
 a 2-dimensional sorted array a[0..m][0..n]. Please note that it is sorted ro-wise
 and column-wise in ascending order.
 
 Keywords: search, 2d array, saddleback search
 */
final class SearchingIn2DSortedArray {
  func search(a: [[Int]], m: Int, n: Int, x: Int) -> (Int, Int) {
      var i = 0
      var j = n - 1
      while i < m && j >= 0 {
          if a[i][j] == x {
              return (i, j)
          } else if a[i][j] < x {
              i = i + 1
          } else {
              j = j - 1
          }
      }
      return (-1, -1)
  }
}



// MARK: - Shortest Path In A Grid With Obstacles Elimination
/**
 You are given an m x n integer matrix grid where each cell is either 0 (empty) or 1 (obstacle). You can move up, down, left, or right from and to an empty cell in one step.
 Return the minimum number of steps to walk from the upper left corner (0, 0) to the lower right corner (m - 1, n - 1) given that you can eliminate at most k obstacles. If it is not possible to find such walk return -1.
 
 Keywords: A Star search, grid, BFS, obstacles, traversing, path
 */
final class ShortestPathInAGridWithObstaclesElimination {
  final class SimpleSolution {
    func shortestPath(_ grid: [[Int]], _ k: Int) -> Int {
        guard grid.count > 0 else { return -1 }
        guard grid[0].count > 0 else { return -1 }
        guard k >= 0 else { return -1 }
        
        let m = grid.count
        let n = grid[0].count
        
        var solution: [[(steps: Int, obstacles: Int)]] = Array(repeating: Array(repeating: (steps: Int.max, obstacles: Int.max), count: n), count: m)

        // i - row, j - column
        func solve(_ from_i: Int, _ from_j: Int, _ to_i: Int, _ to_j: Int) {
            if from_i < 0 || from_j < 0 {
                solution[0][0] = (steps: 0, obstacles: 0)
            } else {
                guard to_i >= 0 && to_j >= 0 && to_i < m && to_j < n else { return }
                
                let cur_steps: Int = solution[from_i][from_j].steps + 1
                let cur_obstacles: Int = solution[from_i][from_j].obstacles + grid[to_i][to_j]
                
                guard cur_obstacles <= k else { return }
                
                if cur_steps <= solution[to_i][to_j].steps /*&& cur_obstacles <= solution[to_i][to_j].obstacles*/ {
                    if cur_obstacles < solution[to_i][to_j].obstacles || cur_steps < solution[to_i][to_j].steps {
                        solution[to_i][to_j].steps = cur_steps
                        solution[to_i][to_j].obstacles = cur_obstacles
                    } else {
                        return
                    }
                } else {
                    return
                }
            }
            
            solve(to_i, to_j, to_i + 1, to_j)
            solve(to_i, to_j, to_i - 1, to_j)
            solve(to_i, to_j, to_i, to_j + 1)
            solve(to_i, to_j, to_i, to_j - 1)
        }
        
        solve(-1, -1, 0, 0)
        
        let result = solution[m - 1][n - 1].steps
        
        return result == Int.max ? -1 : result
    }
  }
  
  final class OptimizedBFSSolution {
    
    class State: Hashable, Equatable {
        public static func == (lhs: State, rhs: State) -> Bool {
            lhs.i == rhs.i && lhs.j == rhs.j && lhs.k == rhs.k
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(i)
            hasher.combine(j)
            hasher.combine(k)
        }
        
        let i: Int
        let j: Int
        let k: Int
        let s: Int
        var next: State?
        
        init(_ i: Int, _ j: Int, _ k: Int, _ s: Int) {
            self.i = i
            self.j = j
            self.k = k
            self.s = s
        }
    }
    
    class StateQueue {
        private var first: State?
        private var last: State?
        
        var isEmpty: Bool { first == nil }
        
        func enqueue(_ element: State) {
            if last == nil {
                first = element
                last = element
            } else {
                last?.next = element
                last = element
            }
        }
        
        func dequeue() -> State? {
            let element = first
            first = first?.next
            if first == nil {
                last = nil
            }
            return element
        }
    }
    
    func shortestPath(_ grid: [[Int]], _ k: Int) -> Int {
        
        let m = grid.count
        guard m > 0 else { return -1 }
        let n = grid[0].count
        
        // Check for Manhattan distance use case
        if k >= m + n - 2 {
            return m + n - 2
        }
        
        let start = State(0, 0, k, 0)
        let states = StateQueue()
        var seen = Set<State>()
        states.enqueue(start)
        seen.insert(start)
        
        while !states.isEmpty {
            guard let cur = states.dequeue() else { return -1 }
            
            if cur.i == m - 1 && cur.j == n - 1 {
                return cur.s
            }
            
            let next_i = [cur.i - 1, cur.i + 1, cur.i, cur.i]
            let next_j = [cur.j, cur.j, cur.j - 1, cur.j + 1]
            
            for p in 0..<4 {
                let i = next_i[p]
                let j = next_j[p]
                
                if i < 0 || i > m - 1 || j < 0 || j > n - 1 {
                    continue
                }
                
                let nextK = cur.k - grid[i][j]
                
                let nextState = State(i, j, nextK, cur.s + 1)
                if nextK >= 0 && !seen.contains(nextState) {
                    seen.insert(nextState)
                    states.enqueue(nextState)
                }
            }
        }
        
        return -1
    }
  }
  
  class AStarSolution {
      
      /// Current solution state
      class State: Hashable, Equatable {
          public static func == (lhs: State, rhs: State) -> Bool {
              lhs.i == rhs.i && lhs.j == rhs.j && lhs.k == rhs.k
          }
          
          public func hash(into hasher: inout Hasher) {
              hasher.combine(i)
              hasher.combine(j)
              hasher.combine(k)
          }
          
          let i: Int  // row
          let j: Int  // column
          let s: Int  // amount of steps to this position
          let k: Int  // amount of obstacles eliminated
          
          init(i: Int, j: Int, s: Int, k: Int) {
              self.i = i
              self.j = j
              self.s = s
              self.k = k
          }
          
          init?(i: Int, j: Int, s: Int, k: Int, m: Int, n: Int) {
              guard i >= 0 && i < m && j >= 0 && j < n && k >= 0 else { return nil }
              
              self.i = i
              self.j = j
              self.s = s
              self.k = k
          }
          
          // Manhattan distance from this point to the finish point
          func distance(m: Int, n: Int) -> Int {
              m - i + n - j - 2
          }
          
          // Calculates a priority of this step (amount of steps we took + Manhattan distance)
          func estimate(m: Int, n: Int) -> Int {
              s + distance(m: m, n: n)
          }
      }
      
      /// Heap of states
      struct Heap {
          private let m: Int
          private let n: Int
          
          init(m: Int, n: Int) {
              self.m = m
              self.n = n
          }
          
          private var nodes: [State] = []
          
          var count: Int { nodes.count }
          
          var isEmpty: Bool { count == 0 }
          
          @inline(__always) private func leftChildIndex(parentIndex: Int) -> Int { parentIndex * 2 + 1 }
          @inline(__always) private func rightChildIndex(parentIndex: Int) -> Int { parentIndex * 2 + 2 }
          @inline(__always) private func parentIndex(childIndex: Int) -> Int { (childIndex - 1) / 2 }
          
          @inline(__always) private func hasLeftChild(parentIndex: Int) -> Bool { leftChildIndex(parentIndex: parentIndex) < count }
          @inline(__always) private func hasRightChild(parentIndex: Int) -> Bool { rightChildIndex(parentIndex: parentIndex) < count }
          @inline(__always) private func hasParent(childIndex: Int) -> Bool { parentIndex(childIndex: childIndex) >= 0 }
          
          private func leftChildValue(parentIndex: Int) -> State { nodes[leftChildIndex(parentIndex: parentIndex)] }
          private func rightChildValue(parentIndex: Int) -> State { nodes[rightChildIndex(parentIndex: parentIndex)] }
          private func parentValue(childIndex: Int) -> State { nodes[parentIndex(childIndex: childIndex)] }
          
          func peek() -> State {
              nodes[0]
          }
          
          mutating func insert(_ node: State) {
              nodes.append(node)
              heapifyUp()
          }
          
          mutating func poll() -> State {
              let firstNode = nodes.removeFirst()
              if !isEmpty {
                  let lastNode = nodes.removeLast()
                  nodes.insert(lastNode, at: 0)
                  heapifyDown()
              }
              return firstNode
          }
          
          mutating private func heapifyUp() {
              var curIndex = count - 1
              while hasParent(childIndex: curIndex) && parentValue(childIndex: curIndex).estimate(m: m, n: n) > nodes[curIndex].estimate(m: m, n: n) {
                  nodes.swapAt(curIndex, parentIndex(childIndex: curIndex))
                  curIndex = parentIndex(childIndex: curIndex)
              }
          }
          
          mutating private func heapifyDown() {
              var curIndex = 0
              while hasLeftChild(parentIndex: curIndex) {
                  var minEstimateChildIndex = leftChildIndex(parentIndex: curIndex)
                  if hasRightChild(parentIndex: curIndex) && rightChildValue(parentIndex: curIndex).estimate(m: m, n: n) < leftChildValue(parentIndex: curIndex).estimate(m: m, n: n) {
                      minEstimateChildIndex = rightChildIndex(parentIndex: curIndex)
                  }
                  
                  if nodes[curIndex].estimate(m: m, n: n) > nodes[minEstimateChildIndex].estimate(m: m, n: n) {
                      nodes.swapAt(curIndex, minEstimateChildIndex)
                      curIndex = minEstimateChildIndex
                  } else {
                      break
                  }
              }
          }
      }
      
      class PriorityQueue {
          private var heap: Heap
          
          init(m: Int, n: Int) {
              self.heap = Heap(m: m, n: n)
          }
          
          func enqueue(_ state: State) {
              heap.insert(state)
          }
          
          func dequeue() -> State? {
              if !heap.isEmpty {
                  return heap.poll()
              }
              return nil
          }
      }
      
      func shortestPath(_ grid: [[Int]], _ k: Int) -> Int {
          
          let m = grid.count
          let n = grid[0].count
          
          // Check for Manhattan distance use case
          if k >= m + n - 2 {
              return m + n - 2
          }
          
          func obstacle(i: Int, j: Int) -> Int {
              guard i >= 0 && j >= 0 && i < m && j < n else { return 0 }
              return grid[i][j]
          }
          
          let queue = PriorityQueue(m: m, n: n)
          var seen = Set<State>()
          let initialState = State(i: 0, j: 0, s: 0, k: k)
          queue.enqueue(initialState)
          seen.insert(initialState)
          
          while let curState = queue.dequeue() {
              if curState.i < 0 || curState.j < 0 || curState.i > m - 1 || curState.j > n - 1 || curState.k < 0 {
                  continue
              }
              
              if curState.distance(m: m, n: n) <= k {
                  return curState.estimate(m: m, n: n)
              }
              
              if curState.distance(m: m, n: n) <= 0 {
                  return curState.s
              }
              
              let oneDownState = State(i: curState.i, j: curState.j + 1, s: curState.s + 1, k: curState.k - obstacle(i: curState.i, j: curState.j + 1), m: m, n: n)
              let oneRightState = State(i: curState.i + 1, j: curState.j, s: curState.s + 1, k: curState.k - obstacle(i: curState.i + 1, j: curState.j), m: m, n: n)
              
              if curState.i > curState.j {
                  if let oneDownState = oneDownState, !seen.contains(oneDownState) {
                      queue.enqueue(oneDownState)
                  }
                  if let oneRightState = oneRightState, !seen.contains(oneRightState) {
                      queue.enqueue(oneRightState)
                  }
              } else {
                  if let oneRightState = oneRightState, !seen.contains(oneRightState) {
                      queue.enqueue(oneRightState)
                  }
                  if let oneDownState = oneDownState, !seen.contains(oneDownState) {
                      queue.enqueue(oneDownState)
                  }
              }
              
              if let oneLeftState = State(i: curState.i - 1, j: curState.j, s: curState.s + 1, k: curState.k - obstacle(i: curState.i - 1, j: curState.j), m: m, n: n),
                 !seen.contains(oneLeftState) {
                  queue.enqueue(oneLeftState)
              }
              if let oneUpState = State(i: curState.i, j: curState.j - 1, s: curState.s + 1, k: curState.k - obstacle(i: curState.i, j: curState.j - 1), m: m, n: n),
                 !seen.contains(oneUpState) {
                  queue.enqueue(oneUpState)
              }
          }
          
          return -1
      }
  }
}



// MARK: - Shortest Way to Form String
/**
 A subsequence of a string is a new string that is formed from the original string by deleting some (can be none) of the characters without disturbing the relative positions of the remaining characters. (i.e., "ace" is a subsequence of "abcde" while "aec" is not).
 Given two strings source and target, return the minimum number of subsequences of source such that their concatenation equals target. If the task is impossible, return -1.
 
 Keywords: strings, combinations, sequences
 */
final class ShortestWayToFormString {
  final class SimpleSolution {
    func isSubsequence(_ sub: String, source: String) -> Bool {
        var subI = 0
        var srcI = 0
        var matches = 0

        while subI < sub.count && srcI < source.count {
            if source[source.index(source.startIndex, offsetBy: srcI)] == sub[sub.index(sub.startIndex, offsetBy: subI)] {
                subI += 1
                matches += 1
            }
            srcI += 1
        }

        return matches == sub.count
    }
    
    func shortestWay(_ source: String, _ target: String) -> Int {
        var targetCopy = target
        var seq = 0

        while targetCopy.count > 0 {
            var sub = targetCopy
            while targetCopy.count > 0 && sub.count > 0 {
                if isSubsequence(sub, source: source) {
                    seq += 1
                    targetCopy.removeFirst(sub.count)
                    break
                }
                sub.popLast()
            }
            if sub.count == 0 {
                return -1
            }
        }

        return seq
    }
  }
  
  final class OptimizedSolution {
    func shortestWay(_ source: String, _ target: String) -> Int {
        var seq = 0
        var ti = 0
        
        while ti < target.count {
          let sti = ti
            for si in 0..<source.count where ti < target.count {
                if target[target.index(target.startIndex, offsetBy: ti)] == source[source.index(source.startIndex, offsetBy: si)] {
                    ti += 1
                }
            }
            
            if sti == ti {
                return -1
            }
            
            seq += 1
        }
        
        return seq
    }
  }
}



// MARK: - Snapshot Array
/**
 Implement a SnapshotArray that supports the following interface:
 SnapshotArray(int length) initializes an array-like data structure with the given length.  Initially, each element equals 0.
 void set(index, val) sets the element at the given index to be equal to val.
 int snap() takes a snapshot of the array and returns the snap_id: the total number of times we called snap() minus 1.
 int get(index, snap_id) returns the value at the given index, at the time we took the snapshot with the given snap_id
 
 Keywords: array, snapshot, caching, states
 */
final class SnapshotArray {
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



// MARK: - Step By Step Directions From a Binary Tree Node to Another
/**
 You are given the root of a binary tree with n nodes. Each node is uniquely assigned a value from 1 to n. You are also given an integer startValue representing the value of the start node s, and a different integer destValue representing the value of the destination node t.
 Find the shortest path starting from node s and ending at node t. Generate step-by-step directions of such path as a string consisting of only the uppercase letters 'L', 'R', and 'U'. Each letter indicates a specific direction:
 'L' means to go from a node to its left child node.
 'R' means to go from a node to its right child node.
 'U' means to go from a node to its parent node.
 Return the step-by-step directions of the shortest path from node s to node t.
 
 Keywords: binary tree, tree traversal, path in tree, route
 */
final class StepByStepDirectionsFromABinaryTreeNodeToAnother {
  class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    
    init() {
      self.val = 0
    }
    
    init(val: Int) {
      self.val = val
    }
    
    init(val: Int, left: TreeNode?, right: TreeNode?) {
      self.val = val
      self.left = left
      self.right = right
    }
  }
  
  typealias PathFromLCA = (Int, Character)
  
  private var lcaToStart: [PathFromLCA] = []
  private var lcaToDest: [PathFromLCA] = []
  
  private func findLCA(curr: TreeNode, lastDirection: Character, target: Int, path: inout [PathFromLCA]) -> Bool {
    path.append((curr.val, lastDirection))
    
    if curr.val == target {
      return true
    }
    
    if let left = curr.left, findLCA(curr: left, lastDirection: "L", target: target, path: &path) {
      return true
    }
    
    if let right = curr.right, findLCA(curr: right, lastDirection: "R", target: target, path: &path) {
      return true
    }
    
    path.removeLast()
    return false
  }
  
  private func getDirections(_ path: [PathFromLCA]) -> String {
    String(path.map { $0.1 }).trimmingCharacters(in: .whitespacesAndNewlines)
  }
  
  func getDirections(_ root: TreeNode?, _ startValue: Int, _ destValue: Int) -> String {
    guard let root = root else { return "" }
    
    lcaToStart = []
    lcaToDest = []
    guard findLCA(curr: root, lastDirection: " ", target: startValue, path: &lcaToStart),
          findLCA(curr: root, lastDirection: " ", target: destValue, path: &lcaToDest) else {
      return ""
    }
    
    if let startIndexInDestLCA = (lcaToDest.firstIndex { $0.0 == startValue }) {
      // Case 1: Start is parent of Dest
      return String(String((lcaToDest[startIndexInDestLCA..<lcaToDest.endIndex].map { $0.1 })).dropFirst())
    } else if let destIndexInStartLCA = (lcaToStart.firstIndex { $0.0 == destValue } ) {
      // Case 2: Dest is parent of Start
      return String(repeating: "U", count: lcaToStart.count - destIndexInStartLCA - 1)
    } else {
      // Case 3: Start and Dest has LCA
      var lcaIndex = 0
      while lcaIndex < min(lcaToStart.count, lcaToDest.count) && lcaToStart[lcaIndex] == lcaToDest[lcaIndex] {
        lcaIndex += 1
      }
      return String(repeating: "U", count: lcaToStart.count - lcaIndex) + String((lcaToDest.map { $0.1 }).dropFirst(lcaIndex))
    }
  }
}



// MARK: - Stock Price Fluctuation
/**
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
 
 Keywords: heap, stocks, caching
 */
final class StockPriceFluctuation {
  typealias Entry = (Int, Int)
  
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



// MARK: - Student Attendance Record
/**
 An attendance record for a student can be represented as a string where each character signifies whether the student was absent, late, or present on that day. The record only contains the following three characters:
 'A': Absent.
 'L': Late.
 'P': Present.
 Any student is eligible for an attendance award if they meet both of the following criteria:
 The student was absent ('A') for strictly fewer than 2 days total.
 The student was never late ('L') for 3 or more consecutive days.
 Given an integer n, return the number of possible attendance records of length n that make a student eligible for an attendance award. The answer may be very large, so return it modulo 10^9 + 7.
 
 Keywords: dynamic programming, combinations, sequences
 */
final class StudentAttendanceRecord {
  final class Solution {
    private let modular = 1_000_000_000 + 7

    func checkRecord(_ n: Int) -> Int {
        var vals = Array(repeating: 0, count: n + 1)    // starting from "1" (day 1) hence "n+1"

        // calculate for L and P only
        for i in 1...n {
            vals[i] = lpCheck(i)
        }

        var combinations = vals[n]

        // now only one "A" could appear somewhere. Add more combinations:
        for i in 1...n {
            combinations += (lpCheck(i - 1) * 1 * lpCheck(n-i))// % modular
        }

        return combinations % modular
    }

    // returns the list of combinations with L and P only
    private func lpCheck(_ n: Int) -> Int {
        switch n {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 4
        case 3:
            return 7
        default:
            // 2 combinations: (n-1)L and (n-1)P minus (n-4) of "LLL" ending combinations
            return (2 * lpCheck(n - 1) - lpCheck(n - 4))// % modular
        }
    }
  }
  
  final class SolutionOptimized {
    private let modular = 1_000_000_000 + 7
    
    func checkRecord(_ n: Int) -> Int {
        var vals: [Int] = Array(repeating: 0, count: n <= 5 ? 6 : n + 1)    // starting from "1" (day 1) hence "n+1"
        vals[0] = 1
        vals[1] = 2
        vals[2] = 4
        vals[3] = 7
        if n >= 4 {
            for i in 4...n {
                vals[i] = (2 * vals[i - 1] % modular + (modular - vals[i - 4])) % modular
            }
        }
        var combinations = vals[n]
        for i in 1...n {
            combinations += (vals[i - 1] * 1 * vals[n - i]) % modular
        }
        return combinations % modular
    }
  }
}



// MARK: - Swim In Rising Water
/**
 You are given an n x n integer matrix grid where each value grid[i][j] represents the elevation at that point (i, j).
 The rain starts to fall. At time t, the depth of the water everywhere is t. You can swim from a square to another 4-directionally adjacent square if and only if the elevation of both squares individually are at most t. You can swim infinite distances in zero time. Of course, you must stay within the boundaries of the grid during your swim.
 Return the least time until you can reach the bottom right square (n - 1, n - 1) if you start at the top left square (0, 0).
 
 Keywords: 2d array, obstacles, path traversal
 */
final class SwimInRisingWater {
  func swimInWater(_ grid: [[Int]]) -> Int {
      let n = grid.count
      var depths: [[Int]] = Array(repeating: Array(repeating: -1, count: n), count: n)

      func check(_ i: Int, _ j: Int, maxDepth: Int) {
          func checkNext(_ newMaxDepth: Int) {
              guard !(i == n - 1 && j == n - 1) else { return }

              let ii = [-1, 0, 1, 0]
              let jj = [0, -1, 0, 1]
              for k in 0..<4 {
                  let newI = i + ii[k]
                  let newJ = j + jj[k]
                  if newI >= 0 && newI < n && newJ >= 0 && newJ < n {
                      check(newI, newJ, maxDepth: newMaxDepth)
                  }
              }
          }

          if depths[i][j] == -1 {
              depths[i][j] = max(grid[i][j], maxDepth)
              checkNext(depths[i][j])
          } else if depths[i][j] > maxDepth {
              let depth = max(maxDepth, grid[i][j])
              if depth < depths[i][j] {
                  depths[i][j] = depth
                  checkNext(depth)
              }
          }
      }

      check(0, 0, maxDepth: grid[0][0])

      return depths[n-1][n-1]
  }
}



// MARK: - Text Justification
/**
 Given an array of strings words and a width maxWidth, format the text such that each line has exactly maxWidth characters and is fully (left and right) justified.
 You should pack your words in a greedy approach; that is, pack as many words as you can in each line. Pad extra spaces ' ' when necessary so that each line has exactly maxWidth characters.
 Extra spaces between words should be distributed as evenly as possible. If the number of spaces on a line does not divide evenly between words, the empty slots on the left will be assigned more spaces than the slots on the right.
 For the last line of text, it should be left-justified, and no extra space is inserted between words.
 
 Keywords: test, strings, alignment
 */
final class TextJustification {
  private func formWordsLine(_ words: [String]) -> ([String], Int) {
      var wordsLine = [String]()
      var len = 0
      for word in words {
          wordsLine.append(word)
          wordsLine.append(" ")
          len += word.count + 1
      }
      wordsLine.removeLast()
      len -= 1
      return (wordsLine, len)
  }
  
  private func formLine(_ words: [String], _ width: Int) -> String {
      let prep = formWordsLine(words)
      var wordsLine = prep.0
      let len = prep.1
      let spacesNeeded = width - len
      var insertIdx = 1
      var insertedSpaces = 0
      if wordsLine.count == 1 {
          return wordsLine[0].padding(toLength: width, withPad: " ", startingAt: 0)
      } else {
          while insertedSpaces < spacesNeeded {
              if !wordsLine.indices.contains(insertIdx) {
                  insertIdx = 1
              }
              wordsLine[insertIdx] += " "
              insertedSpaces += 1
              insertIdx += 2
          }
          return wordsLine.joined()
      }
  }
  
  private func formLastLine(_ words: [String], _ width: Int) -> String {
      let prep = formWordsLine(words)
      let wordsLine = prep.0
      return wordsLine.joined().padding(toLength: width, withPad: " ", startingAt: 0)
  }
  
  func fullJustify(_ words: [String], _ maxWidth: Int) -> [String] {
      var text = [String]()
      var curr = [String]()
      var currLen = 0
      for i in 0..<words.count {
          let word = words[i]
          if currLen + word.count + curr.count - 1 < maxWidth {
              curr.append(word)
              currLen += word.count
              if i == words.endIndex - 1 {
                  text.append(formLastLine(curr, maxWidth))
              }
          } else {
              text.append(formLine(curr, maxWidth))
              curr = [word]
              currLen = word.count
              if i == words.endIndex - 1 {
                  text.append(formLastLine(curr, maxWidth))
              }
          }
      }

      return text
  }
}



// MARK: - The Earliest Moment When Everyone Become Friends
/**
 There are n people in a social group labeled from 0 to n - 1. You are given an array logs where logs[i] = [timestampi, xi, yi] indicates that xi and yi will be friends at the time timestampi.
 Friendship is symmetric. That means if a is friends with b, then b is friends with a. Also, person a is acquainted with a person b if a is friends with b, or a is a friend of someone acquainted with b.
 Return the earliest time for which every person became acquainted with every other person. If there is no such earliest time, return -1.
 
 Keywords: set, combination, relation, social
 */
final class TheEarliestMomentWhenEveryoneBecomeFriends {
  struct Friends {
      private(set) var timestamp: Int = Int.min
      private var data = [Set<Int>]()
      private(set) var totalFriends: Int = 0
      var everyoneKnownsEachOther: Bool { data.count == 1 }

      @discardableResult mutating func append(entry: [Int]) -> Int {
          var time = entry[0]
          let a = entry[1]
          let b = entry[2]

          let ia = data.firstIndex { $0.contains(a) }
          let ib = data.firstIndex { $0.contains(b) }

          if let ia = ia, let ib = ib {
              // both sets exists
              if ia != ib {
                  // different sets - we need to merge
                  data[ia].formUnion(data[ib])
                  data.remove(at: ib)
              } else {
                  // same sets - do nothing
                  time = Int.min
              }
          } else if let ia = ia, ib == nil {
              // set with "a" exists. Add "b" to this set
              data[ia].insert(b)
              totalFriends += 1
          } else if let ib = ib, ia == nil {
              // set with "b" exists. Add "a" to this set
              data[ib].insert(a)
              totalFriends += 1
          } else {
              // no set exists. Form a new set
              data.append([a, b])
              totalFriends += 2
          }

          updateTimestampIfNeeded(time)
          return totalFriends
      }

      private mutating func updateTimestampIfNeeded(_ other: Int) {
          timestamp = max(timestamp, other)
      }
  }
  
  func earliestAcq(_ logs: [[Int]], _ n: Int) -> Int {
      var friends = Friends()
      var totalFriends = 0
      let sortedLogs = logs.sorted { $0[0] < $1[0] }
      for entry in sortedLogs where !(totalFriends == n && friends.everyoneKnownsEachOther) {
          totalFriends = friends.append(entry: entry)
      }

      if totalFriends == n && friends.everyoneKnownsEachOther {
          return friends.timestamp
      } else {
          return -1
      }
  }
}




// MARK: - Two Sum
/**
 Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.
 You may assume that each input would have exactly one solution, and you may not use the same element twice.
 You can return the answer in any order.
 
 Keywords: sum, array, integers, search back, backtrace
 */
final class TwoSum {
  func twoSumON(_ nums: [Int], _ target: Int) -> [Int] {
      var dict: [Int:Int] = [:]
      for i in 0..<nums.count {
          let search = target - nums[i]
          if let j = dict[search] {
              return [i, j]
          } else {
              dict[nums[i]] = i
          }
      }
      return []
  }
}



// MARK: - Valid Square
/**
 Given the coordinates of four points in 2D space p1, p2, p3 and p4, return true if the four points construct a square.
 The coordinate of a point pi is represented as [xi, yi]. The input is not given in any order.
 A valid square has four equal sides with positive length and four equal angles (90-degree angles).
 
 Keywords: math, geometry, points, coordinates, figures
 */
final class ValidSquare {
  func validSquare(_ p1: [Int], _ p2: [Int], _ p3: [Int], _ p4: [Int]) -> Bool {
      func distance(_ point1: [Int], _ point2: [Int]) -> Double {
          return sqrt(pow(Double(point1[0] - point2[0]), 2) + pow(Double(point1[1] - point2[1]), 2))
      }
      
      func oneLine(_ v1: [Int], _ v2: [Int], _ v3: [Int]) -> Bool {
          return (v1[1] - v2[1]) * (v1[0] - v3[0]) == (v1[1] - v3[1]) * (v1[0] - v2[0])
      }
      
      if oneLine(p1, p2, p3) || oneLine(p1, p2, p4) || oneLine(p2, p3, p4) {
          return false
      }
      
      var distances: Set<Double> = []
      let dp1p2 = distance(p1, p2)
      let dp1p3 = distance(p1, p3)
      let dp1p4 = distance(p1, p4)
      let dp2p3 = distance(p2, p3)
      let dp2p4 = distance(p2, p4)
      let dp3p4 = distance(p3, p4)
      
      distances.insert(dp1p2)
      distances.insert(dp1p3)
      distances.insert(dp1p4)
      distances.insert(dp2p3)
      distances.insert(dp2p4)
      distances.insert(dp3p4)
      
      return distances.count == 2
  }
}
