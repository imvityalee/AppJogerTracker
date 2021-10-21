import Foundation
import RxSwift
import RxCocoa
import Moya

protocol AuthManagerProtocol {
    var authProvider: MoyaProvider<AuthEndPoints> { get }
    var authError: PublishSubject<NetworkError> { get }
    func signIn(by uuid: String) -> Single<LoginResponse>
}

