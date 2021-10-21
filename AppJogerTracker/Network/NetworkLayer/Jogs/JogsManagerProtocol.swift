import Foundation
import RxSwift
import RxCocoa
import Moya

protocol JogsNetworkManagerProtocol {
    func jogs() -> Single<GetJogsResponse>
    func createJog(jog: Jog) -> Single<CreateJogResponse>
    func editJog(jog: Jog) -> Single<EditJogResponse>
}

extension NetworkLayer: JogsNetworkManagerProtocol {

    func jogs() -> Single<GetJogsResponse> {
        return sendRequest(provider: jogsProvider, target: JogsEndPoints.jogs(token: preferences?.userToken ?? ""))
    }
    
    func createJog(jog: Jog) -> Single<CreateJogResponse> {
        return sendRequest(provider: jogsProvider, target: JogsEndPoints.createJog(jog: jog, token: preferences?.userToken ?? ""))
    }
    
    func editJog(jog: Jog) -> Single<CreateJogResponse> {
        return sendRequest(provider: jogsProvider, target: JogsEndPoints.editJog(jog: jog, token: preferences?.userToken ?? ""))
    }
}
