/**
https://leetcode.com/problems/shortest-path-in-a-grid-with-obstacles-elimination/
 
 You are given an m x n integer matrix grid where each cell is either 0 (empty) or 1 (obstacle). You can move up, down, left, or right from and to an empty cell in one step.

 Return the minimum number of steps to walk from the upper left corner (0, 0) to the lower right corner (m - 1, n - 1) given that you can eliminate at most k obstacles. If it is not possible to find such walk return -1.

 Example 1:
 
 Input: grid = [[0,0,0],[1,1,0],[0,0,0],[0,1,1],[0,0,0]], k = 1
 Output: 6
 Explanation:
 The shortest path without eliminating any obstacle is 10.
 The shortest path with one obstacle elimination at position (3,2) is 6. Such path is (0,0) -> (0,1) -> (0,2) -> (1,2) -> (2,2) -> (3,2) -> (4,2).
 
 Example 2:
 
 Input: grid = [[0,1,1],[1,1,1],[1,0,0]], k = 1
 Output: -1
 Explanation: We need to eliminate at least two obstacles to find such a walk.
 
  Constraints:

  m == grid.length
  n == grid[i].length
  1 <= m, n <= 40
  1 <= k <= m * n
  grid[i][j] is either 0 or 1.
  grid[0][0] == grid[m - 1][n - 1] == 0
 */

import Foundation

// 6
let grid_ex1: [[Int]] = [[0,0,0],[1,1,0],[0,0,0],[0,1,1],[0,0,0]]
let k_ex1 = 1

// -1
let grid_ex2: [[Int]] = [[0,1,1],[1,1,1],[1,0,0]]
let k_ex2 = 1

// 20
let grid_ex3: [[Int]] = [[0,0,0,0,0,0,0,0,0,0],[0,1,1,1,1,1,1,1,1,0],[0,1,0,0,0,0,0,0,0,0],[0,1,0,1,1,1,1,1,1,1],[0,1,0,0,0,0,0,0,0,0],[0,1,1,1,1,1,1,1,1,0],[0,1,0,0,0,0,0,0,0,0],[0,1,0,1,1,1,1,1,1,1],[0,1,0,1,1,1,1,0,0,0],[0,1,0,0,0,0,0,0,1,0],[0,1,1,1,1,1,1,0,1,0],[0,0,0,0,0,0,0,0,1,0]]
let k_ex3 = 1

// 41
let grid_ex4: [[Int]] = [[0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,1,1,1,1,1,0,0,0,1,1],[1,1,1,1,1,0,0,1,0,0,1,1,0,1,0,1,1,0,1,0,0,1,0,0,1,0,1,1,1,0,1,0,0,0],[1,0,0,1,0,0,1,0,0,1,0,0,1,1,1,0,0,1,0,1,1,1,1,0,0,0,0,0,0,1,1,1,0,0],[0,0,1,0,0,1,0,1,0,0,1,0,1,1,0,1,1,1,1,1,1,1,1,0,1,0,0,1,0,0,1,1,0,0],[1,1,0,0,0,1,1,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0],[0,1,0,1,0,0,0,1,0,1,1,1,0,0,1,0,1,1,0,0,0,0,0,0,1,1,1,1,0,0,0,0,1,1],[0,0,0,0,0,0,0,0,0,1,1,0,0,1,0,1,1,0,1,1,1,0,0,1,1,1,1,1,0,1,0,0,1,0],[1,0,0,1,0,0,0,0,1,1,0,0,1,0,1,0,0,0,0,1,0,1,1,0,0,1,0,0,1,0,0,1,0,1],[1,1,1,0,0,1,0,0,1,1,0,1,1,0,1,1,1,1,1,1,1,1,1,0,0,1,0,0,0,1,0,0,1,0]]
let k_ex4 = 283

// Complexity: Speed: O(n2). Memory: O(n)
class SimpleSolution {
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

//let solution = SimpleSolution()
//print("ex1: \(solution.shortestPath(grid_ex1, k_ex1))")
//print("ex2: \(solution.shortestPath(grid_ex2, k_ex2))")
//print("ex3: \(solution.shortestPath(grid_ex3, k_ex3))")
//print("ex4: \(solution.shortestPath(grid_ex4, k_ex4))")




// Speed: O(N*K). Space: O(N*K). N - amount of cell in the grid. K - number of obstacles (becase we should not see the same cell more times than obstacles amount)
class OptimizedBFSSolution {
    
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

//let optimizedSolution = OptimizedBFSSolution()
//print("ex1: \(optimizedSolution.shortestPath(grid_ex1, k_ex1))")
//print("ex2: \(optimizedSolution.shortestPath(grid_ex2, k_ex2))")
//print("ex3: \(optimizedSolution.shortestPath(grid_ex3, k_ex3))")
//print("ex4: \(optimizedSolution.shortestPath(grid_ex4, k_ex4))")

// Speed: O(N*K). Space: O(N*K). N - amount of cell in the grid. K - number of obstacles (becase we should not see the same cell more times than obstacles amount)

/*
 A Star Search, Informed Search Algorithm, Best First Search
 
 Use a priority queue to navigate to the best possible positions first.
 
 Complexity. Speed: O(LogN*K)? Size: O(N*K) - check
 */
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

let aStarSolution = AStarSolution()
print("ex1: \(aStarSolution.shortestPath(grid_ex1, k_ex1))")
print("ex2: \(aStarSolution.shortestPath(grid_ex2, k_ex2))")
print("ex3: \(aStarSolution.shortestPath(grid_ex3, k_ex3))")
print("ex4: \(aStarSolution.shortestPath(grid_ex4, k_ex4))")

