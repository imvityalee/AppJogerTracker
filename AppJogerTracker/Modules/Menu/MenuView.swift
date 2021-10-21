import Foundation
import UIKit
import SnapKit

class MenuView: UIView {
    
    var imageLogo: UIImageView!
    var closeButton: UIButton!
    var jogsButton: UIButton!
    var infoButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setUpView()
        setUpConstraints()
        
    }
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func setUpConstraints() {
        imageLogo.snp.makeConstraints {
            $0.width.equalTo(98)
            $0.height.equalTo(37)
            $0.leading.equalToSuperview().offset(35)
            $0.top.equalToSuperview().offset(35)
        }
        
        closeButton.snp.makeConstraints {
            $0.width.equalTo(28)
            $0.height.equalTo(24)
            $0.trailing.equalToSuperview().offset(-35)
            $0.top.equalToSuperview().offset(45)
        }
        jogsButton.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        }
        
        infoButton.snp.makeConstraints {
            $0.centerY.equalTo(jogsButton.snp.centerY).offset(60)
            $0.centerX.equalToSuperview()
            
        }
        
    }
    
    private func setUpView() {
        configureImageLogo()
        configureCloseButtuon()
        configureJogsButton()
        configureInfoButton()
    }
    
    private func configureImageLogo() {
        imageLogo = .init(image: UIImage(named: ImageConstants.imageGreenLogo)!)
        self.addSubview(imageLogo)
    }
    
    private func configureCloseButtuon() {
        closeButton = .init(type: .close)
        self.addSubview(closeButton)
    }
    
    private func configureJogsButton()  {
        jogsButton = .init(type: .custom)
        jogsButton.setTitle(LabelConstants.jogs.uppercased(), for: .normal)
        jogsButton.setTitleColor(.systemGreen, for: .highlighted)
        jogsButton.setTitleColor(.darkGray, for: .normal)
        jogsButton.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        self.addSubview(jogsButton)
    }
    
    private func configureInfoButton() {
        infoButton = .init(type: .custom)
        infoButton.setTitle(LabelConstants.info.uppercased(), for: .normal)
        infoButton.setTitleColor(.systemGreen, for: .highlighted)
        infoButton.setTitleColor(.darkGray, for: .normal)
        infoButton.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        self.addSubview(infoButton)
    }
}
