import Foundation

typealias Digit = Int

extension Digit {
    init?(segments: String) {
        switch String(segments.sorted()) {
        case "abcefg":
            self = 0
        case "cf":
            self = 1
        case "acdeg":
            self = 2
        case "acdfg":
            self = 3
        case "bcdf":
            self = 4
        case "abdfg":
            self = 5
        case "abdefg":
            self = 6
        case "acf":
            self = 7
        case "abcdefg":
            self = 8
        case "abcdfg":
            self = 9
        default:
            return nil
        }
    }
}

struct SevenSegmentExpression: StringConvertible {
    let input: [String]
    let output: [String]

    init?(_ string: String) {
        let components = string.components(separatedBy: "|").map { $0.trimmingCharacters(in: .whitespaces) }
        guard components.count == 2 else {
            return nil
        }
        self.input = components[0].components(separatedBy: .whitespaces)
        self.output = components[1].components(separatedBy: .whitespaces)
    }

    func computeCorrectedOutput() -> Int {
        let segmentMapping = determineSegmentMapping()

        let invertedSegmentMapping = segmentMapping.reduce([Character: Character]()) { mapping, entry in
            var mapping = mapping
            mapping[entry.value] = entry.key
            return mapping
        }

        let digits = output.map { String($0.compactMap { invertedSegmentMapping[$0] }) }.compactMap(Digit.init)

        return Int(digits.map(String.init).joined())!
    }

    private func determineSegmentMapping() -> [Character: Character] {
        var segmentMapping = [Character: Character]()

        let eight = input.first { $0.count == 7 }!

        // Determine segment 'a'
        let seven = input.first { $0.count == 3 }!
        let one = input.first { $0.count == 2 }!
        segmentMapping["a"] = Set(seven).subtracting(Set(one)).first!

        // Determine segment 'c'
        let sixSegmentNumbers = input.filter { $0.count == 6 }
        let six = sixSegmentNumbers.first { !$0.contains(one.first!) || !$0.contains(one.last!) }!
        segmentMapping["c"] = Set(one).subtracting(Set(six)).first!

        // Determine segment 'f'
        segmentMapping["f"] = one.first { !segmentMapping.values.contains($0) }!

        // Determine segment 'e'
        let four = input.first { $0.count == 4 }!
        let nine = sixSegmentNumbers.first { Set($0).subtracting(Set(four)).count == 2 }!
        segmentMapping["e"] = Set(eight).subtracting(nine).first!

        // Determine segment 'd'
        let zero = Set(sixSegmentNumbers).subtracting(Set(arrayLiteral: six, nine)).first!
        segmentMapping["d"] = Set(eight).subtracting(Set(zero)).first!


        // Determine segment 'b'
        let fiveSegmentNumbers = input.filter { $0.count == 5 }
        let three = fiveSegmentNumbers.first { $0.contains(one.first!) && $0.contains(one.last!) }!
        segmentMapping["b"] = Set(eight).subtracting(Set(three)).first { !segmentMapping.values.contains($0) }

        // Determine segment 'g'
        segmentMapping["g"] = Set(eight).subtracting(Set(segmentMapping.values)).first!

        return segmentMapping
    }
}

public enum Day8 {
    public static func puzzle1() -> Int {
        let expressions: [SevenSegmentExpression] = loadInput(forDay: 8)
        return expressions.flatMap(\.output).filter { [2,3,4,7].contains($0.count) }.count
    }
}

public extension Day8 {
    static func puzzle2() -> Int {
        let expressions: [SevenSegmentExpression] = loadInput(forDay: 8)
        return expressions.reduce(0) { $0 + $1.computeCorrectedOutput() }
    }
}
