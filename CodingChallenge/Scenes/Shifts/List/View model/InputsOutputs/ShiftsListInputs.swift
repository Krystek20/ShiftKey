import Combine

struct ShiftsListInputs {
    
    // MARK: - Inputs
    func viewAppeard() {
        viewAppeardSubject.send()
    }
    private let viewAppeardSubject: PassthroughSubject<Void, Never>
    
    func itemTapped(_ item: ShiftItem) {
        itemTappedSubject.send(item)
    }
    private let itemTappedSubject: PassthroughSubject<ShiftItem, Never>
    
    func shiftAppeared(_ item: ShiftItem) {
        shiftAppearedSubject.send(item)
    }
    private let shiftAppearedSubject: PassthroughSubject<ShiftItem, Never>
    
    func loadMorePressed() {
        loadMorePressedSubject.send()
    }
    private let loadMorePressedSubject: PassthroughSubject<Void, Never>
    
    // MARK: - Initialization
    init(subjects: ShiftsListInputSubjects) {
        viewAppeardSubject = subjects.viewAppeardSubject
        itemTappedSubject = subjects.itemTappedSubject
        shiftAppearedSubject = subjects.shiftAppearedSubject
        loadMorePressedSubject = subjects.loadMorePressedSubject
    }
}
