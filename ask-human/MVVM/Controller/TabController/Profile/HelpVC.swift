//
//  HelpVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 15/01/25.
//

import UIKit
class HelpVC: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet var lblScreenTitle: UILabel!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet weak var tblVwHelp: UITableView!
    
    //MARK: - variables
    var isSelect = false
    var selectIndex = -1
    var arrOption = [ContentPolicies]()
    var viewModel = ProfileVM()
    
    //MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getContent()
    }
    override func viewWillAppear(_ animated: Bool) {
        darkMode()
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            darkMode()
        }
    }
    private func darkMode() {
        let isDarkMode = traitCollection.userInterfaceStyle == .dark
        btnBack.setImage(UIImage(named: isDarkMode ? "keyboard-backspace25" : "back"), for: .normal)
        lblScreenTitle.textColor = isDarkMode ? .white : .black
    }

    private func getContent(){
        self.tblVwHelp.reloadData()
    }
    
    //MARK: - IBAction
    @IBAction func actionBack(_ sender: UIButton) {
        SceneDelegate().notificationsRoot(selectTab: 2)
    }
}
//MARK: - UITableViewDelegate
extension HelpVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOption.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HelpTVC", for: indexPath) as! HelpTVC
        cell.lblHeader.text = arrOption[indexPath.row].title ?? ""
        cell.lblDetail.text = arrOption[indexPath.row].description ?? ""
        cell.lblDetail.font = UIFont.italicSystemFont(ofSize: cell.lblDetail.font.pointSize)
        cell.btnDropdown.addTarget(self, action: #selector(dropDown), for: .touchUpInside)
        cell.btnDropdown.tag = indexPath.row
        if selectIndex == indexPath.row{
            cell.vwDetail.isHidden = isSelect ? false : true
            cell.btnDropdown.isSelected = isSelect ? true : false
            cell.imgVwDropDown.image = isSelect ? UIImage(named: "upp") : UIImage(named: "downn")
        }else{
            cell.vwDetail.isHidden = true
            cell.btnDropdown.isSelected = false
            cell.imgVwDropDown.image = UIImage(named: "downn")
        }
        let isDarkMode = traitCollection.userInterfaceStyle == .dark
        cell.vwBackground.backgroundColor = isDarkMode ? UIColor(hex: "#161616"): UIColor(hex: "#D9D9D9").withAlphaComponent(0.50)
        cell.lblHeader.textColor = isDarkMode ? .white : .black
        cell.lblDetail.textColor = isDarkMode ? .white : .black
        
        return cell
    }
    @objc func dropDown(sender:UIButton){
        sender.isSelected = !sender.isSelected
        selectIndex = sender.tag
        isSelect = sender.isSelected
        tblVwHelp.reloadData()
    }
}
