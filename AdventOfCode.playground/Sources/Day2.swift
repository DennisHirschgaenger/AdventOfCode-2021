import Foundation

public enum Day2 {
    enum Direction: StringConvertible {
        case up(Int)
        case down(Int)
        case forward(Int)

        init(_ string: String) {
            let components = string.components(separatedBy: .whitespaces)
            let value = Int(components[1])!
            switch components[0] {
            case "up":
                self = .up(value)
            case "down":
                self = .down(value)
            case "forward":
                self = .forward(value)
            default:
                fatalError()
            }
        }
    }

    struct Position {
        var horizontal: Int = 0
        var vertical: Int = 0
        var aim: Int = 0
    }

    public static func puzzle1() -> Int {
        let directions: [Direction] = loadInput(forDay: 2)
        var position = Position()
        for direction in directions {
            switch direction {
            case let .up(value):
                position.vertical -= value
            case let .down(value):
                position.vertical += value
            case let .forward(value):
                position.horizontal += value
            }
        }
        return position.horizontal * position.vertical
    }
}

public extension Day2 {
    static func puzzle2() -> Int {
        let directions: [Direction] = loadInput(forDay: 2)
        var position = Position()
        for direction in directions {
            switch direction {
            case let .up(value):
                position.aim -= value
            case let .down(value):
                position.aim += value
            case let .forward(value):
                position.horizontal += value
                position.vertical += position.aim * value
            }
        }
        return position.horizontal * position.vertical
    }
}
