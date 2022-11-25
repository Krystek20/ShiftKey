import Combine
import Foundation

protocol WebserviceType {
    func call<T: Decodable>(api: API) -> AnyPublisher<T, Error>
}

struct Webservice: WebserviceType {
    
    // MARK: - Properties
    private let urlComponents: URLComponents
    private let session: URLSession
    private let decoder: JSONDecoder
    
    // MARK: - Initialization
    init(session: URLSession, decoder: JSONDecoder, urlComponents: URLComponents) {
        self.session = session
        self.decoder = decoder
        self.urlComponents = urlComponents
    }
    
    // MARK: - WebserviceType
    func call<T: Decodable>(api: API) -> AnyPublisher<T, Error> {
        var mutableURLComponents = urlComponents
        mutableURLComponents.path = api.path
        mutableURLComponents.queryItems = api.queryItems
        guard let url = mutableURLComponents.url else {
            return Fail(error: APIError.invalidURL(mutableURLComponents.string))
                .eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
