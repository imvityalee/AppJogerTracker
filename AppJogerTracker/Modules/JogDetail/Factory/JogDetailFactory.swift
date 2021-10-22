import Foundation

protocol JogsDetailFactoryProtocl {
    func makePresentable(jog: Jog) -> JogsDetailPresentableModel
}

class JogsDetailFactory: JogsDetailFactoryProtocl {
    func makePresentable(jog: Jog) -> JogsDetailPresentableModel {
        return .init(distance: jog.distance, time: jog.time, date: jog.date)
    }
}
