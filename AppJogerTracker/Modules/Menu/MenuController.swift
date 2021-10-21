import Foundation
import UIKit
import RxCocoa
import RxSwift

class MenuController<View: MenuView, ViewModel: MenuViewModel>: UIViewController {
    
    lazy var conentView = view as! View
    lazy var disposableBag: DisposeBag! = .init()
    var viewModel: ViewModel
    
    override func loadView() {
        view = View()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(output: viewModel.transform(input: inputs))
    }
     required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    private var inputs: MenuViewModel.Input {
        return MenuViewModel.Input(infoTrigger: conentView.infoButton.rx.tap.asDriver(),
                                   jogsTrigger: conentView.jogsButton.rx.tap.asDriver(),
                                   closeTrigger: conentView.closeButton.rx.tap.asDriver())
    }
    
    public func bind(output: MenuViewModel.Output) {
       disposableBag.insert([
        output.infoTapped.drive(),
        output.closeTapped.drive(),
        output.jogsTapped.drive()
       ])
    }
    
}
