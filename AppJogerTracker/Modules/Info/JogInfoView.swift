import Foundation
import UIKit
import SnapKit

class JogInfoView: BaseView {
    
    var label: UILabel!
    var textView: UITextView!
    
    override func setUpView() {
        super.setUpView()
        configureView()
    }
    
    override func setUpConstraints() {
        super.setUpConstraints()
        
        label.snp.makeConstraints {
            $0.top.equalTo(100)
            $0.leading.equalToSuperview().offset(25)
            $0.width.equalTo(60)
            $0.height.equalTo(30)
        }
        textView.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(6)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-25)
            $0.bottom.equalTo(0)
            
        }
    }
    
    private func configureView() {
        label = .init()
        label.text = LabelConstants.info.uppercased()
        label.textColor = .systemGreen
        self.addSubview(label)
        textView = .init()
        textView.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        textView.textColor = .darkGray
        textView.text = LabelConstants.textViewData
        self.addSubview(textView)
    }
    
}
