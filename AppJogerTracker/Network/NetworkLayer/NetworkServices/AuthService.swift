import RxSwift
import RxCocoa
import Foundation

protocol AuthServiceProtocol: AnyObject {
    
    var isAuthenticated: BehaviorRelay<Bool?> { get }

    func signIn(by uuid: String) -> Single<Bool>
    func signOut()
}


public class AuthenticationService: AuthServiceProtocol {
    
    private(set) var isAuthenticated = BehaviorRelay<Bool?>(value: nil)
    
    private let network: AuthManagerProtocol?
    private weak var preferences: AppPreferences?
    private let disposeBag = DisposeBag()
    
    init(authApi: AuthManagerProtocol?, preferences: AppPreferences?) {
        self.network = authApi
        self.preferences = preferences
        isAuthenticated.accept(preferences?.isUserMakeLogin)
    }
    
    func signIn(by uuid: String) -> Single<Bool> {
        return Single.create { [weak self] single in
            guard let network = self?.network else {
                single(SingleEvent.error(NetworkError.invalidAuthentication))
                return Disposables.create()
            }
            
            let disposable = network.signIn(by: uuid)
                .subscribe(onSuccess: { response in
                    self?.preferences?.userToken = response.response.accessToken
                    self?.preferences?.userTokenType = response.response.tokenType
                    self?.isAuthenticated.accept(true)
                    single(SingleEvent.success(true))
                }, onError: { error in
                    single(SingleEvent.error(error))
                })
            return Disposables.create([disposable])
        }
    }
    
    func signOut() {
        preferences?.userToken = nil
        preferences?.userTokenType = nil
        isAuthenticated.accept(false)
    }
    
    
}
