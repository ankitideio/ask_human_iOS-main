//
//  FilterOptionsVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 09/01/25.
//

import UIKit

class FilterOptionsVC: UIViewController {

    @IBOutlet var tblVwOptions: UITableView!
    
    var callBack: ((_ indexx: Int, _ title: String,_ id:String) -> ())?
    var isSelect = 1
    var arrLanguages = [Language]()
    var arrSelectedLanguages = [String]()
    var arrSelectedEthics = [String]()
    var arrEthnic = [Ethnic]()
    var arrEthicsIds = [String]()
    var arrLanguageIds = [String]()
    var selectedEthic = ""
    var fromProfile = false
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "CommonPopoverListTVC", bundle: nil)
        tblVwOptions.register(nib, forCellReuseIdentifier: "CommonPopoverListTVC")
        // Insert "Add more" dynamically
        if isSelect == 0{
            let addMoreLanguage = Language(id: "", name: "Add more", createdAt: "", updatedAt: "", v: nil)
            arrLanguages.insert(addMoreLanguage, at: 0)
            
        }
        tblVwOptions.reloadData()
        tblVwOptions.tableFooterView = UIView()
    }
}

extension FilterOptionsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // Always one section
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSelect == 0{
            return  arrLanguages.count
        }else{
            return arrEthnic.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommonPopoverListTVC", for: indexPath) as! CommonPopoverListTVC
        var isSelected: Bool
        var title: String
        if isSelect != 1 && indexPath.row == 0 {
            // "Add more" row for Languages
            title = arrLanguages[indexPath.row].name ?? "Add more"
            cell.lblTitle.text = title
            if self.traitCollection.userInterfaceStyle == .dark {
                cell.viewBack.backgroundColor = UIColor.clear
                cell.lblTitle.textColor = UIColor.white
            }else{
                cell.viewBack.backgroundColor = UIColor.white
                cell.lblTitle.textColor = UIColor.black
            }
        } else {
            // Regular rows for Ethnic or Languages
            if isSelect == 1 {
                title = arrEthnic[indexPath.row].ethnic ?? ""
                if fromProfile{
                    if selectedEthic == title{
                        isSelected = true
                    }else{
                        isSelected = false
                    }
                    if isSelected {
                        cell.viewBack.backgroundColor = UIColor.app
                        cell.lblTitle.textColor = UIColor.white
                    } else {
                        if self.traitCollection.userInterfaceStyle == .dark {
                            cell.viewBack.backgroundColor = UIColor.clear
                            cell.lblTitle.textColor = UIColor.white
                        }else{
                            cell.viewBack.backgroundColor = UIColor.white
                            cell.lblTitle.textColor = UIColor.black
                        }
                    }

                }else{
                    isSelected = arrSelectedEthics.contains(title)
                    if isSelected {
                        cell.viewBack.backgroundColor = UIColor.app
                        cell.lblTitle.textColor = UIColor.white
                    } else {
                        if self.traitCollection.userInterfaceStyle == .dark {
                            cell.viewBack.backgroundColor = UIColor.clear
                            cell.lblTitle.textColor = UIColor.white
                        }else{
                            cell.viewBack.backgroundColor = UIColor.white
                            cell.lblTitle.textColor = UIColor.black
                        }
                    }
                }
            } else {
                title = arrLanguages[indexPath.row].name ?? ""
                isSelected = arrSelectedLanguages.contains(title)
                if isSelected {
                    cell.viewBack.backgroundColor = UIColor.app
                    cell.lblTitle.textColor = UIColor.white
                } else {
                    if self.traitCollection.userInterfaceStyle == .dark {
                        cell.viewBack.backgroundColor = UIColor.clear
                        cell.lblTitle.textColor = UIColor.white
                    }else{
                        cell.viewBack.backgroundColor = UIColor.white
                        cell.lblTitle.textColor = UIColor.black
                    }
                }

            }
            cell.lblTitle.text = title
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSelect != 1 && indexPath.row == 0 {
            // Handle "Add more" click
            print("Add more tapped")
            dismiss(animated: false)
            callBack?(indexPath.row, "Add more", "")
            return
        }

        var title: String
        var isSelected: Bool
        var arrSelected: [String]
        var arrIds: [String]
        
        
        if isSelect == 1 {
            title = arrEthnic[indexPath.row].ethnic ?? ""
            isSelected = arrSelectedEthics.contains(title)
            arrSelected = arrSelectedEthics
            arrIds = arrEthicsIds
            
        } else {
            title = arrLanguages[indexPath.row].name ?? ""
            isSelected = arrSelectedLanguages.contains(title)
            arrSelected = arrSelectedLanguages
            arrIds = arrLanguageIds
        }

        // Skip if already selected
        if isSelected {
            print("Item is already selected, skipping callback for: \(title)")
            dismiss(animated: false)
            return
        }

        // Mark the item as selected
        arrSelected.append(title)
        // Append the corresponding id
            if isSelect == 1 {
                let ethnicId = arrEthnic[indexPath.row].id ?? ""
                arrIds.append(ethnicId)
            } else {
                let languageId = arrLanguages[indexPath.row].id ?? ""
                arrIds.append(languageId)
            }
        
        // Update selection visually
        tableView.reloadRows(at: [indexPath], with: .automatic)
        dismiss(animated: false)
        // Call the callback with updated data
        callBack?(indexPath.row, title, isSelect == 1 ? arrEthnic[indexPath.row].id ?? "" : arrLanguages[indexPath.row].id ?? "")

    }
}
