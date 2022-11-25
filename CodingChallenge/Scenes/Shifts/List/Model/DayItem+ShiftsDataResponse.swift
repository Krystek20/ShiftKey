import Foundation

extension [DayItem] {
    init(_ response: ShiftsResponse) {
        self = response.data.map(DayItem.init)
    }
}

extension DayItem {
    init(shiftsDataResponse: ShiftsDataResponse) {
        self.init(
            date: shiftsDataResponse.date,
            shifts: shiftsDataResponse.shifts.map(ShiftItem.init)
        )
    }
}
