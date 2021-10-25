
import Foundation

public struct Errors {
    enum NetworkErrorHandler: LocalizedError {
        case unknownError
        case invalidJsonData
        case invalidAuth
        case notConnectedToInternet
        case jogAlreadyExists
        
        public var errorDescription: String? {
            switch self {
            case .unknownError:
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
    
    enum AlertErrors: LocalizedError{
        case titleError
        case authError
        
        public var errorDescription: String? {
            switch self {
            case .titleError:
                return "Error occured"
            case .authError:
                return "Invalid user UUID" 
            }
        }
    }
    
}
