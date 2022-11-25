import Combine

struct ShiftsListOutputs {
    
    // MARK: - Outputs
    let itemTappedPublisher: AnyPublisher<ShiftItem, Never>
    let errorPublisher: AnyPublisher<Error, Never>
    
    // MARK: - Initialization
    init(subjects: ShiftsListOutputSubjects) {
        itemTappedPublisher = subjects.itemTappedSubject.eraseToAnyPublisher()
        errorPublisher = subjects.errorSubject.eraseToAnyPublisher()
    }
}
