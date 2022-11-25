import Foundation

extension ShiftItem {
    init(shiftResponse: ShiftResponse) {
        self.init(
            id: String(shiftResponse.shiftId),
            hoursRange: ShiftHoursFormatter().hours(
                from: shiftResponse.startTime,
                endDate: shiftResponse.endTime
            ),
            distance: String(shiftResponse.withinDistance),
            facilityName: shiftResponse.facilityType.name,
            skillName: shiftResponse.skill.name,
            specialtyName: shiftResponse.localizedSpecialty.name
        )
    }
}
