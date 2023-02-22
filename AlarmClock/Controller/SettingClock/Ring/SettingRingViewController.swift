//
//  SettingRingViewController.swift
//  AlarmClock
//
//  Created by imac-1763 on 2023/2/10.
//

import UIKit

class SettingRingViewController: UIViewController {
    
    @IBOutlet weak var settingRingTableView: UITableView!
    let ringArray: [String] = ["選擇歌曲","我的歌曲","雷達 (預設值)","上升","山坡","公告","水晶","宇宙","波浪","信號","急板","指標","星座","海邊","閃爍","頂尖","頂峰","絲綢","開場","煎茶","照耀","遊戲時間","電路","漣漪","漸強","貓頭鷹","輻射","鈴聲","觀星","經典","無"]
    var lastclickRingArray: [Bool] = []
    var clickRingArray: [Bool] = []
    var delegate: ringProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "提示聲"
        setupUI()
        setupArray()
    }
    // 設定 Array
    private func setupArray(){
        if lastclickRingArray != [] {
            clickRingArray = lastclickRingArray
        } else {
            for i in 0...30 {
                if i == 1{
                    clickRingArray.append(true)
                } else {
                    clickRingArray.append(false)

                }
            }
        }
    }
    // 設定 UI
    private func setupUI(){
        setupUITableView()
        setupNavigationBarItem()
    }

    // 設定 TableView
    private func setupUITableView(){
        settingRingTableView.delegate = self
        settingRingTableView.dataSource = self
        settingRingTableView.register(UINib(nibName: "SettingRingTableViewCell", bundle: nil), forCellReuseIdentifier: SettingRingTableViewCell.identifier)
        settingRingTableView.register(UINib(nibName: "SettingRingConcussionTableViewCell", bundle: nil), forCellReuseIdentifier: SettingRingConcussionTableViewCell.identifier)
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
    // 返回 Button事件
    @objc func backBtnIsClicked(_ sender: UIButton) {
        let index = clickRingArray.firstIndex(of: true)
        
        guard delegate != nil else {return}
        delegate?.ringProtocol?(ringArray: clickRingArray, ringString: ringArray[index!])
        NotificationCenter.default.post(name: .reloadAlarmClockSettingVC, object: nil)
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - TableView
extension SettingRingViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 29
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingRingConcussionTableViewCell.identifier, for: indexPath) as? SettingRingConcussionTableViewCell else{
                fatalError("TableViewCell Load Failed!")
            }
            cell.setupInit()
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingRingTableViewCell.identifier, for: indexPath) as? SettingRingTableViewCell else{
                fatalError("TableViewCell Load Failed!")
            }
            if indexPath.section == 3 {
                cell.setupInit(title: ringArray[ringArray.count - 1], array: clickRingArray, indexPath: indexPath.row + 30)
                cell.hiddenNextItem()
            } else if indexPath.section == 2{
                cell.setupInit(title: ringArray[indexPath.row + 1], array: clickRingArray, indexPath: indexPath.row + 1)
                cell.hiddenNextItem()
            } else {
                cell.setupInit(title: ringArray[indexPath.row], array: clickRingArray, indexPath: indexPath.row)
                cell.showNextItem()
            }
            
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section != 0 {
            clickRingArray = []
        }
        for _ in 0...30 {
            clickRingArray.append(false)
        }
        if indexPath.section == 1 {
            clickRingArray[indexPath.row] = true
        }
        else if indexPath.section == 2 {
            clickRingArray[indexPath.row + 1] = true
        }
        else if indexPath.section == 3 {
            clickRingArray[30] = true
        }
        tableView.reloadData()
    }
}
// MARK: - protocol
@objc protocol ringProtocol: NSObjectProtocol {
    @objc optional func ringProtocol(ringArray: [Bool], ringString: String)
    
}
    
