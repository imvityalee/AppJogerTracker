import RxCocoa
import RxFlow
import RxSwift
import Foundation
import Action


class JogsEditingViewModel: JogDetailViewModelImpl {
    override func save() {
        
        initialJog.date = DateAPIFormatter.date(fromShortString: date.value) ?? Date.now
        initialJog.distance = Float(distance.value) ?? initialJog.distance
        initialJog.time = Float(time.value) ?? initialJog.distance
        
        jogProvider?.editJog(jog: initialJog)
            .subscribe(onSuccess: { [weak self] isSucess in
                self?.steps.accept(AppStep.jogs)
            }, onError: { [weak self] error in
                self?.onErrorHandling.accept(error)
            })
            .disposed(by: disposeBag)
    }
    
}
