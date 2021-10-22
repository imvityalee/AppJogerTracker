import Foundation
import RxSwift
import RxCocoa

class JogDetailViewController: BaseViewController<JogDetailView, JogDetailViewModelImpl> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.filterButton.isHidden = true
        bind(output: viewModel.transform(input: inputs))
    }
    
    
    public var inputs: JogDetailViewModelImpl.Input {
        return JogDetailViewModelImpl.Input(menuTrigger: contentView.menuButton.rx.tap.asDriver(),
                                            closeTrigger: contentView.closeButton.rx.tap.asDriver(),
                                            savetrigger: contentView.saveButton.rx.tap.asDriver(),time: contentView.timeTextFiled.rx.text.orEmpty.asDriver(),distance: contentView.distanceTexfield.rx.text.orEmpty.asDriver(), date: contentView.datePicker.rx.value.asDriver())
    }
    public func bind(output: JogDetailViewModelImpl.Output) {
       disposableBag.insert([
          output.menuTapped.drive(),
          output.closeTapped.drive(),
          output.model.drive(onNext: contentView.configure(model:))
       ])
    }
    
}
