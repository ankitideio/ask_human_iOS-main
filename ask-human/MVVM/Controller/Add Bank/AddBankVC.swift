//
//  AddBankVC.swift
//  ask-human
//
//  Created by Ideio Soft on 02/09/24.
//

import UIKit

class AddBankVC: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet var lblDefault: UILabel!
    @IBOutlet var lblTitleId: UILabel!
    @IBOutlet var btnDefault: UISwitch!
    @IBOutlet var txtFldIdNumber: UITextField!
    @IBOutlet weak var lblAddBank: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblRoutingNumber: UILabel!
    @IBOutlet weak var lblAccountNumber: UILabel!
    @IBOutlet weak var lblHolderName: UILabel!
    @IBOutlet weak var txtFldRoutingNumber: UITextField!
    @IBOutlet weak var txtFldAccountNumber: UITextField!
    @IBOutlet weak var txtFldHolderName: UITextField!
    
    var isDefault = "false"
    var bankId = ""
    var viewModel = WalletVM()
    var bankListcount = 0
    //MARK: - LIFE CYCLE METHOD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtFldHolderName.delegate = self
       darkMode()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            darkMode()
        }
    }
    
    //MARK: - FUNCTIONS
    
    func darkMode(){
        if traitCollection.userInterfaceStyle == .dark {
            
            let placeholderColor = UIColor(red: 199/255, green: 199/255, blue: 199/255, alpha: 1.0)
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: placeholderColor
            ]
            txtFldHolderName.attributedPlaceholder = NSAttributedString(string: "Holder name", attributes: attributes)
            txtFldAccountNumber.attributedPlaceholder = NSAttributedString(string: "Account number", attributes: attributes)
            txtFldRoutingNumber.attributedPlaceholder = NSAttributedString(string: "Routing Number", attributes: attributes)
            txtFldIdNumber.attributedPlaceholder = NSAttributedString(string: "Id Number", attributes: attributes)
            
            btnBack.setImage(UIImage(named: "keyboard-backspace25"), for: .normal)
            
            let labels = [
                lblHolderName, lblAccountNumber, lblRoutingNumber,lblAddBank,lblDefault,lblTitleId
            ]

            for label in labels {
                label?.textColor = .white
            }
            
            let textFields = [
                txtFldHolderName, txtFldAccountNumber, txtFldRoutingNumber,txtFldIdNumber
            ]
       
            for textField in textFields {
                textField?.textColor = .white
                textField?.layer.borderColor = UIColor.white.cgColor
                textField?.layer.borderWidth = 1.0
                textField?.layer.cornerRadius = 5.0
            }
            
            
        }else{
          
            let placeholderColor = UIColor(red: 72/255, green: 72/255, blue: 72/255, alpha: 1.0)
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: placeholderColor
            ]
            txtFldHolderName.attributedPlaceholder = NSAttributedString(string: "Holder name", attributes: attributes)
            txtFldAccountNumber.attributedPlaceholder = NSAttributedString(string: "Account number", attributes: attributes)
            txtFldRoutingNumber.attributedPlaceholder = NSAttributedString(string: "Routing Number", attributes: attributes)
            txtFldIdNumber.attributedPlaceholder = NSAttributedString(string: "Id Number", attributes: attributes)
         
            btnBack.setImage(UIImage(named: "back"), for: .normal)
            let labels = [
                lblHolderName, lblAccountNumber, lblRoutingNumber,lblAddBank,lblDefault,lblTitleId
            ]

            for label in labels {
                label?.textColor = .black
            }
            let textFields = [
                txtFldHolderName, txtFldAccountNumber, txtFldRoutingNumber,txtFldIdNumber
            ]

            for textField in textFields {
                textField?.textColor = .black
                textField?.layer.borderColor = UIColor(hex: "#DCDCDC").cgColor
                textField?.layer.borderWidth = 1.0
                textField?.layer.cornerRadius = 5.0
            }
            
        }
    }
    
    //MARK: - ACTIONS
    
    @IBAction func actionDefault(_ sender: UISwitch) {
        if bankListcount > 0{
            
            if sender.isOn == true{
                isDefault = "true"
            }else{
                isDefault = "false"
            }
            
        }else{
            
            isDefault = "false"
        }
        
       
    }
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionSubmit(_ sender: GradientButton) {
      
        
        if txtFldHolderName.text?.trimWhiteSpace == ""{
            showSwiftyAlert("", "Enter holder name", false)
        }else if txtFldAccountNumber.text?.trimWhiteSpace == "" {
            showSwiftyAlert("", "Enter account number", false)
        }else if txtFldRoutingNumber.text?.trimWhiteSpace == "" {
            showSwiftyAlert("", "Enter routing number", false)
        }else if txtFldIdNumber.text?.trimWhiteSpace == "" {
            showSwiftyAlert("", "Enter id number", false)
        }else{
            
            let bankDetails = BankDetaill(
                bankId: bankId,
                country: "US",
                currency: "USD",
                accountHolderName: txtFldHolderName.text ?? "",
                accountHolderType: "individual",
                routingNumber: txtFldRoutingNumber.text ?? "",
                accountNumber: txtFldAccountNumber.text ?? "",
                idNumber: txtFldIdNumber.text ?? "",
                isDefault: isDefault
            )
            
                viewModel.addBankApi(bankAccountDetails: bankDetails) { message in
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
                    vc.modalPresentationStyle = .overFullScreen
                    vc.isComing = false
                    vc.message = message ?? ""
                    vc.callBack = {
                        self.navigationController?.popViewController(animated: true)
                    }
                    self.navigationController?.present(vc, animated: false)
                
            }
        }
    }
    
 
}
extension AddBankVC:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtFldHolderName {
            // Allow only a-z and A-Z
            let allowedCharacters = CharacterSet.letters
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }

}
