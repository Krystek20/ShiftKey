@testable import CodingChallenge
import Foundation

extension DayItem {
    static func fixture(date: String = "2022-11-25", shifts: [ShiftItem] = [.fixture()]) -> DayItem {
        DayItem(
            date: date,
            shifts: shifts
        )
    }
}
