import Foundation
import RxSwift
import RxCocoa
import Moya

protocol AuthManagerProtocol {
    var authProvider: MoyaProvider<AuthEndPoints> { get }
    var authError: PublishSubject<Errors.NetworkErrorHandler> { get }
    func signIn(by uuid: String) -> Single<LoginResponse>
}

