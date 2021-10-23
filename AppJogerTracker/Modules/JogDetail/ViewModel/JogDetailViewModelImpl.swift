import RxCocoa
import RxFlow
import RxSwift
import Foundation
import Action


class JogDetailViewModelImpl: BaseViewModel, Stepper {
    
    var jogsFactory = JogsDetailFactory.init()
    var steps: PublishRelay<Step> = .init()
    var time: BehaviorRelay<String> = .init(value: "")
    var distance: BehaviorRelay<String> = .init(value: "")
    var date: BehaviorRelay<String> = .init(value: "")
    var onErrorHandling: BehaviorRelay<Error?> = .init(value: nil)
    
    var jogsPresentableModel: BehaviorRelay<JogsDetailPresentableModel> = .init(value: .init())
    
    let disposeBag = DisposeBag()
    
    weak var jogProvider: JogsProviderProtocol?
    var initialJog: Jog
    
    init(jogProvider: JogsProviderProtocol?, jog: Jog) {
        self.initialJog = jog
        self.jogProvider = jogProvider
    }
    
    private lazy var saveAction: CocoaAction = CocoaAction { [unowned self] in
        return .just(save())
    }
    
    func save() {
        fatalError("save method was not implemented correctly")
    }
    
    func menuTapped() {
        steps.accept(AppStep.menu)
    }
    
    func closeTapped() {
        steps.accept(AppStep.close)
    }
    
}

extension JogDetailViewModelImpl: ViewModelType {
    struct Input {
        var menuTrigger: Driver<Void>
        var closeTrigger: Driver<Void>
        var savetrigger: Driver<Void>
        var time: Driver<String>
        var distance: Driver<String>
        var date: Driver<String>
    }
    
    struct Output {
        var menuTapped: Driver<Void>
        var closeTapped: Driver<Void>
        var model: Driver<JogsDetailPresentableModel>
        
    }
    
    func transform(input: Input) -> Output {
        let menuButton = input.menuTrigger
            .do(onNext: menuTapped)
        let closeButton = input.closeTrigger
                .do(onNext:closeTapped )
        let _ = input.savetrigger
                    .drive(saveAction.inputs)
        let _ = input.time.drive(time)
        let _ = input.distance.drive(distance)
        let _ = input.date.drive(date)

     jogsPresentableModel.accept(jogsFactory.makePresentable(jog: initialJog))
                    
                    return Output(menuTapped: menuButton,
                                  closeTapped: closeButton,
                                  model: jogsPresentableModel.asDriver(onErrorJustReturn: .init()))
    }
}


