/**
 
 2013. Detect Squares
 https://leetcode.com/problems/detect-squares/
 
 You are given a stream of points on the X-Y plane. Design an algorithm that:

 Adds new points from the stream into a data structure. Duplicate points are allowed and should be treated as different points.
 Given a query point, counts the number of ways to choose three points from the data structure such that the three points and the query point form an axis-aligned square with positive area.
 An axis-aligned square is a square whose edges are all the same length and are either parallel or perpendicular to the x-axis and y-axis.

 Implement the DetectSquares class:

 DetectSquares() Initializes the object with an empty data structure.
 void add(int[] point) Adds a new point point = [x, y] to the data structure.
 int count(int[] point) Counts the number of ways to form axis-aligned squares with point point = [x, y] as described above.
 
 Input
 ["DetectSquares", "add", "add", "add", "count", "count", "add", "count"]
 [[], [[3, 10]], [[11, 2]], [[3, 2]], [[11, 10]], [[14, 8]], [[11, 2]], [[11, 10]]]
 Output
 [null, null, null, null, 1, 0, null, 2]

 Explanation
 DetectSquares detectSquares = new DetectSquares();
 detectSquares.add([3, 10]);
 detectSquares.add([11, 2]);
 detectSquares.add([3, 2]);
 detectSquares.count([11, 10]); // return 1. You can choose:
                                //   - The first, second, and third points
 detectSquares.count([14, 8]);  // return 0. The query point cannot form a square with any points in the data structure.
 detectSquares.add([11, 2]);    // Adding duplicate points is allowed.
 detectSquares.count([11, 10]); // return 2. You can choose:
                                //   - The first, second, and third points
                                //   - The first, third, and fourth points
 
 Constraints:

 point.length == 2
 0 <= x, y <= 1000
 At most 3000 calls in total will be made to add and count.
 
 */

import Foundation

// Size: O(N), Speed: O(1)
class DetectSquares {
    
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

    init() {
        
    }

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

/**
 * Your DetectSquares object will be instantiated and called as such:
 * let obj = DetectSquares()
 * obj.add(point)
 * let ret_2: Int = obj.count(point)
 */
