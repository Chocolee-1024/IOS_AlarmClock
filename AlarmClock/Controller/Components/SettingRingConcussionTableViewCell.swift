//
//  SettingRingConcussionTableViewCell.swift
//  AlarmClock
//
//  Created by imac-1763 on 2023/2/11.
//

import UIKit

class SettingRingConcussionTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    static let identifier = "SettingRingConcussionTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    // 初始化
    func setupInit(){
        subTitle.text = "預設值"
        titleLabel.text = "震動聲音"
        
        let item = NSTextAttachment()
        item.image = UIImage(systemName: "chevron.right")?.withTintColor(UIColor(red: (142)/255, green: (142)/255, blue: (142)/255, alpha: 1))
        itemLabel.attributedText = NSMutableAttributedString(attachment: item)
    }
}

