import Combine

protocol ShiftDetailsViewModelType: ObservableObject, Identifiable {
    var shiftItem: ShiftItem { get }
}

final class ShiftDetailsViewModel: ShiftDetailsViewModelType {
    
    // MARK: - Properties
    @Published var shiftItem: ShiftItem
    
    // MARK: - Initialization
    init(shiftItem: ShiftItem) {
        self.shiftItem = shiftItem
    }
}
