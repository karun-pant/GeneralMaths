/**
 Geometric progression sum
 a, ar, ar2, ar3,……arn-1 is called finite geometric series.
 
 Sn = a[(rn – 1)/(r – 1)] if r ≠ 1 and r > 1
 Sn = a[(1 – rn)/(1 – r)] if r ≠ 1 and r < 1
 Sn = na if r = 1
 
 a, ar, ar2, ar3, ……arn-1,……. is called infinite geometric series.
 
 The sum of infinite geometric series is given by:
 a / (1 - r)
 
 This is called the geometric progression formula of sum to infinity.
 
 a is the first term
 r is the common ratio
 n is the number of terms
 */
import Foundation

func gpSumInfinite(a: Double,
                   r: Double,
                   n: Double) -> Double {
    guard n == Double.infinity,
          r >= 0,
          r <= 1 else {
        fatalError("Use only when infinite terms are there")
    }
    return a / (1 - r)
}

func gpSum(firstTerm a: Double,
           ratio r: Double,
           numberOfTerms n: Double) -> Double {
    guard n > 0 else {
        fatalError("Finite sum for a positive ration")
    }
    if n == Double.infinity {
        gpSumInfinite(a: a, r: r, n: n)
    }
    if r == 1 {
        return n * a
    }
    if r > 1 {
        return a * ((pow(r, n)) - 1)/(r - 1)
    } else {
        return a * (1 - (r * n))/(1 - r)
    }
}

/**
 Example: SIP increasing by some percent every year. And calculating invested amount.
 */
func investedAmount(firstYearSIP f: Double,
                    incrementPercentage r: Double,
                    numberOfYears n: Int) -> Double {
    // 1. s0 = 10 pm
    // 2. s1 = 10 * 1.06  = 10.6 pm
    // 3. s2 = 10 * 1.06 ^ 2 = 11.236 pm
    // 4. s3 = 10 * 1.06 ^ 3 = 11.91 pm
    // Total = s0 * 12 + s1 * 12 + s2 * 12 + s3 * 12 = 12(s0 + s1 + s2 + s3) = 12 * gpsum(10, 1.06, 4)
    let totalSIP = gpSum(firstTerm: f,
                         ratio: (1 + (r/100)),
                         numberOfTerms: Double(n))
    return 12 * totalSIP
}

let formatter = NumberFormatter()              // Cache this, NumberFormatter creation is expensive.
formatter.locale = Locale(identifier: "en_IN") // Here indian locale with english language is used
formatter.numberStyle = .decimal
let firstYearSIP: Double = 50000
let yearlyIncerement: Double = 6
let years: Int = 5
let invested = investedAmount(firstYearSIP: firstYearSIP,
                              incrementPercentage: yearlyIncerement,
                              numberOfYears: years)
let expectedProfitPercent: Double = 50
print("==== In \(years)Years ====")
print("Total Invested: \(formatter.string(from: NSNumber.init(floatLiteral: invested)) ?? "Unable to Calculate")")
print("Expected Profit: \((formatter.string(from: NSNumber.init(floatLiteral: invested * expectedProfitPercent/100)) ?? "Unable to Calculate"))")
print("Total: \((formatter.string(from: NSNumber.init(floatLiteral: invested * (1 + expectedProfitPercent/100))) ?? "Unable to Calculate"))")
