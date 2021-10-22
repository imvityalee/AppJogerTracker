import RxSwift
import RxCocoa
import Foundation

class JogInfoViewController: BaseViewController<JogInfoView, JogInfoViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.filterButton.isHidden = true
        bind(output: viewModel.transform(input: inputs))
    }
    
       private var inputs: JogInfoViewModel.Input {
          return JogInfoViewModel.Input(menuTrigger: contentView.menuButton.rx.tap.asDriver())
       }
       private func bind(output: JogInfoViewModel.Output) {
          disposableBag.insert([
             output.menuTapped.drive()
          ])
       }

    
}
