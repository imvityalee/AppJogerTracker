import RxSwift
import RxFlow
import Foundation
import RxCocoa


class MenuViewModel: ViewModelType, Stepper {
    var steps: PublishRelay<Step> = .init()
    
    func infoTapped() {
        steps.accept(AppStep.info)
    }
    
    func jogsTapped() {
        steps.accept(AppStep.jogs)
    }
    
    func closeTapped() {
        steps.accept(AppStep.close)
    }
    
}

extension MenuViewModel {
    struct Input {
        let infoTrigger: Driver<Void>
        let jogsTrigger: Driver<Void>
        let closeTrigger: Driver<Void>
    }
    
    struct Output {
        let infoTapped: Driver<Void>
        let jogsTapped: Driver<Void>
        let closeTapped: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        let infoButton = input.infoTrigger
            .do(onNext: infoTapped)
            .asDriver(onErrorJustReturn: ())
        
        let jogsButton = input.jogsTrigger
                .do(onNext: jogsTapped)
                .asDriver(onErrorJustReturn: ())
        let closeButton = input.closeTrigger
                 .do(onNext: closeTapped)
                 .asDriver()
                     
       return Output(infoTapped: infoButton,
                     jogsTapped: jogsButton,
                     closeTapped: closeButton)
  }
}
