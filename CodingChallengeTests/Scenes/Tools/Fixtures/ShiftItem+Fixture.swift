@testable import CodingChallenge
import Foundation

extension ShiftItem {
    static func fixture(id: String = UUID().uuidString) -> ShiftItem {
        ShiftItem(
            id: id,
            hoursRange: "example hours range",
            distance: "example distance",
            facilityName: "example facility name",
            skillName: "exampel skill name",
            specialtyName: "example specialty name"
        )
    }
}
