//
//  PopUpVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 27/11/23.
//

import UIKit

class PopUpVC: UIViewController {
    //MARK: - OUTLETS
    @IBOutlet weak var tblVwPopUp: UITableView!
   
    //MARK: - VARIABLE
    var arrContract = [String]()
    var callBack:((_ selectOption:String)->())?

    var isStatus = 0

    override func viewDidLoad() {
        super.viewDidLoad()
       
        uiSet()
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            tblVwPopUp.reloadData()
        }
    }
    
    func uiSet(){
        if isStatus == 1{
            arrContract.append("Add Dispute")
            arrContract.append("End Contract")
            arrContract.append("Continue Chat")
        }else if isStatus == 2{
            arrContract.append("End Dispute")
            arrContract.append("End Contract")
        }else if isStatus == 3{
            arrContract.append("Add Dispute")
            arrContract.append("End Contract")
        }else{
            arrContract.append("Add Review")
        }
    }
    
}
//MARK: - UITableViewDelegate
extension PopUpVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return arrContract.count
     
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopUpTVC", for: indexPath) as! PopUpTVC
        if traitCollection.userInterfaceStyle == .dark {
            cell.lblName.textColor = .white
            tblVwPopUp.separatorColor = .clear
        }else{
            cell.lblName.textColor = UIColor(hex: "#838383")
            tblVwPopUp.separatorColor = UIColor(hex: "#E7E7E7")
        }
        cell.lblName.text = arrContract[indexPath.row]
        if indexPath.row == arrContract.count - 1 {
                cell.separatorInset = UIEdgeInsets(top: 0, left: cell.bounds.size.width, bottom: 0, right: 0)
            }
       
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true)
        self.callBack?(arrContract[indexPath.row])
    }
}
