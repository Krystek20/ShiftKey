@testable import CodingChallenge

final class ShiftsListDateProviderStub: ShiftsListDateProviderType {
    
    // MARK: - Properties
    private(set) var setFirstDayOfNextWeekCounter: Int = .zero
    
    // MARK: - Stub
    var startDate: String {
        "2022-05-12"
    }
    
    var endDate: String {
        "2022-05-16"
    }
    
    func setFirstDayOfNextWeek() {
        setFirstDayOfNextWeekCounter += 1
    }
}
