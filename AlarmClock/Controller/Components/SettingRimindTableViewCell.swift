
import UIKit

class SettingRimindTableViewCell: UITableViewCell {
    @IBOutlet weak var remindSwitch: UISwitch!
    @IBOutlet weak var titleLabel: UILabel!
    static let identifier = "SettingRemindTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // 初始化
    func setupInit(isOn: Bool){
        setupLabel()
        setupSwitch(isOn: isOn)
    }
    // 設定 Label
    private func setupLabel(){
        titleLabel.text = "稍後提醒"
    }
    // 設定 Switch
    private func setupSwitch(isOn: Bool){
        remindSwitch.isOn = isOn
    }
}
