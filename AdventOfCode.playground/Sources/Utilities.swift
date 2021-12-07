import Foundation

public protocol StringConvertible {
    init?(_ string: String)
}

extension String: StringConvertible {}
extension Int: StringConvertible {}

private func loadInputFile(forDay day: Int) -> String {
    guard let fileURL = Bundle.main.url(forResource: "input-day\(day)", withExtension: "txt"),
    let inputFile = try? String(contentsOf: fileURL, encoding: .utf8) else {
        fatalError("Failed to load input")
    }
    return inputFile
}

public func loadInput<T: StringConvertible>(forDay day: Int) -> [T] {
    let input = loadInputFile(forDay: day)
    return input.trimmingCharacters(in: .whitespacesAndNewlines)
        .components(separatedBy: .controlCharacters)
        .compactMap(T.init)
}

public func loadCommaSeparatedInput<T: StringConvertible>(forDay day: Int) -> [T] {
    let input = loadInputFile(forDay: day)
    return input.trimmingCharacters(in: .whitespacesAndNewlines)
        .components(separatedBy: ",")
        .compactMap(T.init)
}
