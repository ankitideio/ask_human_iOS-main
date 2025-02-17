//
//  PolicyAndAboutVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 15/01/25.
//

import UIKit

class PolicyAndAboutVC: UIViewController {
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var imgVwTitle: UIImageView!
    @IBOutlet var lblScreenTitle: UILabel!
    @IBOutlet var tblVwList: UITableView!
    var arrContent = [ContentPolicies]()
    var arrSection = [String]()
    var arrRow = [[ContentPolicies]]()    

    var viewModel = ProfileVM()
    var type = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "PolicyTVC", bundle: nil)
        tblVwList.register(nib, forCellReuseIdentifier: "PolicyTVC")
        let nib2 = UINib(nibName: "PolicySectionTVC", bundle: nil)
        tblVwList.register(nib2, forCellReuseIdentifier: "PolicySectionTVC")
        tblVwList.showsVerticalScrollIndicator = false
        tblVwList.estimatedRowHeight = 50
        tblVwList.rowHeight = UITableView.automaticDimension
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

    private func darkMode(){
        if traitCollection.userInterfaceStyle == .dark {
            btnBack.setImage(UIImage(named: "keyboard-backspace25"), for: .normal)
            lblScreenTitle.textColor = .white
        }else{
            btnBack.setImage(UIImage(named: "back"), for: .normal)
            lblScreenTitle.textColor = .black

        }
    }
    func getContent(){
        if type == "privacy_policy"{
            lblScreenTitle.text = "Privacy"
            imgVwTitle.image = UIImage(named: "privacy2")
        }else if type == "about"{
            lblScreenTitle.text = "About"
            imgVwTitle.image = UIImage(named: "about2")
        }else{
            //help
            lblScreenTitle.text = "Help"
            imgVwTitle.image = UIImage(named: "help2")
        }
        // Group content into sections and rows
                var currentSection = ""
                var sectionItems = [ContentPolicies]()
                
                for content in arrContent {
                    if currentSection != content.title {
                        if !sectionItems.isEmpty {
                            arrRow.append(sectionItems)
                        }
                        arrSection.append(content.title ?? "")
                        sectionItems = [content]
                        currentSection = content.title ?? ""
                    } else {
                        sectionItems.append(content)
                    }
                }
                
                if !sectionItems.isEmpty {
                    arrRow.append(sectionItems) // Append the last section's rows
                }

                self.tblVwList.reloadData()
    }
    
    @IBAction func actionBAck(_ sender: UIButton) {
        SceneDelegate().notificationsRoot(selectTab: 2)
        
    }
}
extension PolicyAndAboutVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrSection.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableCell(withIdentifier: "PolicySectionTVC") as? PolicySectionTVC else {
            return nil
        }
        header.lblSection.text = arrSection[section]
        if traitCollection.userInterfaceStyle == .dark {
            header.lblSection.textColor = .white
            header.contentView.backgroundColor = .clear
        }else{
            header.lblSection.textColor = .black
            header.contentView.backgroundColor = .white

        }

        return header.contentView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRow[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PolicyTVC", for: indexPath) as? PolicyTVC else {
            return UITableViewCell()
        }
        cell.lblTitle.text = arrRow[indexPath.section][indexPath.row].description ?? ""
        if traitCollection.userInterfaceStyle == .dark {
            cell.lblTitle.textColor = .white
            cell.contentView.backgroundColor = .clear
        }else{
            cell.lblTitle.textColor = .black
            cell.contentView.backgroundColor = .white
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
