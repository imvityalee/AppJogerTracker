import Foundation
import SnapKit
import UIKit

class JogCell: UITableViewCell {
    
    var jogImageView: UIImageView!
    var dateLabel: UILabel!
    var speedLabel: UILabel!
    var distanceLabel: UILabel!
    var timeLabel: UILabel!
    
    var stackView: UIStackView!
    
    override var reuseIdentifier: String? {
        return LabelConstants.jogCell
    }
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
        configureView()
        configureStackView()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureCell() {
        selectionStyle = .gray
        isMultipleTouchEnabled = false
    }
    
    func configureView() {
        jogImageView = UIImageView.init(image: UIImage(named: ImageConstants.jogIcon)!)
        self.addSubview(jogImageView)
        
        dateLabel = UILabel.init()
        speedLabel = UILabel.init()
        distanceLabel = UILabel.init()
        timeLabel = UILabel.init()
               

    }
    func confiugre(wtih jog: Jog) {
        distanceLabel.text = "Distance: \(Int(jog.distance)) km"
        timeLabel.text = "Time: \(Int(jog.time)) min"
        speedLabel.text = "Speed: \(Int(jog.speed.isNaN ? 0: jog.speed)) km/h"
        dateLabel.text = dateStringFormat(from: jog.date)
        
    }
    
    func configureConstraints() {
        
        stackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-10)
            $0.leading.equalTo(jogImageView.snp.trailing).offset(50)
        }

        jogImageView.snp.makeConstraints {
            $0.centerY.equalTo(stackView).offset(10)
            $0.width.height.equalTo(87)
            $0.leading.equalTo(10)
        }
    }
    
    func configureStackView() {
        stackView = UIStackView.init(arrangedSubviews: [dateLabel,
                                                       speedLabel,
                                                       distanceLabel,
                                                       timeLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        self.addSubview(stackView)
    }

    
    private func dateStringFormat(from date: Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/dd/MM"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        return dateFormatter.string(from: date)
    }
}
