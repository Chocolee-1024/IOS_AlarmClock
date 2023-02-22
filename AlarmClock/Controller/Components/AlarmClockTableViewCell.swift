//
//  AlarmClockTableViewCell.swift
//  AlarmClock
//
//  Created by imac-1763 on 2023/2/7.
//

import UIKit

class AlarmClockTableViewCell: UITableViewCell {
    
    @IBOutlet weak var am_pmLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contextLabel: UILabel!
    @IBOutlet weak var openSwitch: UISwitch!
    @IBOutlet weak var itemLebel: UILabel!
    static let identifire = "AlarmClockTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    // 初始化
    func setupInit(hour: String, minute: String, tag: String, repeatString: String, timeBool: Bool) {
        setupLabel(hour: hour, minute: minute, tag: tag, repeatString: repeatString)
        setupSwitch(timeBool: timeBool)
    }
    //設定 Label
    private func setupLabel(hour: String, minute: String, tag: String, repeatString: String) {
        am_pmLabel.font = UIFont.systemFont(ofSize: 40)
        timeLabel.font = UIFont.systemFont(ofSize: 65)
        contextLabel.font = UIFont.systemFont(ofSize: 15)
        
        var num: Int = (Int(hour)!) % 12
        if num == 0 {
            num = num + 12
        }
        if Int(hour)! < 12 || Int(hour)! == 24 {
            am_pmLabel.text = "上午 "
            timeLabel.text = "\(num):\(minute)"
        } else {
            am_pmLabel.text = "下午 "

            timeLabel.text = "\(num):\(minute)"
        }
        if repeatString == "永不" {
            contextLabel.text = "\(tag)"
        } else {
            contextLabel.text = "\(tag)，\(repeatString)"
        }
        
        let item = NSTextAttachment()
        item.image = UIImage(systemName: "chevron.right")?.withTintColor(UIColor(red: (142)/255, green: (142)/255, blue: (142)/255, alpha: 1))
        
        itemLebel.attributedText = NSMutableAttributedString(attachment: item)
        
        itemLebel.isHidden = true
    }
    // 設定 Switch
    private func setupSwitch(timeBool: Bool) {
        openSwitch.isOn = timeBool
    }
}

