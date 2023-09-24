import UIKit

/* 1. გვაქვს 1,5,10,20 და 50 თეთრიანი მონეტები. დაწერეთ ფუნქცია, რომელსაც გადაეცემა თანხა (თეთრებში) და აბრუნებს მონეტების მინიმალურ რაოდენობას, რომლითაც შეგვიძლია ეს თანხა დავახურდაოთ.


    func minSplit(amount: Int) -> Int {
        // Your code goes here
    }

    Examples:
    minSplit(9) ➞ 5  //(1, 1, 1, 1, 5)
    minSplit(26) ➞ 3  //(1, 5, 20)
    minSplit(172) ➞ 6  //(1, 1, 20, 50, 50, 50)
 */

func minSplit(amount: Int) -> Int {
    var coins = [1, 5, 10, 20, 50]
    var dp = Array(repeating: amount + 1, count: amount + 1)
    
    dp[0] = 0
    
    for i in 1...amount {
        for coin in coins {
            if i - coin >= 0 {
                dp[i] = min(dp[i], 1 + dp[i - coin])
            }
        }
    }
    
    return dp[amount] == amount + 1 ? 0 : dp[amount]
}

minSplit(amount: 4)

/* 2. დაწერეთ ფუნქცია რომელიც დააჯამებს ციფრებს ორ რიცსხვს შორის.
 მაგალითად გადმოგვეცემა 19 და 22. მათ შორის ციფრების ჯამი იქნება :
 // 19, 20, 21, 22
 // (1 + 9) + (2 + 0) + (2 + 1) + (2 + 2) = 19

 func sumOfDigits(start: Int, end: Int) -> Int {
     // Your code goes here
 }

 sumOfDigits(7, 8) ➞ 15
 sumOfDigits(17, 20) ➞ 29
 sumOfDigits(10, 12) ➞ 6
 */

func sumOfDigits(start: Int, end: Int) -> Int {
    var sum = 0
    
    for i in start...end {
        var temp = i
        var tempSum = 0
        
        while temp != 0 {
            tempSum += temp % 10
            temp /= 10
        }
        sum += tempSum
    }
    return sum
}

sumOfDigits(start: 10, end: 12)

/* 3. მოცემულია String რომელიც შედგება „(" და „)" ელემენტებისგან. დაწერეთ ფუნქცია რომელიც აბრუნებს ფრჩხილები არის თუ არა მათემატიკურად სწორად დასმული.
 
 func isProperly(sequence: String) -> Bool {
     // Your code goes here
 }

 Examples:
 isProperly(sequence: "(()())") ➞ true
 isProperly(sequence: ")(()") ➞ false
 isProperly(sequence: "(()())(") ➞ false
 */

func isProperly(sequence: String) -> Bool {
    var count = 0
    
    for i in sequence {
        if i == "(" {
            count += 1
        } else {
            count -= 1
        }
        if count < 0 {
            return false
        }
    }
    return count == 0
}

isProperly(sequence: "(()())(")

/* 4. გვაქვს N ფიცრისგან შემდგარი ხიდი. სიძველის გამო ზოგიერთი ფიცარი ჩატეხილია. ზურიკოს შეუძლია გადავიდეს შემდეგ ფიცარზე ან გადაახტეს ერთ ფიცარს. (რათქმაუნდა ჩატეხილ   ფიცარზე ვერ გადავა)
 ჩვენი ამოცანაა დავითვალოთ რამდენი განსხვავებული კომბინაციით შეუძლია ზურიკოს ხიდის გადალახვა. გადმოგვეცემა ხიდის სიგრძე და ინფორმაცია ჩატეხილ ფიცრებზე. 0 აღნიშნავს ჩატეხილ ფიცარს 1_ანი კი მთელს. დასაწყისისთვის ზურიკო დგას ხიდის ერთ მხარეს (არა პირველ ფიცარზე) და გადალახვად ჩათვლება ხიდის მეორე მხარე (ბოლო ფიცრის შემდეგი ნაბიჯი)


 func countWays(n: Int, steps: [Int]) -> Int {
         // Your code goes here
 }

 Examples:
 countWays(n: 3, steps: [0, 1, 0]) ➞ 1
 countWays(n: 4, steps: [0, 1, 1, 0]) ➞ 0
 countWays(n: 5, steps: [1, 1, 0, 1, 1]) ➞ 4 // (s, 1, 2, 4, 5, f), (s, 1, 2, 4, f), (s, 2, 4, 5, f), (s, 2, 4, f)  s - ხიდის ერთი მხარე, f - ხიდის მეორე მხარე
 */


func countWays(n: Int, steps: [Int]) -> Int {
    let extendedSteps = [1,1] + steps + [1]
    
    var dp = Array(repeating: 0, count: n + 3)
    
    func rec(_ i: Int) -> Int {
        if i <= 2 { return 1 }
        
        switch (extendedSteps[i - 1], extendedSteps[i - 2]) {
        case (1, 1):
            dp[i] = rec(i - 1) + rec(i - 2)
        case (0, 0):
            dp[i] = 0
        default:
            dp[i] = rec(extendedSteps[i - 1] == 1 ? i - 1 : i - 2)
        }
        return dp[i]
    }
    
    return rec(n + 2)
}

countWays(n: 4, steps: [0, 1, 1, 0])

/* 5. გადმოგეცემათ მთელი რიცხვი N. დაწერეთ ფუნქცია რომელიც დაითვლის რამდენი 0ით ბოლოვდება N! (ფაქტორიალი)
     შენიშვნა 1000! შედგება 2568 სიმბოლოსაგან.

     func zeros(N: Int) -> Int {
         // Your code goes here
     }

     example:
     zeros(N: 7) ➞ 1
     zeros(N: 12) ➞ 2
     zeros(N: 490) ➞ 120
*/


func zeros(N: Int) -> Int {
    var sum = 0
    var i = N
    
    while i >= 5 {
        i /= 5
        sum += i
    }
    return sum
}

zeros(N: 100)
