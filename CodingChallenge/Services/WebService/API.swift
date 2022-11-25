import Foundation

protocol API {
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}
