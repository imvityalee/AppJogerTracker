import RxFlow
import RxCocoa
import RxSwift

import Foundation

class JogInfoViewModel: BaseViewModel, Stepper {
    var steps: PublishRelay<Step> = .init()
    
    private func openMenu() {
        steps.accept(AppStep.menu)
    }
}

extension JogInfoViewModel: ViewModelType {
    
    struct Input {
        let menuTrigger: Driver<Void>
    }
    
    struct Output {
        let menuTapped: Driver<Void>
    }
    func transform(input: Input) -> Output {
        let menuButton = input.menuTrigger
            .do(onNext: openMenu)
        return Output(menuTapped: menuButton)
    }
}
