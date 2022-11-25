import Combine

extension Publisher where Failure == Error {
    func catchAndHandleError(subject: PassthroughSubject<Error, Never>) -> AnyPublisher<Output, Never> {
        `catch` { error -> AnyPublisher<Output, Never> in
            subject.send(error)
            return Empty(completeImmediately: false)
                .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
}
