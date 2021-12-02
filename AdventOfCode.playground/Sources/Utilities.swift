import Foundation

public protocol StringConvertible {
    init?(_ string: String)
}

extension String: StringConvertible {}
extension Int: StringConvertible {}

public func loadInput<T: StringConvertible>(forDay day: Int) -> [T] {
    guard let fileURL = Bundle.main.url(forResource: "input-day\(day)", withExtension: "txt"),
    let input = try? String(contentsOf: fileURL, encoding: .utf8) else {
        fatalError("Failed to load input")
    }
    return input.trimmingCharacters(in: .whitespacesAndNewlines)
        .components(separatedBy: .controlCharacters)
        .compactMap(T.init)
}
