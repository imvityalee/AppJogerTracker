import RxCocoa
import RxFlow
import RxSwift
import Foundation
import Action

class JogsEditingViewModel: JogDetailViewModelImpl {
    override func save() {
        let jog: Jog = prepareJog(jog: initialJog)
        
        jogProvider?.editJog(jog: jog)
            .subscribe(onSuccess: { [weak self] _ in
                self?.steps.accept(AppStep.jogs)
            }, onError: { [weak self] error in
                self?.onErrorHandling.accept(error)
            })
            .disposed(by: disposeBag)
    }
    
   override func prepareJog(jog: Jog) -> Jog {
        var jog = jog
        jog.distance = Float(distance.value) ?? initialJog.distance
        jog.time = Float(time.value) ?? initialJog.distance
        jog.date =  Date(timeIntervalSinceReferenceDate:
                            DateAPIFormatter.date(fromShortString: date.value)?
                            .timeIntervalSinceReferenceDate ?? Date.now.timeIntervalSinceReferenceDate)
       
        return jog
    }
    
}
