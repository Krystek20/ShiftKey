import Foundation

enum ShiftsAPI {
    case shift(address: String, startDate: String, endDate: String, type: String)
}

extension ShiftsAPI: API {
    
    var path: String {
        switch self {
        case .shift:
            return "/api/v2/available_shifts"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .shift(let address, let startDate, let endDate, let type):
            return [
                URLQueryItem(name: "address", value: address),
                URLQueryItem(name: "start", value: startDate),
                URLQueryItem(name: "end", value: endDate),
                URLQueryItem(name: "type", value: type)
            ]
        }
    }
}
