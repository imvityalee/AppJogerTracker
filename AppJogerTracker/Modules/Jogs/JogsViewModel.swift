import RxFlow
import Foundation
import RxSwift
import RxCocoa
import Action


class JogsViewModel: BaseViewModel, Stepper {
    
    var steps: PublishRelay<Step> = .init()
    var jogsModel: BehaviorRelay<[JogsSactionModel]> = .init(value: [])
    var onErrorHandling: BehaviorRelay<Error?> = .init(value: nil)
    
    let disposBag = DisposeBag()
    
    weak var jogsProvider: JogsProviderProtocol?
    
    let jogsData = BehaviorRelay<[Jog]>(value: [])
    
    init(jogsProvider: JogsProviderProtocol?) {

        self.jogsProvider = jogsProvider
    }
    
    func onLoadView() {
        jogsProvider?.getJogs()
            .subscribe(onSuccess: { [weak self] jogs in
                self?.jogsData.accept(jogs)
                self?.jogsModel.accept([.init(header: LabelConstants.jogs, items: jogs)])
            }, onError: { [weak self] error in
                self?.onErrorHandling.accept(error)
            }).disposed(by: disposBag)
    }
    
   private func menuTapped() {
        steps.accept(AppStep.menu)
    }
    
   private func addTapped() {
       steps.accept(AppStep.addJog)
    }
    
  private lazy var itemSelectedAction = Action<IndexPath, Void> { [unowned self] indexPath in
        let jog = self.jogsData.value[indexPath.row]
        let step = AppStep.jogsDetail(jog)
        return .just(self.steps.accept(step))
    }
    
}

extension JogsViewModel: ViewModelType {
    
    struct Input {
        var menuTrigger: Driver<Void>
        var addTrigger: Driver<Void>
        var itemSelected: Driver<IndexPath>
    }
    struct Output {
        var sections: Driver<[JogsSactionModel]>
        var menuTapped: Driver<Void>
        var addTapped: Driver<Void>
        
    }
    func transform(input: Input) -> Output {
        onLoadView()
        let menuButton = input.menuTrigger
            .do(onNext: menuTapped)
        let addTapped = input.addTrigger
            .do(onNext: addTapped)
        let _ = input.itemSelected
            .drive(itemSelectedAction.inputs)
                
        return Output(sections: jogsModel.asDriver(),menuTapped: menuButton,addTapped: addTapped)
    }
}
