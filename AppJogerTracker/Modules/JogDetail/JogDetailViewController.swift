import Foundation
import RxSwift
import RxCocoa

class JogDetailViewController: BaseViewController<JogDetailView, JogDetailViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conentView.filterButton.isHidden = true
        bind(output: viewModel.transform(input: inputs))
    }
    
    
    public var inputs: JogDetailViewModel.Input {
        return JogDetailViewModel.Input(menuTrigger: conentView.menuButton.rx.tap.asDriver(),
                                        closeTrigger: conentView.closeButton.rx.tap.asDriver())
    }
    public func bind(output: JogDetailViewModel.Output) {
       disposableBag.insert([
          output.menuTapped.drive(),
          output.closeTapped.drive()
       ])
    }
    
}
