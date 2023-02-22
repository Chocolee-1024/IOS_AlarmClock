//
//  SettingRingTableViewCell.swift
//  AlarmClock
//
//  Created by imac-1763 on 2023/2/10.
//

import UIKit

class SettingRingTableViewCell: UITableViewCell {
    @IBOutlet weak var chickItem: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nextItem: UILabel!
    static let identifier = "SettingRingTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    // 初始化
    func setupInit(title: String, array: [Bool], indexPath: Int){

        titleLabel.text = title
        let nextNS = NSTextAttachment()
        nextNS.image = UIImage(systemName: "chevron.right")?.withTintColor(UIColor(red: (142)/255, green: (142)/255, blue: (142)/255, alpha: 1))
        nextItem.attributedText = NSMutableAttributedString(attachment: nextNS)
        
        let chickNS = NSTextAttachment()
        chickNS.image = UIImage(systemName: "checkmark")?.withTintColor(.systemOrange)
        chickItem.attributedText = NSMutableAttributedString(attachment: chickNS)
        
        chickItem.isHidden = !array[indexPath]
    }
        
    func showNextItem(){
        nextItem.isHidden = false
    }
    func hiddenNextItem(){
        nextItem.isHidden = true
    }

}
