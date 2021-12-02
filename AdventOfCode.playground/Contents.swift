import Foundation

public enum Day<#X#> {
    public static func puzzle1() -> Int {
        let input: [Int] = loadInput(forDay: <#X#>)
        return 0
    }
}

public extension Day<#X#> {
    static func puzzle2() -> Int {
        let input: [String] = loadInput(forDay: <#X#>)
        return 0
    }
}

let start = Date()
let result = Day<#X#>.puzzle1()
print(result)
print("Execution time: \(Date().timeIntervalSince(start))")
