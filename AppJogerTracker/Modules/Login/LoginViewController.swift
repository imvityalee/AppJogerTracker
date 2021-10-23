import Foundation
import RxSwift
import RxCocoa

class LoginViewController: BaseViewController<LoginView,LoginViewModel>  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.filterButton.isHidden = true
        bind(output: viewModel.transform(input: inputs))
         
      
    }
       private var inputs: LoginViewModel.Input {
           return LoginViewModel.Input(menuTrigger: contentView.menuButton.rx.tap.asDriver(),
                                       requisite: contentView.loginTextfield.rx.text.orEmpty.asDriver(),
                                       nextTrigger: contentView.loginButton.rx.tap.asDriver())
       }
       private func bind(output: LoginViewModel.Output) {

          disposableBag.insert([
            output.nextTapped.drive(),
            output.menuTapped.drive(),
            
            viewModel.onErrorHandling
                .skip(1)
                .subscribe { [weak self] error in
                    self?.showAlert(title: LabelConstants.alertAuthError,
                                 message: LabelConstants.tryAgain)
            }
          ])
       }
       
}


