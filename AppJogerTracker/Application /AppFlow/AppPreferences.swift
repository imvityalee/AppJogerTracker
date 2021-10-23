import Foundation
import KeychainAccess

final class AppPreferences {
    
    private let keyChain = Keychain.init(service: "com.AppJoggerTracker.token")
    
    var userToken: String? {
        get {
            return try! keyChain.get(Constants.userTokenKey)
        }
        set {
            return try! keyChain.set(newValue!, key: Constants.userTokenKey)
        }
    }
    
    var userTokenType: String? {
        get {
            return try! keyChain.get(Constants.userTokenTypeKey)
        }
        set {
            return try! keyChain.set(newValue!, key: Constants.userTokenTypeKey)
        }
    }
    
    var isUserMakeLogin: Bool {
        userToken != nil
    }
}
