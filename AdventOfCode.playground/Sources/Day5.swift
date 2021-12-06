import Foundation

struct Point: StringConvertible, Equatable, CustomDebugStringConvertible {
    var x: Int
    var y: Int

    var debugDescription: String {
        "(\(x),\(y))"
    }

    init?(_ string: String) {
        let coordinates = string.components(separatedBy: ",").compactMap(Int.init)
        guard coordinates.count == 2 else {
            return nil
        }
        self.x = coordinates[0]
        self.y = coordinates[1]
    }
}

struct Line: StringConvertible, CustomDebugStringConvertible {
    let start: Point
    let end: Point

    var debugDescription: String {
        "\(start) -> \(end)"
    }

    init?(_ string: String) {
        let points = string.components(separatedBy: " -> ").compactMap(Point.init)
        guard points.count == 2 else {
            return nil
        }
        self.start = points[0]
        self.end = points[1]
    }

    var isHorizontal: Bool {
        start.y == end.y
    }

    var isVertical: Bool {
        start.x == end.x
    }
}

public enum Day5 {
    public static func puzzle1() -> Int {
        let lines: [Line] = loadInput(forDay: 5)
        let validLines = lines.filter { $0.isHorizontal || $0.isVertical }

        let (maxX, maxY) = computeBounds(forLines: validLines)
        var field = [[Int]](repeating: [Int](repeating: 0, count: maxX + 1), count: maxY + 1)
        drawLines(validLines, in: &field)

        return field.flatMap { $0 }.filter { $0 > 1 }.count
    }

    private static func computeBounds(forLines lines: [Line]) -> (Int, Int) {
        var maxX = 0
        var maxY = 0
        for line in lines {
            if line.start.x > maxX || line.end.x > maxX {
                maxX = max(line.start.x, line.end.x)
            }
            if line.start.y > maxY || line.end.y > maxY {
                maxY = max(line.start.y, line.end.y)
            }
        }
        return (maxX, maxY)
    }

    private static func drawLines(_ lines: [Line], in field: inout [[Int]]) {
        for line in lines {
            if line.isHorizontal {
                let range = line.start.x < line.end.x ? line.start.x...line.end.x : line.end.x...line.start.x
                range.forEach { x in field[line.start.y][x] += 1 }
            } else if line.isVertical {
                let range = line.start.y < line.end.y ? line.start.y...line.end.y : line.end.y...line.start.y
                range.forEach { y in field[y][line.start.x] += 1 }
            } else {
                var point = line.start
                field[point.y][point.x] += 1
                while point != line.end {
                    if line.end.x > line.start.x {
                        point.x += 1
                    } else {
                        point.x -= 1
                    }
                    if line.end.y > line.start.y {
                        point.y += 1
                    } else {
                        point.y -= 1
                    }
                    field[point.y][point.x] += 1
                }
            }
        }
    }
}

public extension Day5 {
    static func puzzle2() -> Int {
        let lines: [Line] = loadInput(forDay: 5)

        let (maxX, maxY) = computeBounds(forLines: lines)
        var field = [[Int]](repeating: [Int](repeating: 0, count: maxX + 1), count: maxY + 1)
        drawLines(lines, in: &field)

        return field.flatMap { $0 }.filter { $0 > 1 }.count
    }
}
