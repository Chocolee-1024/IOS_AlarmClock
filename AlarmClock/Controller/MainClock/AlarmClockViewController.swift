
import UIKit

class AlarmClockViewController: UIViewController {

    @IBOutlet weak var alarmClockTableView: UITableView!
    let localDatabase = LocalDatabase.share
    var alarmClockArray: [Clock] = []
    var leftTitle: String = "編輯"
    var timeBool: Bool = true
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "鬧鐘"
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: .reloadAlarmClockVC, object: nil)
        setupUI()
        fetch()
    }
    
    // 設定 UI
    private func setupUI() {
        setupNavigationBarItems()
        setupUITableView()
    }

    // 設定 UITableView
    private func setupUITableView() {
        alarmClockTableView.separatorColor = .systemGray
        alarmClockTableView.delegate = self
        alarmClockTableView.dataSource = self
        alarmClockTableView.register(UINib(nibName: "AlarmClockTableViewCell", bundle: nil),
                                     forCellReuseIdentifier: AlarmClockTableViewCell.identifire)
        
        alarmClockTableView.allowsSelectionDuringEditing = true
    }
    
    // 設定 NavigationBarItems
    private func setupNavigationBarItems() {
        let editItem = UIBarButtonItem(title: "編輯",
                                       style: .done,
                                       target: self,
                                       action: #selector(editItemClicked))
        editItem.tintColor = .systemOrange
        navigationItem.leftBarButtonItem = editItem
        
        let addItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                      style: .done,
                                      target: self,
                                      action: #selector(addItemClicked))
        addItem.tintColor = .systemOrange
        navigationItem.rightBarButtonItem = addItem

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
    }
    
    // 撈資料
    func fetch() {
        self.alarmClockArray = self.localDatabase.fetchFromDatabase()
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ["notification"])
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["notification"])
        for i in alarmClockArray {
            if i.clockTime == true {
                callNotification(subtitle: i.clockTag, clockHour: i.clockHour, clockMinute: i.clockMinute)
            } 
        }
        self.alarmClockTableView.reloadData()
    }
    
    // 發送通知
    private func callNotification(subtitle: String, clockHour: String, clockMinute: String) {
        let content = UNMutableNotificationContent()
        content.title = "鬧鐘"
        content.subtitle = "\(subtitle)"
        content.badge = 1
        
        let minute = Calendar.current.component(.minute, from: Date())
        let month = Calendar.current.component(.month, from: Date())
        let year = Calendar.current.component(.year, from: Date())
        let hour = Calendar.current.component(.hour, from: Date())
        let day = Calendar.current.component(.day, from: Date())
        let trigger: UNCalendarNotificationTrigger
        let request: UNNotificationRequest

        
        if Int(clockHour)! > hour || (Int(clockMinute)! > minute && Int(clockHour)! == hour) {
            let dateComponents = DateComponents(year: year, month: Int(exactly: month)!, day: Int(exactly: day)!,hour: Int(clockHour)!, minute: Int(clockMinute)!)
            trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents,repeats: false)
        } else {
            let dateComponents = DateComponents(year: year, month: Int(exactly: month)!, day: Int(exactly: day + 1)!,hour: Int(clockHour)!, minute: Int(clockMinute)!)
            trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents,repeats: false)
        }
        
        request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
            print("成功建立通知...")
        })
        
    }
    
    // BarButton 新增事件
    @objc func addItemClicked() {
        // 刪除所有的持久化儲存資料
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
        settingViewController(title: "新增鬧鐘")
    }
    
    // BarButton 編輯事件
    @objc func editItemClicked() {
        if leftTitle == "編輯" {
            leftTitle = "完成"
            navigationItem.leftBarButtonItem = nil
            let editItem = UIBarButtonItem(title: "完成",
                                           style: .done,
                                           target: self,
                                           action: #selector(editItemClicked))
            editItem.tintColor = .systemOrange
            navigationItem.leftBarButtonItem = editItem
            alarmClockTableView.setEditing(true, animated: true)
            alarmClockTableView.reloadData()
        } else {
            leftTitle = "編輯"
            navigationItem.leftBarButtonItem = nil
            let editItem = UIBarButtonItem(title: "編輯",
                                           style: .done,
                                           target: self,
                                           action: #selector(editItemClicked))
            editItem.tintColor = .systemOrange
            navigationItem.leftBarButtonItem = editItem
            alarmClockTableView.setEditing(false, animated: true)
            alarmClockTableView.reloadData()
        }
    }
    
    // switch 切換事件
    @objc func clickSwitch(_ sender: UISwitch) {
        ClockPreferences.shared.clockTime = sender.isOn
        let index: Int = sender.tag
        ClockPreferences.shared.uuid = alarmClockArray[index].uuid
        localDatabase.updataOpenClock()
        fetch()
        
    }
    
    // 通知撈資料
    @objc func reloadData() {
        fetch()
    }
    
    //跳頁到 setting
    func settingViewController(title: String) {
        let nextVC = AlarmClockSettingViewController()
        nextVC.settingTitle = title
        let nvc = UINavigationController(rootViewController: nextVC)
        self.navigationController?.present(nvc, animated: true)
    }
}
// MARK: - UITableViewDelegate, UITableViewDataSource
extension AlarmClockViewController: UITableViewDelegate, UITableViewDataSource {

    // Cell 數量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmClockArray.count
    }
    // 建立 Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmClockTableViewCell.identifire, for: indexPath) as? AlarmClockTableViewCell else {
                fatalError("MessageTableViewCell Load Failed")
            }
        cell.backgroundColor = .black
        if !cell.isEditing {
            cell.openSwitch.isHidden = false
            cell.itemLebel.isHidden = true
        }
        cell.openSwitch.tag = indexPath.row
        cell.openSwitch.addTarget(self, action: #selector(clickSwitch), for: .touchUpInside)
        cell.setupInit(hour: alarmClockArray[indexPath.row].clockHour,
                       minute: alarmClockArray[indexPath.row].clockMinute,
                       tag: alarmClockArray[indexPath.row].clockTag,
                       repeatString: alarmClockArray[indexPath.row].clockRepeatString,
                       timeBool: alarmClockArray[indexPath.row].clockTime)
        return cell
    }
    
    // 設定 Cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // Cell 點擊事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        ClockPreferences.shared.clockTag = alarmClockArray[indexPath.row].clockTag
        ClockPreferences.shared.clockRimind = alarmClockArray[indexPath.row].clockRimind
        ClockPreferences.shared.clockRingString = alarmClockArray[indexPath.row].clockRingString
        ClockPreferences.shared.clockRepeatString = alarmClockArray[indexPath.row].clockRepeatString
        ClockPreferences.shared.clockHour = alarmClockArray[indexPath.row].clockHour
        ClockPreferences.shared.clockMinute = alarmClockArray[indexPath.row].clockMinute
        ClockPreferences.shared.uuid = alarmClockArray[indexPath.row].uuid
        ClockPreferences.shared.clockRepeatBool = alarmClockArray[indexPath.row].clockRepeatBool
        ClockPreferences.shared.clockRingBool = alarmClockArray[indexPath.row].clockRingBool
            
        settingViewController(title: "編輯鬧鐘")
    }
    // Cell 右往左滑事件
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "刪除") { action, sourceView, completionHandler in
            self.localDatabase.deleteClock(uuid: self.alarmClockArray[indexPath.row].uuid)
            self.fetch()
            completionHandler(true)
        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}
