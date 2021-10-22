import RxCocoa
import RxFlow
import RxSwift
import Foundation
import Action

class JogAddingViewModel: JogDetailViewModelImpl {
   override func save() {
       let jog = Jog(id: nil,
                     userId: nil,
                     distance: Float(distance.value) ?? .zero,
                     time: Float(time.value) ?? .zero,
                     date: date.value)
       jogProvider?.checkIfJogExists(jog)
           .subscribe(onSuccess: { [unowned self] jog in
               jogProvider?.createJog(jog: jog)
                   .subscribe(onSuccess: { [weak self] isSuccess in
                       print(isSuccess)
                       print(jog)
                       print(date.value)
                       print(jog.distance)
                       self?.steps.accept(AppStep.jogs)
                   }, onError: { [weak self] error in
                       print(error)
                   }).disposed(by: disposeBag)
           }, onError: { error in
               print(error)
           }).disposed(by: disposeBag)

    }
}
