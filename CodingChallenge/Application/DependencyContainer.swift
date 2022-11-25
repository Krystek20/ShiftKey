import Foundation

struct DependencyContainer {
    
    // MARK: - Properties
    let repositories: RepositoriesType
    
    // MARK: - Initialization
    init() {
        repositories = Repositories(
            shiftsRepository: ShiftsRepository(
                webservice: Webservice(
                    session: .shared,
                    decoder: .iso8601SnakeCaseStrategyDecoder,
                    urlComponents: .staging
                )
            )
        )
    }
}

private extension URLComponents {
    static var staging: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "staging-app.shiftkey.com"
        return urlComponents
    }
}
