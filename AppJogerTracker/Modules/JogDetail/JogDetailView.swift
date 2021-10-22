import Foundation
import SnapKit
import UIKit


struct JogsDetailPresentableModel {
    var distance: Float
    var time: Float
    var date: Date
    
    init(distance: Float = 0,
         time: Float = 0,
         date: Date = Date.now ) {
        self.distance = distance
        self.time = time
        self.date = date
    }
}
class MyAPIFunctions
{
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"

        // make sure the following are the same as that used in the API
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale.current

        return formatter
    }()

    class func shortString(fromDate date: Date) -> String {
        return formatter.string(from: date)
    }

    class func date(fromShortString string: String) -> Date? {
        return formatter.date(from: string)
    }
}
class JogDetailView: BaseView {
    
    var view: UIView!
    var closeButton: UIButton!
    var distanceTexfield: UITextField!
    var distanceLabel: UILabel!
    var timeTextFiled: UITextField!
    var timeLabel: UILabel!
    var datePicker: UIDatePicker!
    var dateLabel: UILabel!
    var saveButton: UIButton!
    
    func configure(model: JogsDetailPresentableModel) {
//        var date = model.date
//        let t = MyAPIFunctions.shortString(fromDate: date)
//        let c = MyAPIFunctions.date(fromShortString: t)
        distanceTexfield.text = String(model.distance)
        timeTextFiled.text = String(model.time)
//        datePicker.setDate(model.date, animated: true)
        
//        print(date)
//        print(t)
//        print(c)
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
        datePicker.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(37)
            $0.trailing.equalToSuperview().offset(-37)
            $0.bottom.equalTo(saveButton.snp.top).offset(-41)
        }
        
        dateLabel.snp.makeConstraints {
            $0.bottom.equalTo(datePicker.snp.top).offset(-5)
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
        view.addSubview(datePicker)
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
        datePicker = .init()
        datePicker.datePickerMode = .date
        makeRoundedView(datePicker)
        
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
