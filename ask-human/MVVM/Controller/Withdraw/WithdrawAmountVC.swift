//
//  WithdrawAmountVC.swift
//  ask-human
//
//  Created by meet sharma on 05/03/24.
//

import UIKit

class WithdrawAmountVC: UIViewController {
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var viewTextArea: UIView!
    @IBOutlet var lblHowMuch: UILabel!
    @IBOutlet weak var vwBackground: UIView!
    @IBOutlet weak var txtFldAmount: UITextField!
    
    var viewModel = EarningVM()
    var viewModelWallet = WalletVM()
    var inputAmount = 0
    var totalAmount = 0
    var callBack:((_ amount:Int)->())?
    var isComing = false
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSet()
    }
    private func uiSet(){
        let tapGestureOnTetxAreaView = UITapGestureRecognizer(target: self, action: #selector(openKeyboard))
        tapGestureOnTetxAreaView.cancelsTouchesInView = false
        viewTextArea.addGestureRecognizer(tapGestureOnTetxAreaView)
        
        txtFldAmount.adjustsFontSizeToFitWidth = false
        vwBackground.layer.cornerRadius = 40
        vwBackground.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        if isComing == true{
            //wallet
            lblTitle.text = " Add amount"
            lblHowMuch.text = "How much would you like to add"
        }else{
            //earning
            lblTitle.text = " Withdraw amount"
            lblHowMuch.text = "How much would you like to withdraw"
            
        }
    }
    @objc func openKeyboard() {
        txtFldAmount.becomeFirstResponder()
    }
    private func withdrawAmountApi(){
        viewModel.withdrawAmount(amount: txtFldAmount.text ?? "") {
            self.dismiss(animated: true)
            self.callBack?(0)
        }
    }
    @IBAction func actionCrossBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func actionProceed(_ sender: GradientButton) {
        if isComing == true{
            if txtFldAmount.text == "" {
                
                showSwiftyAlert("", "Amount cannot be empty.", false)
            } else if Int(txtFldAmount.text ?? "") ?? 0 <= 0 {
                showSwiftyAlert("", "You can request $1 amount at least.", false)
            } else {
                dismiss(animated: true)
                callBack?(Int(txtFldAmount.text ?? "") ?? 0)
            }
            
        }else{
            inputAmount = Int(txtFldAmount.text ?? "") ?? 0
            if txtFldAmount.text == "" {
                showSwiftyAlert("", "Amount cannot be empty.", false)
            }else{
                if inputAmount > 0 {
                    withdrawAmountApi()
                }else{
                    showSwiftyAlert("", "You can request $1 amount at least.", false)
                }
            }
            
        }
    }
    
}

//MARK: - UITextFieldDelegate
extension WithdrawAmountVC:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtFldAmount{
            let allowedCharacters = "0123456789"
            let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
            let typedCharacterSet = CharacterSet(charactersIn: string)
            let alphabet = allowedCharacterSet.isSuperset(of: typedCharacterSet)
            return alphabet
            
        }
        return true
    }
}
