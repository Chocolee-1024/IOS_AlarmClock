//
//  AlarmClockSettingTableViewCell.swift
//  AlarmClock
//
//  Created by imac-1763 on 2023/2/8.
//

import UIKit

class AlarmClockSettingTableViewCell: UITableViewCell {
    static let identifier = "AlarmClockSettingTableViewCell"
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setupInit(title: String){
        titleLabel.textColor = .white
        titleLabel.text = title
        
        let item = NSTextAttachment()
        item.image = UIImage(systemName: "chevron.right")?.withTintColor(UIColor(red: (142)/255, green: (142)/255, blue: (142)/255, alpha: 1))
        itemLabel.attributedText = NSMutableAttributedString(attachment: item)
        
        
        subTitle.textColor = UIColor(red: (142)/255, green: (142)/255, blue: (142)/255, alpha: 1)
        subTitle.textAlignment  = .right
    }
}
