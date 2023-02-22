//
//  SettingDeleteTableViewCell.swift
//  AlarmClock
//
//  Created by imac-1763 on 2023/2/8.
//

import UIKit

class SettingDeleteTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    static let identifier = "SettingDeleteTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    // 初始化
    func setupInit(){
        titleLabel.text = "刪除鬧鐘"
        titleLabel.textColor = .systemRed
    }
}
