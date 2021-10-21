import Foundation
import RxSwift
import RxCocoa

class LoginViewController: BaseViewController<LoginView,LoginViewModel>  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conentView.filterButton.isHidden = true
        bind(output: viewModel.transform(input: inputs))
         
      
    }
       private var inputs: LoginViewModel.Input {
           return LoginViewModel.Input(menuTrigger: conentView.menuButton.rx.tap.asDriver(),
                                       requisite: conentView.loginTextfield.rx.text.orEmpty.asDriver(),
                                       nextTrigger: conentView.loginButton.rx.tap.asDriver())
       }
       private func bind(output: LoginViewModel.Output) {

          disposableBag.insert([
            output.nextTapped.drive(),
            output.menuTapped.drive(),
            
            viewModel.onErrorHandling
                .skip(1)
                .subscribe { [weak self] error in
                 self?.showAlert(title: "\(NetworkError.invalidAuthentication)",
                                 message: LabelConstants.tryAgain)
            }
          ])
       }
       
}


