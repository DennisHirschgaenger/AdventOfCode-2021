import Foundation

public enum Day<#X#> {
    public static func puzzle1() -> Int {
        let input = loadInput()
        return 0
    }

    static func loadInput() -> [Int] {
        guard let fileURL = Bundle.main.url(forResource: "input-day<#X#>", withExtension: "txt"),
        let input = try? String(contentsOf: fileURL, encoding: .utf8) else {
            fatalError("Failed to load input")
        }
        return input.trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .controlCharacters)
            .compactMap(Int.init)
    }
}

public extension Day1 {
    static func puzzle2() -> Int {
        let input = loadInput()
        return 0
    }
}

let start = Date()
let result = Day<#X#>.puzzle1()
print(result)
print("Execution time: \(Date().timeIntervalSince(start))")
