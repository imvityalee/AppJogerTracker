import RxCocoa
import RxFlow
import RxSwift
import Foundation

class JogDetailViewModel: BaseViewModel, Stepper {
    var steps: PublishRelay<Step> = .init()
    var time: BehaviorRelay<String> = .init(value: "")
    var distance: BehaviorRelay<String> = .init(value: "")
    var date: BehaviorRelay<Date> = .init(value: Date())
    
    func menuTapped() {
        steps.accept(AppStep.menu)
    }
    
    func closeTapped() {
        steps.accept(AppStep.close)
    }
    
}

extension JogDetailViewModel: ViewModelType {
    struct Input {
        var menuTrigger: Driver<Void>
        var closeTrigger: Driver<Void>
    }
    
    struct Output {
        var menuTapped: Driver<Void>
        var closeTapped: Driver<Void>
        
    }
    
    func transform(input: Input) -> Output {
        let menuButton = input.menuTrigger
            .do(onNext: menuTapped)
        let closeButton = input.closeTrigger
                .do(onNext:closeTapped )
        return Output(menuTapped: menuButton, closeTapped: closeButton)
    }
}
