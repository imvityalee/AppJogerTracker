import Foundation
import RxFlow
import RxSwift
import RxCocoa

class LoginViewModel: Stepper {
    
    var steps = PublishRelay<Step>.init()
    var uuid: BehaviorRelay<String> = .init(value: "")
    var onErrorHandling: BehaviorRelay<Error?> = .init(value: nil)
    
    weak var service: AuthServiceProtocol?
    
    let disposBag = DisposeBag()
  
    init(service: AuthServiceProtocol?) {
        self.service = service
    }
    
    var initialStep: Step {
        AppStep.login
    }
    
     func openMenu() {
        steps.accept(AppStep.menu)
    }
    
    func logIn() {
        guard !uuid.value.isEmpty else { return }
        service?.signIn(by: uuid.value)
            .subscribe { [weak self] _ in
                self?.steps.accept(AppStep.jogs)
            } onError: { [weak self] error in
                self?.onErrorHandling.accept(error)
            }.disposed(by: disposBag)

    }
}

extension LoginViewModel: ViewModelType {

    
    struct Input {
        let menuTrigger: Driver<Void>
        let requisite: Driver<String>
        let nextTrigger: Driver<Void>
    }
    
    struct Output {
        let menuTapped: Driver<Void>
        let nextTapped: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        let menuButton = input.menuTrigger.map(openMenu)
        let nextTrigger = input.nextTrigger.do(onNext: logIn)
        let requisite = input.requisite.drive(uuid)
        return Output(menuTapped: menuButton, nextTapped: nextTrigger)
    }
}
