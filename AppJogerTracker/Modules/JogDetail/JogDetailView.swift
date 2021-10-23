import Foundation
import SnapKit
import UIKit


class JogDetailView: BaseView {
    
    var view: UIView!
    var closeButton: UIButton!
    var distanceTexfield: UITextField!
    var distanceLabel: UILabel!
    var timeTextFiled: UITextField!
    var timeLabel: UILabel!
    var dateTextfield: UITextField!
    var dateLabel: UILabel!
    var saveButton: UIButton!
    
    func dateStringFormat(from date: Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: date)
    }
    
    func configure(model: JogsDetailPresentableModel) {
        distanceTexfield.text = String(model.distance)
        timeTextFiled.text = String(model.time)
        dateTextfield.text = dateStringFormat(from: model.date)
    }
    override func setUpView() {
        super.setUpView()
        configureDatePicker()
        configureSaveButton()
        configureCloseButton()
        configureTimeTexftield()
        configureDistanceTextfield()
        configureMainView()
    }
    
    override func setUpConstraints() {
        super.setUpConstraints()
        
        view.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
            $0.width.equalTo(307)
            $0.height.equalTo(380)
        }
        closeButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
        }
        
        saveButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-20)
            $0.leading.equalToSuperview().offset(37)
            $0.trailing.equalToSuperview().offset(-37)
        }
        dateTextfield.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(37)
            $0.trailing.equalToSuperview().offset(-37)
            $0.height.equalTo(31)
            $0.bottom.equalTo(saveButton.snp.top).offset(-41)
        }
        
        dateLabel.snp.makeConstraints {
            $0.bottom.equalTo(dateTextfield.snp.top).offset(-5)
            $0.leading.equalToSuperview().offset(37)
        }
        
        timeTextFiled.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(37)
            $0.trailing.equalToSuperview().offset(-37)
            $0.bottom.equalTo(dateLabel.snp.top).offset(-20)
            $0.height.equalTo(31)
        }
        
        timeLabel.snp.makeConstraints {
            $0.bottom.equalTo(timeTextFiled.snp.top).offset(-5)
            $0.leading.equalToSuperview().offset(37)
        }
        
        distanceTexfield.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(37)
            $0.trailing.equalToSuperview().offset(-37)
            $0.bottom.equalTo(timeLabel.snp.top).offset(-20)
            $0.height.equalTo(31)
        }
        
        distanceLabel.snp.makeConstraints {
            $0.bottom.equalTo(distanceTexfield.snp.top).offset(-5)
            $0.leading.equalToSuperview().offset(37)
        }
        
    }
    
    
    private func configureMainView()  {
        view = UIView.init()
        view.backgroundColor = .systemGreen
        view.layer.cornerRadius = 29
        
        view.addSubview(closeButton)
        view.addSubview(distanceTexfield)
        view.addSubview(distanceLabel)
        view.addSubview(timeTextFiled)
        view.addSubview(timeLabel)
        view.addSubview(dateTextfield)
        view.addSubview(dateLabel)
        view.addSubview(timeLabel)
        view.addSubview(saveButton)
        self.addSubview(view)
        
    }
    
    private func configureCloseButton() {
        closeButton = .init(type: .close)
    }
    
    private func configureDistanceTextfield() {
        distanceTexfield = .init()
        distanceTexfield.font = UIFont.systemFont(ofSize: 15)
        distanceLabel = .init()
        makeLabel(distanceLabel, text: LabelConstants.distance)
        makeRoundedView(distanceTexfield)
        
    }
    
    private func configureTimeTexftield() {
        timeTextFiled = .init()
        timeTextFiled.font = UIFont.systemFont(ofSize: 15)
        timeLabel = .init()
        makeLabel(timeLabel, text: LabelConstants.time)
        makeRoundedView(timeTextFiled)
    }
    
    private func configureDatePicker() {
        dateTextfield = .init()
        makeRoundedView(dateTextfield)
        
        dateLabel = .init()
        makeLabel(dateLabel, text: LabelConstants.date)
        
    }
    
    private func configureSaveButton() {
        saveButton = UIButton.init(type: .system)
        saveButton.setTitle(LabelConstants.save, for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        saveButton.backgroundColor = .clear
        saveButton.layer.cornerRadius = 25
        saveButton.layer.borderColor = UIColor.white.cgColor
        saveButton.layer.borderWidth = 2.5
        
    }
    
    private func makeRoundedView(_ uiControl: UIControl) {
        uiControl.backgroundColor = .white
        uiControl.layer.borderColor = UIColor.systemGray.cgColor
        uiControl.layer.borderWidth = 1.5
        uiControl.layer.cornerRadius = 5
    }
    
    private func makeLabel(_ label: UILabel, text: String) {
        label.text = text
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13)
    }
    
}
