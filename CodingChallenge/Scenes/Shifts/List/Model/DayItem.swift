import Foundation

struct DayItem: Identifiable, Equatable {
    var id: String { date }
    let date: String
    let shifts: [ShiftItem]
}
