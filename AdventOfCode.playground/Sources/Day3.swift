import Foundation

public enum Day3 {
    public static func puzzle1() -> Int {
        let diagnosticReport: [String] = loadInput(forDay: 3)
        var gammaRate = ""
        var epsilonRate = ""
        for index in diagnosticReport[0].indices {
            let count = diagnosticReport.map { $0[index] }.filter { $0 == "1" }.count
            gammaRate += count > diagnosticReport.count / 2 ? "1" : "0"
            epsilonRate += count > diagnosticReport.count / 2 ? "0" : "1"
        }
        return Int(gammaRate, radix: 2)! * Int(epsilonRate, radix: 2)!
    }
}

public extension Day3 {
    static func puzzle2() -> Int {
        let diagnosticReport: [String] = loadInput(forDay: 3)

        let oxygenGeneratorRating = computeOxygenGeneratorRating(from: diagnosticReport)
        let co2ScrubberRating = computeCO2ScrubberRating(from: diagnosticReport)
        return oxygenGeneratorRating * co2ScrubberRating
    }

    private static func computeOxygenGeneratorRating(from diagnosticReport: [String]) -> Int {
        var possibleOxygenGeneratorRatings = diagnosticReport
        for index in diagnosticReport[0].indices {
            let oxygenGeneratorRatingsContainingOne = possibleOxygenGeneratorRatings.filter { $0[index] == "1" }
            if Double(oxygenGeneratorRatingsContainingOne.count) >= Double(possibleOxygenGeneratorRatings.count) / 2 {
                possibleOxygenGeneratorRatings = oxygenGeneratorRatingsContainingOne
            } else {
                possibleOxygenGeneratorRatings = possibleOxygenGeneratorRatings.filter { $0[index] == "0" }
            }

            if possibleOxygenGeneratorRatings.count == 1 {
                break
            }
        }
        return Int(possibleOxygenGeneratorRatings[0], radix: 2)!
    }

    private static func computeCO2ScrubberRating(from diagnosticReport: [String]) -> Int {
        var possibleCO2ScrubberRatings = diagnosticReport
        for index in diagnosticReport[0].indices {
            let co2ScrubberRatingsContainingZero = possibleCO2ScrubberRatings.filter { $0[index] == "0" }
            if Double(co2ScrubberRatingsContainingZero.count) <= Double(possibleCO2ScrubberRatings.count) / 2 {
                possibleCO2ScrubberRatings = co2ScrubberRatingsContainingZero
            } else {
                possibleCO2ScrubberRatings = possibleCO2ScrubberRatings.filter { $0[index] == "1" }
            }

            if possibleCO2ScrubberRatings.count == 1 {
                break
            }
        }
        return Int(possibleCO2ScrubberRatings[0], radix: 2)!
    }
}
