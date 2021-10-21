import Foundation
import Moya

enum AuthEndPoints {
    case login(uuid: String)
}

extension AuthEndPoints: TargetType {
    var baseURL: URL {
        return URLConstants.baseURL
    }
    
    var path: String {
        switch self {
        case .login:
            return "/auth/uuidLogin"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        switch self {
        case .login(let uuid):
            return .requestParameters(parameters: ["uuid": uuid], encoding: JSONEncoding.default)
        }
        
    }
    
    var headers: [String : String]? {
        switch self {
        case .login:
            return ["Content-Type": "application/json"]
        }
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
