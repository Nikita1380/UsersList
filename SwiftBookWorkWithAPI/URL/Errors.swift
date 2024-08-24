import UIKit

enum NetworkErrors: Error {
    case decodingError
    case noData
    case noUsers
    
    var title: String {
        switch self {
            
        case .decodingError:
            return "Can't decode received data"
        case .noData:
            return "can't fetch data at all"
        case .noUsers:
            return "No users got from API"
        }
    }
}
