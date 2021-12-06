import Foundation

public enum Day4 {
    struct Bingo {
        let numbers: [[Int]]
        var isDrawn: [[Bool]]

        init?(numbers: [[Int]]) {
            guard !numbers.isEmpty else {
                return nil
            }
            self.numbers = numbers
            self.isDrawn = [[Bool]](repeating: [Bool](repeating: false, count: numbers[0].count), count: numbers.count)
        }

        mutating func draw(number: Int) -> Bool {
            if let rowIndex = numbers.firstIndex(where: { $0.contains(number) }),
               let columnIndex = numbers[rowIndex].firstIndex(of: number) {
                isDrawn[rowIndex][columnIndex] = true
                let isRowComplete = !isDrawn[rowIndex].contains(false)
                let isColumnComplete = !isDrawn.map { $0[columnIndex] }.contains(false)
                return isRowComplete || isColumnComplete
            } else {
                return false
            }
        }

        var sumOfUnmarked: Int {
            zip(numbers.flatMap { $0 }, isDrawn.flatMap { $0 }).reduce(0) { sum, args in
                let (number, isDrawn) = args
                return isDrawn ? sum : sum + number
            }
        }
    }

    public static func puzzle1() -> Int {
        var input: [String] = loadInput(forDay: 4)
        let drawnNumbers = input.removeFirst().components(separatedBy: ",").filter { !$0.isEmpty }.compactMap(Int.init)

        var bingos = makeBingos(from: input)

        for number in drawnNumbers {
            for index in bingos.indices {
                let isCompleted = bingos[index].draw(number: number)
                if isCompleted {
                    return number * bingos[index].sumOfUnmarked
                }
            }
        }

        return 0
    }

    private static func makeBingos(from input: [String]) -> [Bingo] {
        var bingos = [Bingo]()
        var currentBingoNumbers = [[Int]]()
        for line in input {
            guard !line.isEmpty else {
                if let bingo = Bingo(numbers: currentBingoNumbers) {
                    bingos.append(bingo)
                }
                currentBingoNumbers = [[Int]]()
                continue
            }
            let items = line.components(separatedBy: .whitespaces).filter { !$0.isEmpty }.compactMap(Int.init)
            currentBingoNumbers.append(items)
        }
        if let bingo = Bingo(numbers: currentBingoNumbers) {
            bingos.append(bingo)
        }
        return bingos
    }
}

public extension Day4 {
    static func puzzle2() -> Int {
        var input: [String] = loadInput(forDay: 4)
        let drawnNumbers = input.removeFirst().components(separatedBy: ",").filter { !$0.isEmpty }.compactMap(Int.init)

        var bingos = makeBingos(from: input)

        for number in drawnNumbers {
            var finishedIndices = [Int]()
            for index in bingos.indices {
                let isCompleted = bingos[index].draw(number: number)
                if isCompleted {
                    finishedIndices.append(index)
                }
            }
            if bingos.count == finishedIndices.count {
                return number * bingos[0].sumOfUnmarked
            }
            bingos = bingos.enumerated().filter { !finishedIndices.contains($0.offset) }.map(\.element)
        }

        return 0
    }
}
