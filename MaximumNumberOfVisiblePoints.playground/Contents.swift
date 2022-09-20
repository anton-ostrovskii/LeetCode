/**
 
 1610. Maximum Number of Visible Points
 https://leetcode.com/problems/maximum-number-of-visible-points/
 
 You are given an array points, an integer angle, and your location, where location = [posx, posy] and points[i] = [xi, yi] both denote integral coordinates on the X-Y plane.

 Initially, you are facing directly east from your position. You cannot move from your position, but you can rotate. In other words, posx and posy cannot be changed. Your field of view in degrees is represented by angle, determining how wide you can see from any given view direction. Let d be the amount in degrees that you rotate counterclockwise. Then, your field of view is the inclusive range of angles [d - angle/2, d + angle/2].
 
 You can see some set of points if, for each point, the angle formed by the point, your position, and the immediate east direction from your position is in your field of view.

 There can be multiple points at one coordinate. There may be points at your location, and you can always see these points regardless of your rotation. Points do not obstruct your vision to other points.

 Return the maximum number of points you can see.
 
 Example 1:

 Input: points = [[2,1],[2,2],[3,3]], angle = 90, location = [1,1]
 Output: 3
 Explanation: The shaded region represents your field of view. All points can be made visible in your field of view, including [3,3] even though [2,2] is in front and in the same line of sight.
 
 Example 2:

 Input: points = [[2,1],[2,2],[3,4],[1,1]], angle = 90, location = [1,1]
 Output: 4
 Explanation: All points can be made visible in your field of view, including the one at your location.
 
 Example 3:

 Input: points = [[1,0],[2,1]], angle = 13, location = [1,1]
 Output: 1
 Explanation: You can only see one of the two points, as shown above.
 
 */

import Foundation

// This is a tricky problem which requires math skills. This solution uses a sliding window technique
class Solution {
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
