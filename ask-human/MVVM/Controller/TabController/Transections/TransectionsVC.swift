//
//  TransectionsVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 11/01/24.
//

import UIKit

class TransectionsVC: UIViewController {

    @IBOutlet var lblScreenTitle: UILabel!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var lblNoData: UILabel!
    @IBOutlet var tblVwHistory: UITableView!
    var arrHistory = [TransactionList]()
    var viewModel = ProfileVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        tblVwHistory.showsVerticalScrollIndicator = false
        uiSet()
    }
    override func viewWillAppear(_ animated: Bool) {
            darkMode()
        }
        override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                darkMode()
                tblVwHistory.reloadData()
            }
            
        }
        func darkMode(){
            if traitCollection.userInterfaceStyle == .dark {
                lblNoData.textColor = .white
                btnBack.setImage(UIImage(named: "keyboard-backspace25"), for: .normal)
                lblScreenTitle.textColor = .white
            }else{
                lblNoData.textColor = UIColor(hex: "#6F7179")
                btnBack.setImage(UIImage(named: "back"), for: .normal)
                lblScreenTitle.textColor = .black
            }
            }
        

    func uiSet(){
        historyApi()
    }
    func historyApi(){
        viewModel.transactionHistoryApi{ data in
            
            self.arrHistory = data ?? []
            if self.arrHistory.count > 0{
                self.lblNoData.isHidden = true
            }else{
                self.lblNoData.isHidden = false
            }
            self.tblVwHistory.reloadData()
        }
    }
    @IBAction func actionBack(_ sender: UIButton) {
        SceneDelegate().tabBarProfileVCRoot()
    }
    
}
//MARK: - TABLEVIEW DELEGATE AND DATASOURCE

extension TransectionsVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransectionTVC", for: indexPath) as! TransectionTVC
        if traitCollection.userInterfaceStyle == .dark {
            cell.lblTransectiontype.textColor = .white
            cell.lblDate.textColor = .white
        }else{
            cell.lblTransectiontype.textColor = .black
            cell.lblDate.textColor = UIColor(hex: "#878787")
        }
        if arrHistory[indexPath.row].type ?? "" == "Add"{
            cell.lblTransectiontype.text = "Added"
        }else{
            cell.lblTransectiontype.text = arrHistory[indexPath.row].type ?? ""
        }
        
        if arrHistory[indexPath.row].type == "Add" || arrHistory[indexPath.row].type == "Earning" || arrHistory[indexPath.row].type == "Refund Amount"{
//            cell.lblTransectiontype.text = "Added"
            cell.imgVwWithdraw.image = UIImage(named: "Added")
            cell.lblPrice.textColor = #colorLiteral(red: 0, green: 0.75, blue: 0.0745, alpha: 1)
            cell.lblPrice.text = "$\(arrHistory[indexPath.row].ammount ?? 0)"
            
            let dateString = arrHistory[indexPath.row].createdAt ?? ""
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            if let date = dateFormatter.date(from: dateString) {
                dateFormatter.dateFormat = "MMM dd yyyy hh:mm a"
                let formattedString = dateFormatter.string(from: date)
                print("Formatted Date and Time: \(formattedString)")
                cell.lblDate.text = formattedString
            }
           
        }else{
//            cell.lblTransectiontype.text = "Withdrawal"
            
            cell.imgVwWithdraw.image = UIImage(named: "withdrawal")
            cell.lblPrice.textColor = #colorLiteral(red: 1, green: 0.1137254902, blue: 0.1137254902, alpha: 1)
            cell.lblPrice.text = "$\(arrHistory[indexPath.row].ammount ?? 0)"
            let dateString = arrHistory[indexPath.row].createdAt ?? ""
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            if let date = dateFormatter.date(from: dateString) {
                dateFormatter.dateFormat = "MMM dd yyyy hh:mm a"
                let formattedString = dateFormatter.string(from: date)
                print("Formatted Date and Time: \(formattedString)")
                cell.lblDate.text = formattedString
            }
        }
        
        return cell
    }
    
    
}
