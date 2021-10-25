import Foundation
import UIKit
import SnapKit

public class BaseView: UIView {
    
    public var navigationBar: UINavigationBar!
    public var imageLogo: UIImageView!
    public var menuButton: UIButton!
    public var filterButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setUpView()
        setUpConstraints()
        
    }
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    public func setUpView() {
        configureFilterButton()
        configureMenuButton()
        configureImageLogo()
        configureNavigationBar()

    }
    
    public func setUpConstraints() {
        navigationBar.snp.makeConstraints {
            $0.height.equalTo(84)
            $0.width.equalToSuperview()
        }
        
        imageLogo.snp.makeConstraints {
            $0.width.equalTo(98)
            $0.height.equalTo(37)
            $0.leading.equalToSuperview().offset(35)
            $0.top.equalToSuperview().offset(35)
        }
        menuButton.snp.makeConstraints {
            $0.width.equalTo(28)
            $0.height.equalTo(24)
            $0.trailing.equalToSuperview().offset(-35)
            $0.top.equalToSuperview().offset(45)
        }
        
        filterButton.snp.makeConstraints {
            $0.width.height.equalTo(26)
            $0.centerY.equalTo(menuButton)
            $0.trailing.equalTo(menuButton.snp.leading).offset(-45)
        }
    }
    public func configureNavigationBar() {
        navigationBar = UINavigationBar.init()
        navigationBar.backgroundColor = .systemGreen
        navigationBar.addSubview(imageLogo)
        navigationBar.addSubview(menuButton)
        navigationBar.addSubview(filterButton)
        self.addSubview(navigationBar)
    }
    public func configureImageLogo() {
        imageLogo = .init(
            image: UIImage(
            named: ImageConstants.imageLogo)!)
    }
    
    public func configureMenuButton() {
        menuButton = UIButton.init(type: .custom)
        menuButton.setImage(UIImage(named: ImageConstants.menuImage)!,
                            for: .normal)
    }
    
    public func configureFilterButton() {
        filterButton = UIButton.init(type: .custom)
        filterButton.setImage(UIImage(named: ImageConstants.filterImage)!,
                              for: .normal)
    }
    
}
