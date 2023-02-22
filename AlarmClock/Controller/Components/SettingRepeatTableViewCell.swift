//
//  SettingRepeatTableViewCell.swift
//  AlarmClock
//
//  Created by imac-1763 on 2023/2/9.
//

import UIKit

class SettingRepeatTableViewCell: UITableViewCell {
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    static let identifier = "SettingRepeatTableViewCell"
    var repeatArray: [Bool] = []
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    // 初始化
    func setupInit(day: String){
        dayLabel.textColor = .white
        dayLabel.text = day
        let item = NSTextAttachment()
        item.image = UIImage(systemName: "checkmark")?.withTintColor(.systemOrange)
        itemLabel.attributedText = NSMutableAttributedString(attachment: item)
    }
    
    func setupItem(array: [Bool], indexPath: Int) {
        let item = NSTextAttachment()
        item.image = UIImage(systemName: "checkmark")?.withTintColor(.systemOrange)
        itemLabel.attributedText = NSMutableAttributedString(attachment: item)
        
        repeatArray = array
        itemLabel.isHidden = !repeatArray[indexPath]

    }

}
