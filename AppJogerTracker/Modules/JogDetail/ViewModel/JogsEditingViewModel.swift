import RxCocoa
import RxFlow
import RxSwift
import Foundation
import Action


class JogsEditingViewModel: JogDetailViewModelImpl {
    override func save() {
        jogProvider?.editJog(jog: initialJog)
            .subscribe(onSuccess: { [weak self] isSucess in
                print(isSucess)
                self?.steps.accept(AppStep.jogs)
            }, onError: { error in
                print(error)
                print(self.initialJog)
            })
            .disposed(by: disposeBag)
    }
}
