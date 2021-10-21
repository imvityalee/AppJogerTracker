import Foundation
import SnapKit

class LoginView: BaseView {
    
    var loginTextfield: UITextField!
    var loginButton: UIButton!
    
    override func setUpView() {
        super.setUpView()
        configureLoginButton()
        configureLoginTextfield()
        
    }
    override func setUpConstraints() {
        super.setUpConstraints()
        
        loginTextfield.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(30)

        }
        loginButton.snp.makeConstraints {
            $0.top.equalTo(loginTextfield.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(150)
            $0.height.equalTo(60)
        }
    }
    
    private func configureLoginTextfield() {
        loginTextfield = UITextField.init()
        loginTextfield.placeholder = LabelConstants.uuid
        loginTextfield.layer.borderColor = UIColor.systemPurple.cgColor
        loginTextfield.layer.borderWidth = 2.5
        loginTextfield.borderStyle = .roundedRect
        loginTextfield.layer.cornerRadius = 5
        loginTextfield.textAlignment = .center
        self.addSubview(loginTextfield)
        
    }
    
    private func configureLoginButton() {
        loginButton = UIButton.init(type: .system)
        loginButton.setTitle(LabelConstants.login, for: .normal)
        loginButton.setTitleColor(.systemPurple, for: .normal)
        loginButton.setTitleColor(.white, for: .selected)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        loginButton.layer.cornerRadius = 30
        loginButton.layer.borderColor = UIColor.systemPurple.cgColor
        loginButton.layer.borderWidth = 2.5
        self.addSubview(loginButton)
    }
}
