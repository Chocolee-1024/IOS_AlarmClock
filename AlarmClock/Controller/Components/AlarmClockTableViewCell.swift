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
    static let identifire = "AlarmClockTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func setupInit(){
        am_pmLabel.textColor = .white
        timeLabel.textColor = .white
        contextLabel.textColor = .white
        am_pmLabel.font = UIFont.systemFont(ofSize: 35)
        timeLabel.font = UIFont.systemFont(ofSize: 55)
        contextLabel.font = UIFont.systemFont(ofSize: 15)
        
        am_pmLabel.text = "上午"
        timeLabel.text = "10:30"
        contextLabel.text = "鬧鐘"
    }
}
