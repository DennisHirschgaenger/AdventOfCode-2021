import Foundation

public enum Day6 {
    public static func puzzle1() -> Int {
        let population: [Int] = loadCommaSeparatedInput(forDay: 6)
        return computeFishCount(afterDays: 80, initialPopulation: population)
    }

    private static func computeFishCount(afterDays numberOfDays: Int, initialPopulation: [Int]) -> Int {
        var dict = Dictionary(grouping: initialPopulation, by: { $0 }).mapValues(\.count)
        for _ in 0..<numberOfDays {
            dict = dict.reduce([Int: Int]()) { dict, element in
                var dict = dict
                if element.key == 0 {
                    dict[6] = (dict[6] ?? 0) + element.value
                    dict[8] = element.value
                } else {
                    dict[element.key - 1] = (dict[element.key - 1] ?? 0) + element.value
                }
                return dict
            }
        }
        return dict.values.reduce(0) { $0 + $1 }
    }
}

public extension Day6 {
    static func puzzle2() -> Int {
        let population: [Int] = loadCommaSeparatedInput(forDay: 6)
        return computeFishCount(afterDays: 256, initialPopulation: population)
    }
}
