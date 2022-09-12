import Foundation

public struct ScoreModel: Codable, Comparable {
    public let date: Date
    public let seconds: Int
    public let numIncorrect: Int
    public let numRemaining: Int
    public let usedColor: Bool
    public var score: Int {
        max(0, 60 * 10 - seconds) -
        numIncorrect * 10 +
        numRemaining * 10
    }

    public static func < (lhs: ScoreModel, rhs: ScoreModel) -> Bool {
        lhs.score > rhs.score
    }
}

public extension Array where Element == ScoreModel {
    var average: Double {
        guard count > 0 else { return 0 }
        return self.map { Double($0.score) }.reduce(0, +) / Double(count)
    }

    func top(count: Int) -> [ScoreModel] {
        Array(self.sorted().prefix(count))
    }

    func recent(count: Int) -> [ScoreModel] {
        Array(self.sorted(by: { lhs, rhs in lhs.date > rhs.date }).prefix(count))
    }

    var mostRecent: ScoreModel? {
        Array(self.sorted(by: { lhs, rhs in lhs.date > rhs.date })).first
    }
}
