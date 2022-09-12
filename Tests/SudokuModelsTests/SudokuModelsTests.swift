import XCTest
@testable import SudokuModels

final class SudokuModelsTests: XCTestCase {
    func testScoreModel() throws {
        let now = Date()
        let model = ScoreModel(date: now, seconds: 10, numIncorrect: 1, numRemaining: 2, usedColor: false)
        XCTAssertEqual(model.score, 600)
        let model1 = ScoreModel(date: now, seconds: 10, numIncorrect: 1, numRemaining: 2, usedColor: false)
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: now)!
        let model2 = ScoreModel(date: yesterday, seconds: 20, numIncorrect: 1, numRemaining: 2, usedColor: false)
        XCTAssertTrue(model2 > model1)
        let model3 = ScoreModel(date: yesterday, seconds: 30, numIncorrect: 1, numRemaining: 2, usedColor: false)
        let models = [model1, model2, model3]
        XCTAssertEqual(models.average, 590)
        XCTAssertEqual(models.top(count: 1)[0].score, 600)
    }
}
