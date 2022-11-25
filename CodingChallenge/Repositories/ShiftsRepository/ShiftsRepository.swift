import Combine
import Foundation

protocol ShiftsRepositoryType {
    func shifts(address: String, startDate: String, endDate: String, type: String) -> AnyPublisher<[DayItem], Error>
}

struct ShiftsRepository: ShiftsRepositoryType {
    
    // MARK: - Properties
    private let webservice: WebserviceType
    
    // MARK: - Initialization
    init(webservice: WebserviceType) {
        self.webservice = webservice
    }
    
    // MARK: - Repository
    func shifts(address: String, startDate: String, endDate: String, type: String) -> AnyPublisher<[DayItem], Error> {
        webservice
            .call(
                api: ShiftsAPI.shift(
                    address: address,
                    startDate: startDate,
                    endDate: endDate,
                    type: type
                )
            )
            .map([DayItem].init)
            .eraseToAnyPublisher()
    }
}
