/**

 

 2115. Find All Possible Recipes from Given Supplies

 https://leetcode.com/problems/find-all-possible-recipes-from-given-supplies/

 

 You have information about n different recipes. You are given a string array recipes and a 2D string array ingredients. The ith recipe has the name recipes[i], and you can create it if you have all the needed ingredients from ingredients[i]. Ingredients to a recipe may need to be created from other recipes, i.e., ingredients[i] may contain a string that is in recipes.



 You are also given a string array supplies containing all the ingredients that you initially have, and you have an infinite supply of all of them.



 Return a list of all the recipes that you can create. You may return the answer in any order.



 Note that two recipes may contain each other in their ingredients.



  



 Example 1:



 Input: recipes = ["bread"], ingredients = [["yeast","flour"]], supplies = ["yeast","flour","corn"]

 Output: ["bread"]

 Explanation:

 We can create "bread" since we have the ingredients "yeast" and "flour".

 Example 2:



 Input: recipes = ["bread","sandwich"], ingredients = [["yeast","flour"],["bread","meat"]], supplies = ["yeast","flour","meat"]

 Output: ["bread","sandwich"]

 Explanation:

 We can create "bread" since we have the ingredients "yeast" and "flour".

 We can create "sandwich" since we have the ingredient "meat" and can create the ingredient "bread".

 Example 3:



 Input: recipes = ["bread","sandwich","burger"], ingredients = [["yeast","flour"],["bread","meat"],["sandwich","meat","bread"]], supplies = ["yeast","flour","meat"]

 Output: ["bread","sandwich","burger"]

 Explanation:

 We can create "bread" since we have the ingredients "yeast" and "flour".

 We can create "sandwich" since we have the ingredient "meat" and can create the ingredient "bread".

 We can create "burger" since we have the ingredient "meat" and can create the ingredients "bread" and "sandwich".

  



 Constraints:



 n == recipes.length == ingredients.length

 1 <= n <= 100

 1 <= ingredients[i].length, supplies.length <= 100

 1 <= recipes[i].length, ingredients[i][j].length, supplies[k].length <= 10

 recipes[i], ingredients[i][j], and supplies[k] consist only of lowercase English letters.

 All the values of recipes and supplies combined are unique.

 Each ingredients[i] does not contain any duplicate values.

 

 */



import Foundation



typealias SampleData = ([String], [[String]], [String])



let example0: SampleData = (["a", "b"], [["b", "c"], ["a", "c"]], ["c"])

let example1: SampleData = (["bread"], [["yeast","flour"]], ["yeast","flour","corn"])

let example2: SampleData = (["bread","sandwich"], [["yeast","flour"],["bread","meat"]], ["yeast","flour","meat"])

let example3: SampleData = (["bread","sandwich","burger"], [["yeast","flour"],["bread","meat"],["sandwich","meat","bread"]], ["yeast","flour","meat"])

let example4: SampleData = (["ju","fzjnm","x","e","zpmcz","h","q"],

                            [

                                ["d"],

                                ["hveml","f","cpivl"],

                                ["cpivl","zpmcz","h","e","fzjnm","ju"],

                                ["cpivl","hveml","zpmcz","ju","h"],

                                ["h","fzjnm","e","q","x"],

                                ["d","hveml","cpivl","q","zpmcz","ju","e","x"],

                                ["f","hveml","cpivl"]

                            ],

                            ["f","hveml","cpivl","d"]

                           )



class Solution {

    // Complexity O(N Log(N)), Space: O(N)

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



let solution = Solution()

print(solution.findAllRecipes(example0.0, example0.1, example0.2))

print(solution.findAllRecipes(example1.0, example1.1, example1.2))

print(solution.findAllRecipes(example2.0, example2.1, example2.2))

print(solution.findAllRecipes(example3.0, example3.1, example3.2))

print(solution.findAllRecipes(example4.0, example4.1, example4.2))
