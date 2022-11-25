import Foundation

extension JSONDecoder {
    
    // MARK: - Properties
    static let iso8601SnakeCaseStrategyDecoder = JSONDecoder(
        keyDecodingStrategy: .convertFromSnakeCase,
        dateDecodingStrategy: .iso8601
    )
    
    // MARK: - Initialization
    convenience init(keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy,
                     dateDecodingStrategy: JSONDecoder.DateDecodingStrategy) {
        self.init()
        self.keyDecodingStrategy = keyDecodingStrategy
        self.dateDecodingStrategy = dateDecodingStrategy
    }
}
