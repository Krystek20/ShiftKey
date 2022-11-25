import Combine

final class SpyValue<T> {
    
    // MARK: - Properties
    private(set) var values = [T]()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    init(_ publisher: Published<T>.Publisher) {
        publisher
            .sink(receiveValue: { [weak self] value in
                self?.values.append(value)
            })
            .store(in: &cancellables)
    }
    
    init(_ publisher: AnyPublisher<T, Never>) {
        publisher
            .sink(receiveValue: { [weak self] value in
                self?.values.append(value)
            })
            .store(in: &cancellables)
    }
}
