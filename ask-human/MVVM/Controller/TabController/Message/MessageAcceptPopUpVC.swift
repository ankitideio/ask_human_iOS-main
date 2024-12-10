//
//  MessageAcceptPopUpVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 14/12/23.
//

import UIKit

class MessageAcceptPopUpVC: UIViewController {

    @IBOutlet var imgVwTitle: UIImageView!
    @IBOutlet var lblAlertMessage: UILabel!
    @IBOutlet weak var btnYes: GradientButton!
    @IBOutlet weak var btnNo: UIButton!
    
    var status = ""
    var viewModel = InvitationVM()
    var messageId = ""
    var callBack:(()->())?
    var callBackReject:((_ message:String)->())?
    var viewModelWallet = WalletVM()
    var bankId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        uiSet()
        darkMode()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            darkMode()
            
        }
    }
    func darkMode(){
        if traitCollection.userInterfaceStyle == .dark {
            lblAlertMessage.textColor = .white
            imgVwTitle.image = UIImage(named: "askhumanicondark")
        }else{
            
            lblAlertMessage.textColor = UIColor(hex: "#898989")
            imgVwTitle.image = UIImage(named: "askhumaniconlight")
            
            }
            }
    func uiSet(){
        if status == "reject"{
            btnNo.setTitle("No", for: .normal)
            btnYes.setTitle("Yes", for: .normal)
            lblAlertMessage.text =  "Are you sure you want to reject this invite?"
        }else if status == "accept"{
            btnNo.setTitle("No", for: .normal)
            btnYes.setTitle("Yes", for: .normal)
            lblAlertMessage.text =  "Are you sure you want to accept this invite?"
        }else if status == "endDispute"{
            btnNo.setTitle("No", for: .normal)
            btnYes.setTitle("Yes", for: .normal)
            lblAlertMessage.text =  "Are you sure you want to end this dispute?"
        }else if status == "endContract"{
            btnNo.setTitle("No", for: .normal)
            btnYes.setTitle("Yes", for: .normal)
            lblAlertMessage.text =  "Are you sure you want to end this contract?"
        }else if status == "search"{
            btnNo.setTitle("Cancel", for: .normal)
            btnYes.setTitle("Add Funds", for: .normal)
            lblAlertMessage.text =  "Are you sure you want to end this contract?"
        }else if status == "draft"{
            btnNo.setTitle("No", for: .normal)
            btnYes.setTitle("Yes", for: .normal)
            lblAlertMessage.text =  "Are you sure you want to delete this note?"
        }else if status == "bank"{
            btnNo.setTitle("No", for: .normal)
            btnYes.setTitle("Yes", for: .normal)
            lblAlertMessage.text =  "Are you sure you want to delete this bank detail?"
        }
    }
    
    @IBAction func actionCross(_ sender: UIButton) {
        self.dismiss(animated: false)
    }
    
    @IBAction func actionAccept(_ sender: GradientButton) {
        if status == "accept"{
            viewModel.acceptRejectInvitationApi(messageId:messageId, isStatus: "1") { message in
                
                self.dismiss(animated: false)
                self.callBack?()
            }
        }else if status == "reject"{
            viewModel.acceptRejectInvitationApi(messageId:messageId, isStatus: "2") { message in 
                
                self.dismiss(animated: false)
                self.callBackReject?(message ?? "")
            }
        }else if status == "endDispute"{
            self.dismiss(animated: false)
            self.callBack?()
        }else if status == "endContract"{
            self.dismiss(animated: false)
            self.callBack?()
        }else if status == "search"{
            self.dismiss(animated: false)
            self.callBack?()
        }else if status == "draft"{
            self.dismiss(animated: false)
            self.callBack?()
        }else if status == "bank"{
            viewModelWallet.DeleteBankApi(bankAccountId: bankId) { message in
                self.dismiss(animated: false)
                self.callBackReject?(message ?? "")
            }
           
        }
       
    }
    
    @IBAction func actionReject(_ sender: UIButton) {
        self.dismiss(animated: false)
//        viewModel.acceptRejectInvitationApi(messageId:messageId, isStatus: "2") {
//            
//            SceneDelegate().notificationsRoot(selectTab: 1)
//            
//            self.callBack?()
//            
//        }
    }
    
}
