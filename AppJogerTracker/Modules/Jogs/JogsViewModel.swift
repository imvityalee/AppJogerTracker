import RxFlow
import Foundation
import RxSwift
import RxCocoa


class JogsViewModel: BaseViewModel, Stepper {
    
    var steps: PublishRelay<Step> = .init()
    var jogsModel: BehaviorRelay<[JogsSactionModel]> = .init(value: [])
    var onErrorHandling: BehaviorRelay<Error?> = .init(value: nil)
    let disposBag = DisposeBag()
    weak var jogsProvider: JogsProviderProtocol?
    
    init(jogsProvider: JogsProviderProtocol?) {
//        self.jog = jog
        self.jogsProvider = jogsProvider
    }
    
    func onLoadView() {
        jogsProvider?.getJogs()
            .subscribe(onSuccess: { [weak self] jogs in
                self?.jogsModel.accept([.init(header: LabelConstants.jogs, items: jogs)])
            }, onError: { [weak self] error in
                self?.onErrorHandling.accept(error)
                print("Error")
            }).disposed(by: disposBag)
    }
    
    func menuTapped() {
        steps.accept(AppStep.menu)
    }
    func addTapped() {
//        steps.accept(AppStep.jogsDetail)
    }
    
//    func itemSelected(_ indexPath: IndexPath)  {
//        let jog =  self.jog[indexPath.row]
//        let step = AppStep.jogsDetail(jog)
//        return steps.accept(step)
//    }
    
}

extension JogsViewModel: ViewModelType {
    
    struct Input {
        var menuTrigger: Driver<Void>
        var addTrigger: Driver<Void>
//        var itemSelected: Driver<IndexPath>
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
//         let itemSelected = input.itemSelected
//                .do(onNext: itemSelected(_:))
        
        return Output(sections: jogsModel.asDriver(),menuTapped: menuButton,addTapped: addTapped)
    }
}
