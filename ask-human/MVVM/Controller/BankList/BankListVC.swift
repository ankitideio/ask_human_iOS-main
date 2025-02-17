//
//  BankListVC.swift
//  ask-human
//
//  Created by Ideio Soft on 04/09/24.
//

import UIKit

class BankListVC: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var lblNoData: UILabel!
    @IBOutlet weak var tblVwBankList: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblAddBank: UILabel!
    
    //MARK: - variables
    var arrBank = [BankData]()
    var viewModel = WalletVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        uiSet()
    }
    override func viewWillAppear(_ animated: Bool) {
        getBankDetails()
    }
    func getBankDetails(){
        viewModel.getBankDetailsApi(loader: true) { data in
            self.arrBank = data?.data ?? []
            if self.arrBank.count > 0{
                self.lblNoData.isHidden = true
            }else{
                self.lblNoData.isHidden = false
            }
            self.tblVwBankList.reloadData()
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            darkMode()
        }
    }
    
    //MARK: - FUNCTIONS
    
    func uiSet(){
        tblVwBankList.estimatedRowHeight = 50
        tblVwBankList.rowHeight = UITableView.automaticDimension
        darkMode()
    }

    func darkMode(){
        if traitCollection.userInterfaceStyle == .dark {
            btnBack.setImage(UIImage(named: "keyboard-backspace25"), for: .normal)
            
            let labels = [
                lblAddBank
            ]
            for label in labels {
                label?.textColor = .white
            }
        }else{
            btnBack.setImage(UIImage(named: "back"), for: .normal)
            let labels = [
               lblAddBank
            ]
            for label in labels {
                label?.textColor = .black
            }
        }
    }
    //MARK: - IBAction
    @IBAction func actionBack(_ sender: UIButton) {
        SceneDelegate().tabBarProfileVCRoot()
    }
    
    @IBAction func actionAddBank(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddBankVC") as! AddBankVC
        vc.bankListcount = arrBank.count
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
//MARK: - UITableViewDelegate
extension BankListVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrBank.count > 0{
            return arrBank.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BankListTVC", for: indexPath) as! BankListTVC
       
        if traitCollection.userInterfaceStyle == .dark {
            cell.vwShadow.addTopShadow(shadowColor: .white, shadowOpacity: 1.0, shadowRadius: 5, offset: CGSize(width: 2, height: 2))
            let labels = [
                cell.lblBank,cell.lblBankName,cell.lblAccount,cell.lblAccountNumber,cell.lblRouting,cell.lblRoutingNumber
            ]

            for label in labels {
                label?.textColor = .white
            }
            let labels2 = [
                cell.lblBank,cell.lblAccount,cell.lblRouting
            ]

            for label in labels2 {
                label?.textColor = .gray
            }

        }else{
            cell.vwShadow.addTopShadow(shadowColor: .lightGray, shadowOpacity: 1.0, shadowRadius: 5, offset: CGSize(width: 2, height: 2))
            let labels = [
                cell.lblBankName,cell.lblAccountNumber,cell.lblRoutingNumber
            ]

            for label in labels {
                label?.textColor = .black
            }
            let labels2 = [
                cell.lblBank,cell.lblAccount,cell.lblRouting
            ]

            for label in labels2 {
                label?.textColor = .gray
            }
        }
        if arrBank.count > 0{
            cell.btnDefault.tag = indexPath.row
            cell.btnDefault.addTarget(self, action: #selector(actionDefault), for: .touchUpInside)
            cell.btnDelete.tag = indexPath.row
            cell.btnDelete.addTarget(self, action: #selector(actionDelete), for: .touchUpInside)
            cell.lblBankName.text = arrBank[indexPath.row].bankName ?? ""
            cell.lblAccountNumber.text = "********\(arrBank[indexPath.row].last4 ?? "")"
            cell.lblRoutingNumber.text = arrBank[indexPath.row].routingNumber ?? ""
            if arrBank[indexPath.row].defaultForCurrency == true{
                cell.btnDelete.isHidden = true
                cell.btnDefault.isSelected = true
            }else{
                cell.btnDelete.isHidden = false
                cell.btnDefault.isSelected = false
            }
        }
        return cell
        
    }
    @objc func actionDefault(sender:UIButton){
        if arrBank[sender.tag].defaultForCurrency == false{
            viewModel.DefaultBankApi(bankAccountId: arrBank[sender.tag].id ?? ""){ message in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
                vc.modalPresentationStyle = .overFullScreen
                vc.isComing = false
                vc.message = message ?? ""
                vc.callBack = {
                    self.getBankDetails()
                }
                self.navigationController?.present(vc, animated: false)
            }
        }
    }
    
    @objc func actionDelete(sender:UIButton){
       
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MessageAcceptPopUpVC") as! MessageAcceptPopUpVC
        vc.status = "bank"
        vc.bankId = arrBank[sender.tag].id ?? ""
        vc.modalPresentationStyle = .overFullScreen
        vc.callBackReject = { message in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
            vc.modalPresentationStyle = .overFullScreen
            vc.isComing = false
            vc.message = message
            vc.callBack = {
                self.getBankDetails()
            }
            self.navigationController?.present(vc, animated: false)
            
        }
            self.navigationController?.present(vc, animated: false)
        
    }
}
