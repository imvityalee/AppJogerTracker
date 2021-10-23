import RxCocoa
import RxFlow
import RxSwift
import Foundation
import Action



class JogAddingViewModel: JogDetailViewModelImpl {
   override func save() {
       let jog: Jog = prepareNewJog(jog: initialJog)
       
       jogProvider?.checkIfJogExists(jog)
           .subscribe(onSuccess: { [unowned self] jog in
               jogProvider?.createJog(jog: jog)
                   .subscribe(onSuccess: { [weak self] isSuccess in
                       self?.steps.accept(AppStep.jogs)
                   }, onError: { [weak self] error in
                       self?.onErrorHandling.accept(error)
                   }).disposed(by: disposeBag)
           }, onError: { error in
               self.onErrorHandling.accept(error)
           }).disposed(by: disposeBag)

    }
    
    func prepareNewJog(jog: Jog) -> Jog {
        var jog = jog
        jog.id = nil
        jog.userId = nil
        jog.distance = Float(distance.value) ?? 0
        jog.time = Float(time.value) ?? 0
        jog.date = DateAPIFormatter.date(fromShortString: date.value) ?? Date.now
        return jog
    }
}
