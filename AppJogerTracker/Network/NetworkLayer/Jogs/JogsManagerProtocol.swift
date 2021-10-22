import Foundation
import RxSwift
import RxCocoa
import Moya

protocol JogsNetworkManagerProtocol {
    func jogs() -> Single<GetJogsResponse>
    func createJog(jog: Jog) -> Single<CreateJogResponse>
    func editJog(jog: Jog) -> Single<EditJogResponse>
    func checkIfJogExists(_ jog: Jog) -> Single<Void>
}

extension NetworkLayer: JogsNetworkManagerProtocol {
    
    func checkIfJogExists(_ jog: Jog) -> Single<Void> {
        return jogs()
            .map { getJogs in
                if getJogs.response.jogs.contains(where: {
                    $0.id == jog.id
                    && $0.userId == jog.userId
                    && $0.distance == jog.distance
                    && $0.date == jog.date
                    && $0.time == jog.time
                }) {
                    throw NetworkError.jogAlreadyExists
                }
            }
            
    }
    func jogs() -> Single<GetJogsResponse> {
        return sendRequest(provider: jogsProvider,
                           target: JogsEndPoints.jogs(token: preferences?.userToken ?? ""))
    }
    
    func createJog(jog: Jog) -> Single<CreateJogResponse> {
        return sendRequest(provider: jogsProvider,
                           target: JogsEndPoints.createJog(jog: jog, token: preferences?.userToken ?? ""))
    }
    
    func editJog(jog: Jog) -> Single<CreateJogResponse> {
        return sendRequest(provider: jogsProvider,
                           target: JogsEndPoints.editJog(jog: jog, token: preferences?.userToken ?? ""))
    }
}
