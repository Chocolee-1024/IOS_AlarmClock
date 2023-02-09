//
//  SettingRemindTableViewCell.swift
//  AlarmClock
//
//  Created by imac-1763 on 2023/2/8.
//

import UIKit

class SettingRemindTableViewCell: UITableViewCell {
    @IBOutlet weak var remindSwitch: UISwitch!
    @IBOutlet weak var titleLabel: UILabel!
    static let identifier = "SettingRemindTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setupInit(){
        titleLabel.textColor = .white
        titleLabel.text = "稍後提醒"
    }
}
