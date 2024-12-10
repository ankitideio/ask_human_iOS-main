//
//  DarkModeVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 17/07/24.
//

import UIKit

class DarkModeVC: UIViewController {
    @IBOutlet var heightTblVw: NSLayoutConstraint!
    @IBOutlet var tblvw: UITableView!
    @IBOutlet var lblAbout: UILabel!
    @IBOutlet var lblScreenTitle: UILabel!
    @IBOutlet var btnBack: UIButton!
    
    var arr = ["On","Off","System Default"]
    var selectedIndexPath: IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
       uiSet()
    }
    func uiSet(){
        heightTblVw.constant = CGFloat(arr.count*50)
        
        darkMode()
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            darkMode()
            tblvw.reloadData()
            
        }
    }
    func darkMode(){
        if traitCollection.userInterfaceStyle == .dark {
            btnBack.setImage(UIImage(named: "keyboard-backspace25"), for: .normal)
            lblScreenTitle.textColor = .white
        }else{
            lblScreenTitle.textColor = .black
            btnBack.setImage(UIImage(named: "back"), for: .normal)
        }
    }
    @IBAction func actionBack(_ sender: UIButton) {
        SceneDelegate().tabBarProfileVCRoot()
    }

}

//MARK: - TABLEVIEW DELEGATE AND DATASOURCE

extension DarkModeVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DarkModeTVC", for: indexPath) as! DarkModeTVC
        cell.lblTitle.text = arr[indexPath.row]
        if traitCollection.userInterfaceStyle == .dark {
            cell.lblTitle.textColor = .white
        }else{
            cell.lblTitle.textColor = .black
        }
        switch Store.DarkMode {
        case 0:
            if indexPath.row == 0 {
                cell.imgVwSelect.image = UIImage(named: "tick")
            } else {
                cell.imgVwSelect.image = UIImage(named: "unTick")
            }
        case 1:
            if indexPath.row == 1 {
                cell.imgVwSelect.image = UIImage(named: "tick")
            } else {
                cell.imgVwSelect.image = UIImage(named: "unTick")
            }
        default:
            if indexPath.row == 2 {
                cell.imgVwSelect.image = UIImage(named: "tick")
            } else {
                cell.imgVwSelect.image = UIImage(named: "unTick")
            }
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let previousIndexPath = selectedIndexPath {
            let previousCell = tableView.cellForRow(at: previousIndexPath) as? DarkModeTVC
            previousCell?.imgVwSelect.image = UIImage(named: "unTick")
        }
        
        let selectedCell = tableView.cellForRow(at: indexPath) as! DarkModeTVC
        selectedCell.imgVwSelect.image = UIImage(named: "tick")
        
        selectedIndexPath = indexPath
        switch indexPath.row {
        case 0:
            //on
            Store.DarkMode = 0
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
        case 1:
            //off
            Store.DarkMode = 1
            
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
        default:
            //default
            Store.DarkMode = 2
            
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .unspecified
        }
        tblvw.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
