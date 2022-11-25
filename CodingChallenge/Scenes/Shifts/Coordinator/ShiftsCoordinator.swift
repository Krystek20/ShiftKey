import Foundation
import Combine

protocol ShiftsCoordinatorType: ObservableObject {
    associatedtype ViewModel: ShiftsListViewModelType
    associatedtype DetailsViewModel: ShiftDetailsViewModelType
    var viewModel: ViewModel { get }
    var detailsViewModel: DetailsViewModel? { get set }
}

final class ShiftsCoordinator<S: Scheduler>: ShiftsCoordinatorType {
    
    // MARK: - Typealiases
    typealias ViewModel = ShiftsListViewModel<S>
    typealias DetailsViewModel = ShiftDetailsViewModel
    
    // MARK: - Properties
    @Published var detailsViewModel: DetailsViewModel?
    @Published private(set) var viewModel: ViewModel
    private var cancellables = Set<AnyCancellable>()
    private let dependencyContainer: DependencyContainer
    private let subjects: ShiftCoordinatorSubjects
    private let scheduler: S

    // MARK: - Initialization
    init(dependencyContainer: DependencyContainer,
         subjects: ShiftCoordinatorSubjects,
         scheduler: S) {
        self.dependencyContainer = dependencyContainer
        self.subjects = subjects
        self.scheduler = scheduler
        self.viewModel = ShiftsListViewModel(
            shiftsRepository: dependencyContainer.repositories.shiftsRepository,
            shiftsListDateProvider: ShiftsListDateProvider(),
            subjects: subjects.listSubjects,
            scheduler: scheduler
        )
        setupBindings()
    }
    
    // MARK: - Setup
    private func setupBindings() {
        viewModel
            .outputs
            .itemTappedPublisher
            .sink(receiveValue: { [weak self] shiftItem in
                self?.setupDetailsViewModel(shiftItem: shiftItem)
            })
            .store(in: &cancellables)
    }
    
    // MARK: - Helpers
    private func setupDetailsViewModel(shiftItem: ShiftItem) {
        detailsViewModel = ShiftDetailsViewModel(
            shiftItem: shiftItem
        )
    }
}
