import Foundation

public enum Day1 {
    public static func puzzle1() -> Int {
        return 0
    }
    
    static func loadInput() -> [Int] {
        guard let fileURL = Bundle.main.url(forResource: "input-day1", withExtension: "txt"),
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
        return 0
    }
}
