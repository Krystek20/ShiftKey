import Combine

struct ShiftsListSubjects {
    let inputs = ShiftsListInputSubjects()
    let outputs = ShiftsListOutputSubjects()
}

struct ShiftsListInputSubjects {
    let viewAppeardSubject = PassthroughSubject<Void, Never>()
    let itemTappedSubject = PassthroughSubject<ShiftItem, Never>()
    let shiftAppearedSubject = PassthroughSubject<ShiftItem, Never>()
    let loadMorePressedSubject = PassthroughSubject<Void, Never>()
}

struct ShiftsListOutputSubjects {
    let itemTappedSubject = PassthroughSubject<ShiftItem, Never>()
    let errorSubject = PassthroughSubject<Error, Never>()
}
