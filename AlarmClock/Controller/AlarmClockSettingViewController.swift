//
//  AlarmClockSettingViewController.swift
//  AlarmClock
//
//  Created by imac-1763 on 2023/2/7.
//

import UIKit

class AlarmClockSettingViewController: UIViewController {
    

    @IBOutlet var alarmClockSettingView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var timePicker: UIPickerView!
    @IBOutlet weak var alarmClockSettingTableView: UITableView!
    var pmamArray: [String] = ["上午","下午"]
    var hourArray: [String] = []
    var minuteArray: [String] = []
    var settingTitle: String = " "
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupArray()
        setupPicker()
        setupTableView()
    }
    //設定 Array
    private func setupArray(){
        for time in 1...60 {
            if (time > 9) {
                minuteArray.append(String(time))
            } else {
                minuteArray.append("0\(time)")
            }
        }
        for time in 1...24{
            if (time > 12){
                if(time == 24){
                    hourArray.append("12")
                } else {
                    hourArray.append(String(time % 12))
                }
            } else {
                hourArray.append(String(time))
            }
        }
    }
    //設定 UI樣式
    private func setupUI(){
        setupUIView()
        setupUILabel()
        setupUIButton()
    }
    //設定 UIView樣式
    private func setupUIView(){
        alarmClockSettingView.backgroundColor = UIColor(red: CGFloat (31)/255, green: CGFloat (33)/255, blue: CGFloat (36)/255, alpha: 1)
    }
    //設定 UILabel樣式
    private func setupUILabel(){
        titleLable.text = settingTitle
        titleLable.textColor = .white
        titleLable.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
    }
    //設定 UIButton樣式
    private func setupUIButton(){
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.setTitleColor(.systemOrange, for: .normal)
        
        saveButton.setTitle("儲存", for: .normal)
        saveButton.setTitleColor(.systemOrange, for: .normal)
    }
    //設定 TableView
    private func setupTableView(){
        alarmClockSettingTableView.bounces = false
        alarmClockSettingTableView.backgroundColor = UIColor(red: CGFloat (31)/255, green: CGFloat (33)/255, blue: CGFloat (36)/255, alpha: 1)
        alarmClockSettingTableView.delegate = self
        alarmClockSettingTableView.dataSource = self
        
        alarmClockSettingTableView.register(UINib(nibName: "AlarmClockSettingTableViewCell", bundle: nil), forCellReuseIdentifier: AlarmClockSettingTableViewCell.identifier)
        
        alarmClockSettingTableView.register(UINib(nibName: "SettingRemindTableViewCell", bundle: nil), forCellReuseIdentifier: SettingRemindTableViewCell.identifier)
        
        alarmClockSettingTableView.register(UINib(nibName: "SettingDeleteTableViewCell", bundle: nil), forCellReuseIdentifier: SettingDeleteTableViewCell.identifier)
    }
    // 設定 Picker
    private func setupPicker(){
        timePicker.delegate = self
        timePicker.dataSource = self
    }
    //Button 取消事件
    @IBAction func cancelButtonClicled(_ sender: UIButton){
        self.dismiss(animated: true)
    }
    //Button 儲存事件
    @IBAction func saveButtonClicked(_ sender: UIButton){
        print("save")
    }
}
//實作 PickerView
extension AlarmClockSettingViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    //Column 數量
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    //Row 數量
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return pmamArray.count
        }
        else if component == 1{
            return hourArray.count
        }
        else {
            return minuteArray.count
        }
    }
    //實作滑到的選像
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return pmamArray[row % pmamArray.count]
        }
        else if component == 1{
            return hourArray[row % hourArray.count]
        }
        else {
            return minuteArray[row % minuteArray.count]
        }
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if component == 0 {
            return NSAttributedString(string: pmamArray[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])        }
        else if component == 1{
            return NSAttributedString(string: hourArray[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])        }
        else {
            return NSAttributedString(string: minuteArray[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row > 11 && component == 1 {
            pickerView.selectRow(1, inComponent: 0, animated: true)
        } else if row < 12 && component == 1 {
            pickerView.selectRow(0, inComponent: 0, animated: true)
        }
    }
}
//實作 TabelView
extension AlarmClockSettingViewController: UITableViewDelegate, UITableViewDataSource {
    //Scetions 數量
    func numberOfSections(in tableView: UITableView) -> Int {
        if(settingTitle == "編輯鬧鐘"){
            return 2
        } else {
            return 1
        }
    }
    //Cell 數量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 4
        case 1: return 1
        default : return 0
        }
    }
    //綁定 Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0, 1, 2:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmClockSettingTableViewCell.identifier, for: indexPath) as? AlarmClockSettingTableViewCell else {
                    fatalError("AQITableViewCell Load Failed!")
                }
                if indexPath.row == 0{
                    cell.setupInit(title: "重複")
                } else if indexPath.row == 1{
                    cell.setupInit(title: "標籤")
                } else {
                    cell.setupInit(title: "提示聲")
                }
                cell.backgroundColor = UIColor(red: (38)/255, green: (40)/255, blue: 43/255, alpha: 1)
                return cell
            default:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingRemindTableViewCell.identifier, for: indexPath) as? SettingRemindTableViewCell else {
                    fatalError("AQITableViewCell Load Failed!")
                }
                cell.backgroundColor = UIColor(red: (38)/255, green: (40)/255, blue: 43/255, alpha: 1)
                cell.isUserInteractionEnabled = false
                cell.setupInit()
                return cell
            }
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingDeleteTableViewCell.identifier, for: indexPath) as? SettingDeleteTableViewCell else {
                fatalError("AQITableViewCell Load Failed!")
            }
            cell.setupInit()
            cell.backgroundColor = UIColor(red: (38)/255, green: (40)/255, blue: 43/255, alpha: 1)
            return cell
        }
    }
    //Cell 高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    //Cell 點擊事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                print(1111)
                let nextVC = SettingRepeatViewController()
                nextVC.modalPresentationStyle = .formSheet
                navigationController?.pushViewController(nextVC, animated: true)
            default:
                let nextVC = SettingRepeatViewController()
                nextVC.modalPresentationStyle = .formSheet
                navigationController?.present(nextVC, animated: false)
            }

        default:
            self.dismiss(animated: true)
        }
    }
}
