
import Foundation
import RxSwift
import RxFlow
import RxCocoa

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

public class BaseViewModel {
    let disposeBag = DisposeBag()
}
