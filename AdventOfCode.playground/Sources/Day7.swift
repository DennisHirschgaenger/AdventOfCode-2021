import Foundation

public enum Day7 {
    public static func puzzle1() -> Int {
        let crabPositions: [Int] = loadCommaSeparatedInput(forDay: 7)

        return computeOptimalFuel(crabPositions: crabPositions) { position in
            crabPositions.reduce(0) { totalFuel, crabPosition in
                totalFuel + abs(crabPosition - position)
            }
        }
    }

    private static func computeOptimalFuel(crabPositions: [Int], computeFuelForPosition: (Int) -> Int) -> Int {
        let average = Int(round(Double(crabPositions.reduce(0) { $0 + $1 }) / Double(crabPositions.count)))

        var currentPosition = average
        var optimalFuel = computeFuelForPosition(average)

        let isCurrentPositionTooSmall: Bool
        if computeFuelForPosition(average + 1) < optimalFuel {
            isCurrentPositionTooSmall = true
        } else if computeFuelForPosition(average - 1) < optimalFuel {
            isCurrentPositionTooSmall = false
        } else {
            return optimalFuel
        }

        while true {
            let newPosition = isCurrentPositionTooSmall ? currentPosition + 1 : currentPosition - 1
            let newFuel = computeFuelForPosition(newPosition)
            if newFuel >= optimalFuel {
                return optimalFuel
            }
            currentPosition = newPosition
            optimalFuel = newFuel
        }
    }
}

public extension Day7 {
    static func puzzle2() -> Int {
        let crabPositions: [Int] = loadCommaSeparatedInput(forDay: 7)

        var fuels = [0]
        return computeOptimalFuel(crabPositions: crabPositions) { position in
            crabPositions.reduce(0) { totalFuel, crabPosition in
                let distance = abs(crabPosition - position)
                while !fuels.indices.contains(distance) {
                    fuels.append(fuels.last! + fuels.endIndex)
                }
                return totalFuel + fuels[distance]
            }
        }
    }
}
