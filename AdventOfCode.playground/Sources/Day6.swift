import Foundation

public enum Day6 {
    public static func puzzle1() -> Int {
        let lanternFish: [Int] = loadCommaSeparatedInput(forDay: 6)

        let fishDict = setUpDictionary(forFish: lanternFish)
        return computeNumberOfFish(initialDict: fishDict, afterDays: 80)
    }

    private static func setUpDictionary(forFish lanternFish: [Int]) -> [Int: Int] {
        lanternFish.reduce([Int: Int]()) { dict, fish in
            var dict = dict
            if let count = dict[fish] {
                dict[fish] = count + 1
            } else {
                dict[fish] = 1
            }
            return dict
        }
    }

    private static func computeNumberOfFish(initialDict: [Int: Int], afterDays days: Int) -> Int {
        var fishDict = initialDict
        var totalCount = fishDict.values.reduce(0) { $0 + $1 }
        for _ in 0..<days {
            fishDict = fishDict.reduce([Int: Int]()) { dict, element in
                var dict = dict
                if element.key == 0 {
                    dict[6] = (dict[6] ?? 0) + element.value
                    dict[8] = element.value
                } else {
                    dict[element.key - 1] = (dict[element.key - 1] ?? 0) + element.value
                }
                return dict
            }
            totalCount = fishDict.values.reduce(0) { $0 + $1 }
        }
        return totalCount
    }
}

public extension Day6 {
    static func puzzle2() -> Int {
        let lanternFish: [Int] = loadCommaSeparatedInput(forDay: 6)

        let fishDict = setUpDictionary(forFish: lanternFish)
        return computeNumberOfFish(initialDict: fishDict, afterDays: 256)
    }
}
