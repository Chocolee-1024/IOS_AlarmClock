import UIKit

class SettingRepeatViewController: UIViewController {

    @IBOutlet weak var settingRepeatTableView: UITableView!
    var repeatArray: [Bool] = [false,false,false,false,false,false,false,false]
    var lastRepeatArray: [Bool] = []
    var repeatString: String = ""
    var delegate: repeatProtocol?
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "重複"
        setupUI()
        setupArray()
    }
    // 設定 UI樣式
    private func setupUI() {
        setupTableView()
        setupNavigationBarItem()
    }
    // 設定返回 Button
    private func setupNavigationBarItem() {
        let backBtn = UIButton()
        backBtn.setTitle("返回", for: .normal)
        backBtn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backBtn.tintColor = .systemOrange
        backBtn.setTitleColor(.systemOrange, for: .normal)
        backBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backBtnIsClicked)))
        let backBtnItem = UIBarButtonItem(customView: backBtn)
        self.navigationItem.leftBarButtonItems = [backBtnItem]
    }
    // 設定 Array
    private func setupArray(){
        if lastRepeatArray != []{
            repeatArray = lastRepeatArray
        }
    }
    
    // 返回 Button事件
    @objc func backBtnIsClicked() {
        NotificationCenter.default.post(name: .reloadAlarmClockSettingVC, object: nil)
        for day in 0...6{
            if repeatArray[day] == true {
                switch day {
                case 0: repeatString = repeatString + " 週日"
                case 1: repeatString = repeatString + " 週一"
                case 2: repeatString = repeatString + " 週二"
                case 3: repeatString = repeatString + " 週三"
                case 4: repeatString = repeatString + " 週四"
                case 5: repeatString = repeatString + " 週五"
                default: repeatString = repeatString + " 週六"
                }
            }
        }
        guard delegate != nil else {return}
        delegate?.repeatProtocol?(repeatArray: repeatArray, repeatString: repeatString)
        self.navigationController?.popViewController(animated: true)
    }


    // 設定 TableView
    private func setupTableView() {
        settingRepeatTableView.delegate = self
        settingRepeatTableView.dataSource = self
        settingRepeatTableView.register(UINib(nibName: "SettingRepeatTableViewCell", bundle: nil), forCellReuseIdentifier: SettingRepeatTableViewCell.identifier)
    }

}
// MARK: - TableView
extension SettingRepeatViewController: UITableViewDelegate, UITableViewDataSource {
    // Cell 數量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    // 設計 Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingRepeatTableViewCell.identifier, for: indexPath) as? SettingRepeatTableViewCell else {
                fatalError("AQITableViewCell Load Failed!")
        }
        switch indexPath.row {
            case 0: cell.setupInit(day: "星期日")
            case 1: cell.setupInit(day: "星期一")
            case 2: cell.setupInit(day: "星期二")
            case 3: cell.setupInit(day: "星期三")
            case 4: cell.setupInit(day: "星期四")
            case 5: cell.setupInit(day: "星期五")
            default: cell.setupInit(day: "星期六")
        }
        cell.setupItem(array: repeatArray, indexPath: indexPath.row)
        return cell
        
    }
    // Cell 高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    // Cell 點擊事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        repeatArray[indexPath.row] = !repeatArray[indexPath.row]
        tableView.reloadData()
    }
}

// MARK: - Protocol
@objc protocol repeatProtocol: NSObjectProtocol {
    @objc optional func repeatProtocol(repeatArray: [Bool], repeatString: String)
}
    
