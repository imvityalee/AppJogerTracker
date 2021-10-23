
import Foundation

enum NetworkErrorHandler: LocalizedError {
    case unknown
    case invalidJsonData
    case invalidAuth
    case notConnectedToInternet
    case jogAlreadyExists
    
    public var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unexpected error happened"
        case .invalidJsonData:
            return "JSON model could not be recognized"
        case .invalidAuth:
            return "Provided invalid credentials"
        case .notConnectedToInternet:
            return "No Internet connection"
        case .jogAlreadyExists:
            return "Jog already Exists"
        }
    }
}
