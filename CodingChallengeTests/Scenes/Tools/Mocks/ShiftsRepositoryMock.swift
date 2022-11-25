@testable import CodingChallenge
import Combine

final class ShiftsRepositoryMock: ShiftsRepositoryType {
    
    // MARK: - Properties
    private(set) var shiftsCounter: Int = .zero
    private(set) var addressSet: String?
    private(set) var startDateSet: String?
    private(set) var endDateSet: String?
    private(set) var typeSet: String?
    private let shiftsSubject = PassthroughSubject<[DayItem], Error>()
    
    func shifts(address: String, startDate: String, endDate: String, type: String) -> AnyPublisher<[DayItem], Error> {
        shiftsCounter += 1
        addressSet = address
        startDateSet = startDate
        endDateSet = endDate
        typeSet = type
        return shiftsSubject.eraseToAnyPublisher()
    }
    
    // MARK: - Helpers
    func callShifts(_ items: [DayItem]) {
        shiftsSubject.send(items)
        shiftsSubject.send(completion: .finished)
    }
    
    func callShifts(with error: Error) {
        shiftsSubject.send(completion: .failure(error))
    }
}
