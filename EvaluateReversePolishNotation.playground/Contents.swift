/**
 150. Evaluate Reverse Polish Notation
 https://leetcode.com/problems/evaluate-reverse-polish-notation/
 
 Evaluate the value of an arithmetic expression in Reverse Polish Notation.

 Valid operators are +, -, *, and /. Each operand may be an integer or another expression.

 Note that division between two integers should truncate toward zero.

 It is guaranteed that the given RPN expression is always valid. That means the expression would always evaluate to a result, and there will not be any division by zero operation.

 Example 1:

 Input: tokens = ["2","1","+","3","*"]
 Output: 9
 Explanation: ((2 + 1) * 3) = 9
 
 Example 2:

 Input: tokens = ["4","13","5","/","+"]
 Output: 6
 Explanation: (4 + (13 / 5)) = 6
 
 Example 3:

 Input: tokens = ["10","6","9","3","+","-11","*","/","*","17","+","5","+"]
 Output: 22
 Explanation: ((10 * (6 / ((9 + 3) * -11))) + 17) + 5
 = ((10 * (6 / (12 * -11))) + 17) + 5
 = ((10 * (6 / -132)) + 17) + 5
 = ((10 * 0) + 17) + 5
 = (0 + 17) + 5
 = 17 + 5
 = 22
  

 Constraints:

 1 <= tokens.length <= 10^4
 tokens[i] is either an operator: "+", "-", "*", or "/", or an integer in the range [-200, 200].
 */

import Foundation

let ex1 = ["2","1","+","3","*"]
let ex2 = ["4","13","5","/","+"]
let ex3 = ["10","6","9","3","+","-11","*","/","*","17","+","5","+"]

class Solution {
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

let solution = Solution()
print(solution.evalRPN(ex1))
print(solution.evalRPN(ex2))
print(solution.evalRPN(ex3))
