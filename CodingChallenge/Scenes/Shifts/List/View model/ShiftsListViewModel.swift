import Combine

protocol ShiftsListViewModelType: ObservableObject {
    var items: [DayItem] { get }
    var isLoading: Bool { get }
    var isManualLoadingButtonVisible: Bool { get }
    var inputs: ShiftsListInputs { get }
    var outputs: ShiftsListOutputs { get }
}

final class ShiftsListViewModel<S: Scheduler>: ShiftsListViewModelType {
    
    // MARK: - Properties
    @Published private(set) var items: [DayItem] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var isManualLoadingButtonVisible: Bool = false
    private(set) lazy var inputs = ShiftsListInputs(subjects: subjects.inputs)
    private(set) lazy var outputs = ShiftsListOutputs(subjects: subjects.outputs)
    private let shiftsRepository: ShiftsRepositoryType
    private let shiftsListDateProvider: ShiftsListDateProviderType
    private let subjects: ShiftsListSubjects
    private let scheduler: S
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    init(shiftsRepository: ShiftsRepositoryType,
         shiftsListDateProvider: ShiftsListDateProviderType,
         subjects: ShiftsListSubjects,
         scheduler: S) {
        self.shiftsRepository = shiftsRepository
        self.shiftsListDateProvider = shiftsListDateProvider
        self.subjects = subjects
        self.scheduler = scheduler
        setupBindings()
    }
    
    // MARK: - Setup
    private func setupBindings() {
        setupInputBindings()
        setupOutputBindings()
    }

    private func setupInputBindings() {
        let loadNextItemsPublisher = subjects
            .inputs
            .shiftAppearedSubject
            .filter { [weak self] item in
                self?.canFetchNextItems(item) == true
            }
            .map { _ in () }

        let fetchShiftsPublisher = Publishers.Merge3(
            loadNextItemsPublisher,
            subjects.inputs.viewAppeardSubject,
            subjects.inputs.loadMorePressedSubject
        )
            .share()
        
        let shiftsPublisher = fetchShiftsPublisher
            .flatMap { [weak self] in
                self?.fetchShifts() ?? Empty().eraseToAnyPublisher()
            }
            .share()
        
        fetchShiftsPublisher
            .map { true }
            .assign(to: &$isLoading)
        
        shiftsPublisher
            .map { [weak self] items in
                self?.getUpdatedItems(newItems: items) ?? []
            }
            .receive(on: scheduler)
            .assign(to: &$items)
        
        shiftsPublisher
            .map { _ in false }
            .receive(on: scheduler)
            .assign(to: &$isLoading)
        
        shiftsPublisher
            .sink(receiveValue: { [weak self] _ in
                self?.shiftsListDateProvider.setFirstDayOfNextWeek()
            })
            .store(in: &cancellables)
        
        Publishers.CombineLatest(shiftsPublisher, $isLoading)
            .map { items, isLoading in
                items.isEmpty && !isLoading
            }
            .receive(on: scheduler)
            .assign(to: &$isManualLoadingButtonVisible)
        
        subjects
            .inputs
            .itemTappedSubject
            .subscribe(AnySubscriber(subjects.outputs.itemTappedSubject))
    }
    
    private func setupOutputBindings() {
        subjects
            .outputs
            .errorSubject
            .map { _ in false }
            .receive(on: scheduler)
            .assign(to: &$isLoading)
    }
    
    // MARK: - Helpers
    private func fetchShifts() -> AnyPublisher<[DayItem], Never> {
        shiftsRepository.shifts(
            address: "Dallas, TX",
            startDate: shiftsListDateProvider.startDate,
            endDate: shiftsListDateProvider.endDate,
            type: "list"
        )
        .catchAndHandleError(subject: subjects.outputs.errorSubject)
    }
    
    private func canFetchNextItems(_ item: ShiftItem) -> Bool {
        !isLoading && items.last?.shifts.last == item
    }
    
    private func getUpdatedItems(newItems: [DayItem]) -> [DayItem] {
        var mutableItems = items
        mutableItems.append(contentsOf: newItems)
        return mutableItems
    }
}
