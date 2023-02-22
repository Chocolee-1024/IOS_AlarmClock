//
//  SettingTagViewController.swift
//  AlarmClock
//
//  Created by imac-1763 on 2023/2/9.
//

import UIKit

class SettingTagViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var tagTextField: UITextField!
    var tagValue: String = ""
    var delegate: tagProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "標籤"
        setupUI()
    }
    // 設定 UI樣式
    private func setupUI(){
        setupUITextField()
        setUpNavigationBarItem()
    }
    // 設定返回 Button
    private func setUpNavigationBarItem() {
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
        NotificationCenter.default.post(name: .reloadAlarmClockSettingVC, object: nil)
        guard delegate != nil else {return}
        delegate?.tagProtocol?(tag: tagTextField.text)
        self.navigationController?.popViewController(animated: true)
        
    }
    // 設定 UITextField樣式
    private func setupUITextField(){
        tagTextField.backgroundColor = UIColor(red: (38)/255, green: (40)/255, blue: 43/255, alpha: 1)
        tagTextField.font = UIFont(name: "System", size: 20)
        tagTextField.enablesReturnKeyAutomatically = true
        tagTextField.tintColor = .systemOrange
        tagTextField.becomeFirstResponder()
        tagTextField.returnKeyType = .done
        tagTextField.text = tagValue
        tagTextField.delegate = self
        
        setupUITextFieldClearButton()

    }
    // 設定 TextField ClearButton
    private func setupUITextFieldClearButton(){
        //Button高度&寬度
        let height = tagTextField.bounds.height / 3
        let width = height + 10
        //設定位置大小
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        
        let clearButton = UIButton(frame: rect)
        
        clearButton.setImage(UIImage(systemName: "xmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(paletteColors: [.systemGray])), for: .normal)
        //放在右邊
        tagTextField.rightView = clearButton
        
        
        clearButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 5)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(deleteTextFieldContent))
        tagTextField.rightView?.addGestureRecognizer(tap)
        if tagTextField.text != "" {
            tagTextField.rightViewMode = .always
        }
    }
    // ClearButton 的事件
    @objc func deleteTextFieldContent() {
        tagTextField.text = ""
        tagTextField.rightViewMode = .never
    }
    // TextField 的文字改變事件
    @IBAction func tagValuable(_ sender: UITextField) {
        if tagTextField.text != ""{
            tagTextField.rightViewMode = .always
        } else {
            tagTextField.rightViewMode = .never
        }
    }
    
    // TextField 的按下完成事件
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        ClockPreferences().clockTag = tagTextField.text!
        NotificationCenter.default.post(name: .reloadAlarmClockSettingVC, object: nil)
        self.dismiss(animated: true)
        return true
        
    }
    
}
// MARK: - protocol
@objc protocol tagProtocol: NSObjectProtocol {
    @objc optional func tagProtocol(tag: String?)
    
}
