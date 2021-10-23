import RxSwift
import RxCocoa
import Foundation

protocol JogsProviderProtocol: AnyObject {
    func getJogs() -> Single<[Jog]>
    func createJog(jog: Jog) -> Single<Bool>
    func editJog(jog: Jog) -> Single<Bool>
    func checkIfJogExists(_ jog: Jog) -> Single<Jog>
}

class JogsProvider: JogsProviderProtocol {

    private let network: JogsNetworkManagerProtocol?
    
    init(network: JogsNetworkManagerProtocol?) {
        self.network = network
    }
    
    func checkIfJogExists(_ jog: Jog) -> Single<Jog> {
        return Single.create { [weak self] single in
            guard let network = self?.network else {
                //TO DO: make errors
                single(SingleEvent.error(NetworkErrorHandler.notConnectedToInternet))
                return Disposables.create()
            }
            let disposable = network.checkIfJogExists(jog)
                .map { _ in return jog }
                .subscribe(onSuccess: { data in
                    single(SingleEvent.success(data))
                }, onError: { error in
                    single(SingleEvent.error(error))
                })
            return Disposables.create([disposable])
        }
    }

    func getJogs() -> Single<[Jog]> {
        return Single.create { [weak self] single in
            guard let network = self?.network else {
                //TO DO: make errors
                single(SingleEvent.error(NetworkErrorHandler.notConnectedToInternet))
                return Disposables.create()
            }
            let disposable = network.jogs()
                .subscribe(onSuccess: { data in
                    single(SingleEvent.success(data.response.jogs))
                }, onError: { error in
                    single(SingleEvent.error(error))
                })
            return Disposables.create([disposable])
        }
    }
    
    func createJog(jog: Jog) -> Single<Bool> {
        return Single.create { [weak self] single in
            guard let network = self?.network else {
                //TO DO: make errors
                single(SingleEvent.error(NetworkErrorHandler.notConnectedToInternet))
                return Disposables.create()
            }
            let disposable = network.createJog(jog: jog)
                .subscribe(onSuccess: { data in
                    single(SingleEvent.success(true))
                }, onError: { error in
                    single(SingleEvent.error(error))
                })
            return Disposables.create([disposable])
        }
    }
    
    func editJog(jog: Jog) -> Single<Bool> {
        return Single.create { [weak self] single in
            guard let network = self?.network else {
                //TO DO: make errors
                single(SingleEvent.error(NetworkErrorHandler.invalidAuth))
                return Disposables.create()
            }
            let disposable = network.editJog(jog: jog)
                .subscribe(onSuccess: { data in
                    single(SingleEvent.success(true))
                }, onError: { error in
                    single(SingleEvent.error(error))
                })
            return Disposables.create([disposable])
        }
    }
}
