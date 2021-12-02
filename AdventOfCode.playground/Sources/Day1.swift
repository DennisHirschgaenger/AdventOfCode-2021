import Foundation

public enum Day1 {
    public static func puzzle1() -> Int {
        let depths: [Int] = loadInput(forDay: 1)
        var numberOfIncrements = 0
        var previousDepth: Int?
        for depth in depths {
            if let previousDepth = previousDepth, depth > previousDepth {
                numberOfIncrements += 1
            }
            previousDepth = depth
        }
        return numberOfIncrements
    }
}

public extension Day1 {
    static func puzzle2() -> Int {
        let depths: [Int] = loadInput(forDay: 1)
        var numberOfIncrements = 0
        var previousDepth: Int?
        for index in depths.indices {
            guard depths.indices.contains(index + 2) else {
                break
            }
            let newDepth = depths[index] + depths[index + 1] + depths[index + 2]
            if let previousDepth = previousDepth, newDepth > previousDepth {
                numberOfIncrements += 1
            }
            previousDepth = newDepth
        }
        return numberOfIncrements
    }
}
