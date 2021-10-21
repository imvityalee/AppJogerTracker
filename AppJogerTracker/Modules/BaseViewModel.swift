
import Foundation
import RxSwift
import RxFlow
import RxCocoa

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

public class BaseViewModel {}
//    public func openMenu() {
//        print("menu button tapped")
//    }
//
//    public func filterTapped() {
//        print("filter button tapped")
//    }


//extension BaseViewModel:ViewModelType {
//
//    public struct Input {
//        let menuTrigger: Driver<Void>
//        let filterTrigger: Driver<Void>
//    }
//
//    public struct Output {
//        let menuTapped: Driver<Void>
//        let filterTapped: Driver<Void>
//    }
//
//    public func transform(input: Input) -> Output {
//        let menuButton = input.menuTrigger
//            .do(onNext: openMenu)
//            .asDriver(onErrorJustReturn: ())
//
//        let filterButton = input.filterTrigger
//            .do(onNext: filterTapped)
//            .asDriver(onErrorJustReturn: ())
//
//        return Output(menuTapped: menuButton, filterTapped: filterButton)
//    }
//}
