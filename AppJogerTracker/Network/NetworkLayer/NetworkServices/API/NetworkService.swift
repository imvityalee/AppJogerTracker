import RxSwift
import RxCocoa
import Moya
import Dispatch

class NetworkLayer {
    private(set) var authProvider: MoyaProvider<AuthEndPoints>
    private(set) var jogsProvider: MoyaProvider<JogsEndPoints>
    var authError = PublishSubject<Errors.NetworkErrorHandler>()
    weak var preferences: AppPreferences?
    
    init(preferences: AppPreferences?) {
        self.preferences = preferences
        authProvider = MoyaProvider<AuthEndPoints>(plugins: [])
        jogsProvider = MoyaProvider<JogsEndPoints>(plugins: [])
    }
    
    func sendRequest<T: Decodable, U: TargetType>(provider: MoyaProvider<U>, target: U) -> Single<T> {
        return provider.rx
            .request(target)
            .map(T.self)
            .catchError { [weak self] error in
                guard let error = error as? MoyaError else {
                    throw Errors.NetworkErrorHandler.unknownError
                }
                guard let self = self else { return  Single.error(error)}
                
                return try self.handleError(error: error)
        }
    }
    
    private func handleError<T: Decodable>(error: MoyaError) throws ->  PrimitiveSequence<SingleTrait, T>  {
        switch error {
        case .jsonMapping, .objectMapping:
            throw Errors.NetworkErrorHandler.invalidJsonData
        case .statusCode(_):
            authError.onNext(.invalidAuth)
            throw Errors.NetworkErrorHandler.invalidAuth
        case .underlying(let error, _):
            authError.onNext(.invalidAuth)
            let code = (error as NSError).code
            switch URLError.Code(rawValue: code) {
            case .notConnectedToInternet:
                throw Errors.NetworkErrorHandler.notConnectedToInternet
            default: break
            }
            throw Errors.NetworkErrorHandler.unknownError
        default:
            throw Errors.NetworkErrorHandler.invalidJsonData
        }
    }
}

extension NetworkLayer: AuthManagerProtocol {
    func signIn(by uuid: String) -> Single<LoginResponse> {
        return sendRequest(provider: authProvider, target: AuthEndPoints.login(uuid: uuid))
    }
}
