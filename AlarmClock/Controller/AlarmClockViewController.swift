
import UIKit

class AlarmClockViewController: UIViewController {

    
    @IBOutlet var alarmClockView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var alarmClockTableView: UITableView!
    var alarmClockArray: [Int] = [1]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 設定statusbar為白色
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        setupUI()
    }
    //設定 UI
    private func setupUI(){
        setupNagivationBarItems()
        setupUILabel()
        setupUIView()
        setupUITableView()
        
    }
    //設定 UILabel樣式
    private func setupUILabel(){
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 35)
        titleLabel.textColor = .white
        titleLabel.text = "鬧鐘"
    }
    //設定 UIView樣式
    private func setupUIView(){
        alarmClockView.backgroundColor = .black
    }
    //設定 UIView
    private func setupUITableView(){
        alarmClockTableView.separatorColor = .systemGray
        alarmClockTableView.backgroundColor = .black
        alarmClockTableView.delegate = self
        alarmClockTableView.dataSource = self
        alarmClockTableView.register(UINib(nibName: "AlarmClockTableViewCell", bundle: nil), forCellReuseIdentifier: AlarmClockTableViewCell.identifire)
    }
    //設定 NagivationBarItem
    private func setupNagivationBarItems(){
        let editItem = UIBarButtonItem(title: "編輯", style: .done, target: self, action: #selector(editItemClicked))
        editItem.tintColor = .systemOrange
        navigationItem.leftBarButtonItem = editItem
        
        let addItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(addItemClicked))
        addItem.tintColor = .systemOrange
        navigationItem.rightBarButtonItem = addItem
    }
    //BarButton 新增事件
    @objc func addItemClicked(){
        settingViewController(title: "新增鬧鐘")
    }
    //BarButton 編輯事件
    @objc func editItemClicked(){
        print(2)
    }
    //跳頁到 setting
    func settingViewController(title: String){
        let nextVC = AlarmClockSettingViewController()
        nextVC.settingTitle = title
        nextVC.modalPresentationStyle = .formSheet
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension AlarmClockViewController: UITableViewDelegate, UITableViewDataSource {
    //Cell數量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmClockArray.count
    }
    //建立 Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmClockTableViewCell.identifire, for: indexPath) as? AlarmClockTableViewCell else {
                fatalError("MessageTableViewCell Load Failed")
        }
        cell.backgroundColor = .black
        cell.setupInit()
        return cell
    }
    //設定 Cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    //Cell 點擊事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        settingViewController(title: "編輯鬧鐘")
    }

}
