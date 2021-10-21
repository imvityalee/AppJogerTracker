import SnapKit
import Foundation

class JogsView: BaseView {
    var jogsTabelView: UITableView!
    var addJogsButton: UIButton!
//    var datePicker: UIDatePicker!
    
    override func setUpView() {
        super.setUpView()
        configureJogsTableView()
        configureAddJogsButton()
//        configureDatePicker()
    }
    override func setUpConstraints() {
        super.setUpConstraints()
        
        jogsTabelView.snp.makeConstraints {
            $0.leading.trailing.equalTo(0)
            $0.top.equalToSuperview().offset(80)
            $0.bottom.equalTo(addJogsButton.snp.top).offset(-10)

        }
        addJogsButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-30)
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
    
    private func configureJogsTableView() {
        jogsTabelView = UITableView.init()
        self.addSubview(jogsTabelView)
    }
    
    private func configureAddJogsButton() {
        addJogsButton = UIButton.init(type: .custom)
        addJogsButton.setImage(UIImage(named: ImageConstants.add)!, for: .normal)
        
        self.addSubview(addJogsButton)
    }
    
//    private func configureDatePicker() {
//        self.addSubview(datePicker)
//    }
}
