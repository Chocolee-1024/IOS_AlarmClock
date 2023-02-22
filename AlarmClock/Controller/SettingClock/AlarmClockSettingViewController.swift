//
//  AlarmClockSettingViewController.swift
//  AlarmClock
//
//  Created by imac-1763 on 2023/2/7.
//

import UIKit

class AlarmClockSettingViewController: UIViewController {

    @IBOutlet weak var timePicker: UIPickerView!
    @IBOutlet weak var alarmClockSettingTableView: UITableView!
    let settingRepeatDelegate = SettingRepeatViewController()
    let settingRingDelegate = SettingRingViewController()
    let settingTagDelegate = SettingTagViewController()
    var pmamArray: [String] = ["上午","下午"]
    var minuteArray: [String] = []
    var hourArray: [String] = []
    
    var settingTitle: String = " "
    var repeatString: String = ""
    var ringString: String = ""
    var minute: String = ""
    var hour: String = ""
    var tag: String = ""
    
    var repeatArray: [Bool] = []
    var ringArray: [Bool] = []
    var isOn = true
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: .reloadAlarmClockSettingVC, object: nil)
        if settingTitle == "新增鬧鐘"{
            minute = "00"
            hour = "1"
        }
        setupArray()
        setupPicker()
        setupTableView()
        setupSubTitle()
        setupNavigationBarItems()
    }
    // 設定 Array
    private func setupArray() {
        for time in 0...59 {
            if (time > 9) {
                minuteArray.append(String(time))
            } else {
                minuteArray.append("0\(time)")
            }
        }
        for time in 1...24 {
            hourArray.append(String(time))
        }
    }
    // 設定各功能 SubTitle
    private func setupSubTitle() {
        repeatString = ClockPreferences.shared.clockRepeatString
        repeatArray = ClockPreferences.shared.clockRepeatBool
        ringString = ClockPreferences.shared.clockRingString
        ringArray = ClockPreferences.shared.clockRingBool
        minute = ClockPreferences.shared.clockMinute
        isOn = ClockPreferences.shared.clockRimind
        hour = ClockPreferences.shared.clockHour
        tag = ClockPreferences.shared.clockTag
        
        let hourIndex = hourArray.firstIndex(of: ClockPreferences.shared.clockHour)
        let minuteIndex = minuteArray.firstIndex(of: ClockPreferences.shared.clockMinute)

        timePicker.selectRow(hourIndex!, inComponent: 1, animated: false)
        timePicker.selectRow(minuteIndex!, inComponent: 2, animated: false)
        
        if hourIndex! > 10 {
            timePicker.selectRow(1, inComponent: 0, animated: false)
        }
    }

    // 設定 TableView
    private func setupTableView() {
        alarmClockSettingTableView.bounces = false
        alarmClockSettingTableView.delegate = self
        alarmClockSettingTableView.dataSource = self
        
        
        alarmClockSettingTableView.register(UINib(nibName: "AlarmClockSettingTableViewCell", bundle: nil), forCellReuseIdentifier: AlarmClockSettingTableViewCell.identifier)
        
        alarmClockSettingTableView.register(UINib(nibName: "SettingRimindTableViewCell", bundle: nil), forCellReuseIdentifier: SettingRimindTableViewCell.identifier)
        
        alarmClockSettingTableView.register(UINib(nibName: "SettingDeleteTableViewCell", bundle: nil), forCellReuseIdentifier: SettingDeleteTableViewCell.identifier)
    }
    // 設定 Picker
    private func setupPicker() {
        timePicker.delegate = self
        timePicker.dataSource = self
    }
    // 設定 NavigationBarItems
    private func setupNavigationBarItems() {
        let cancelItem = UIBarButtonItem(title: "取消",
                                       style: .done,
                                       target: self,
                                       action: #selector(cancelButtonClicled))
        cancelItem.tintColor = .systemOrange
        navigationItem.leftBarButtonItem = cancelItem
        
        let saveItem = UIBarButtonItem(title: "儲存",
                                      style: .done,
                                      target: self,
                                      action: #selector(saveButtonClicked))
        saveItem.tintColor = .systemOrange
        navigationItem.rightBarButtonItem = saveItem
        
        navigationItem.title = settingTitle
        navigationItem.titleView?.tintColor = .systemOrange

    }
    // Button 取消事件
    @objc func cancelButtonClicled(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    // Button 儲存事件
    @objc func saveButtonClicked(_ sender: UIButton) {
        ClockPreferences.shared.clockTag = tag
        ClockPreferences.shared.clockRimind = isOn
        ClockPreferences.shared.clockRingString = ringString
        ClockPreferences.shared.clockRepeatString = repeatString
        ClockPreferences.shared.clockRingBool = ringArray
        ClockPreferences.shared.clockRepeatBool = repeatArray
        if(minute == ""){
            ClockPreferences.shared.clockMinute = ClockPreferences.shared.clockMinute
        } else {
            ClockPreferences.shared.clockMinute = minute
        }
        if(hour == ""){
            ClockPreferences.shared.clockHour = ClockPreferences.shared.clockHour
        } else {
            ClockPreferences.shared.clockHour = hour
        }
        if settingTitle == "新增鬧鐘" {
            ClockPreferences.shared.clockTime = true
            LocalDatabase.share.addClock()
        } else {
            LocalDatabase.share.updataClock()
        }
        NotificationCenter.default.post(name: .reloadAlarmClockVC, object: nil)
        self.dismiss(animated: true)

    }
    // 稍後提醒 Switch 切換事件
    @objc func clickSwitch(_ sender: UISwitch) {
        isOn = sender.isOn
    }
    // TableView 刷新
    @objc func reloadTableView(){
        alarmClockSettingTableView.reloadData()
    }
}
//MARK: - PickerView
extension AlarmClockSettingViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    // Column 數量
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    // Row 數量
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
    // 實作滑到的選項
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
    // 設定 pickerView Title 顏色
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if component == 0 {
            return NSAttributedString(string: pmamArray[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
        else if component == 1{
            if row < 12 {
                return NSAttributedString(string: hourArray[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            } else {
                var num: Int = (Int(hourArray[row])!) % 12
                if num == 0 {
                    num = num + 12
                }
                return NSAttributedString(string: "\(num)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            }
        }
        else {
            return NSAttributedString(string: minuteArray[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
    }
    // pickerView 選擇事件
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if component == 1{
            if row > 10 && row != 23{
                pickerView.selectRow(1, inComponent: 0, animated: true)
            } else if row < 12 || row == 23 {
                pickerView.selectRow(0, inComponent: 0, animated: true)
            }
            hour = hourArray[row]
        } else if (component == 2) {
            minute = minuteArray[row]
        } else {
            if row == 0 && Int(hour)! > 10 && Int(hour)! != 23{
                hour = String(Int(hour)! - 12)
                print(hour)
            } else if row == 1 && ( Int(hour)!  < 12 || Int(hour)!  == 23) {
                print(row)
                hour = String(Int(hour)! + 12)
            }
        }
    }
    
}
//MARK: - TableView
extension AlarmClockSettingViewController: UITableViewDelegate, UITableViewDataSource {
    // Scetions 數量
    func numberOfSections(in tableView: UITableView) -> Int {
        if(settingTitle == "編輯鬧鐘"){
            return 2
        } else {
            return 1
        }
    }
    // Cell 數量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 4
        case 1: return 1
        default : return 0
        }
    }
    // 綁定 Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0, 1, 2:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmClockSettingTableViewCell.identifier, for: indexPath) as? AlarmClockSettingTableViewCell else {
                    fatalError("AQITableViewCell Load Failed!")
                }
                if indexPath.row == 0 {
                    cell.setupInit(title: "重複", subTitle: repeatString)
                } else if indexPath.row == 1 {
                    cell.setupInit(title: "標籤", subTitle: tag)
                } else {
                    cell.setupInit(title: "提示聲", subTitle: ringString)
                }
                return cell
            default:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingRimindTableViewCell.identifier, for: indexPath) as? SettingRimindTableViewCell else {
                    fatalError("AQITableViewCell Load Failed!")
                }
                cell.remindSwitch.addTarget(self, action: #selector(clickSwitch), for: .touchUpInside)
                cell.setupInit(isOn: isOn)
                return cell
            }
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingDeleteTableViewCell.identifier, for: indexPath) as? SettingDeleteTableViewCell else {
                fatalError("AQITableViewCell Load Failed!")
            }
            cell.setupInit()
            return cell
        }
    }
    // Cell 高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    // Cell 點擊事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let nextVC = SettingRepeatViewController()
                nextVC.delegate = self
                nextVC.lastRepeatArray = repeatArray
                self.navigationController?.pushViewController(nextVC, animated: true)
            case 1:
                let nextVC = SettingTagViewController()
                nextVC.delegate = self
                nextVC.tagValue = tag
                self.navigationController?.pushViewController(nextVC, animated: true)
            case 2:
                let nextVC = SettingRingViewController()
                nextVC.delegate = self
                nextVC.lastclickRingArray = ringArray
                self.navigationController?.pushViewController(nextVC, animated: true)
            default:
                break
            }
        default:
            LocalDatabase.share.deleteClock(uuid: ClockPreferences.shared.uuid)
            NotificationCenter.default.post(name: .reloadAlarmClockVC, object: nil)

            self.dismiss(animated: true)
        }
    }
}

//MARK: - protocol
extension AlarmClockSettingViewController: repeatProtocol ,tagProtocol, ringProtocol{
    //  重複頁面 protocol
    func repeatProtocol(repeatArray: [Bool], repeatString: String) {
        self.repeatArray = repeatArray
        if repeatString.count == 21 {
            self.repeatString = "每天"
        } else if repeatString.count == 0 {
            self.repeatString = "永不"
        } else {
            self.repeatString = repeatString
        }
    }
    //  標籤頁面 protocol
    func tagProtocol(tag: String?) {
        if tag == ""{
            self.tag = "鬧鐘"
        } else {
            self.tag = tag!
        }
    }
    //  鈴聲頁面 protocol
    func ringProtocol(ringArray: [Bool], ringString: String) {
        self.ringArray = ringArray
        self.ringString = ringString
    }
}


