import Foundation

struct ShiftsResponse: Decodable {
    let data: [ShiftsDataResponse]
}

struct ShiftsDataResponse: Decodable {
    let date: String
    let shifts: [ShiftResponse]
}

struct ShiftResponse: Decodable {
    let shiftId: Int
    let startTime: Date
    let endTime: Date
    let withinDistance: Int
    let facilityType: FacilityTypeResponse
    let skill: SkillResponse
    let localizedSpecialty: LocalizedSpecialtyResponse
}

struct FacilityTypeResponse: Decodable {
    let name: String
}

struct SkillResponse: Decodable {
    let name: String
}

struct LocalizedSpecialtyResponse: Decodable {
    let name: String
}
