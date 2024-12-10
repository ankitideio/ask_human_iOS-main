//
//  ChangePasswordVC.swift
//  ask-human
//
//  Created by meet sharma on 16/11/23.
//

import UIKit

class ChangePasswordVC: UIViewController {
    
    //MARK: - OUTLETS
    
    @IBOutlet var lblScreenTitle: UILabel!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet weak var txtFldConfirm: UITextField!
    @IBOutlet weak var txtFldNew: UITextField!
    @IBOutlet weak var txtFldCurrent: UITextField!
    
    var callBack:((_ index:Int)->())?
    var viewModel = ProfileVM()
    //MARK: - LIFE CYCLE METHOD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardWhileClick))
                      tapGesture.cancelsTouchesInView = false
                      view.addGestureRecognizer(tapGesture)
           }
           @objc func dismissKeyboardWhileClick() {
                  view.endEditing(true)
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
    func darkMode(){
        if traitCollection.userInterfaceStyle == .dark {
            
            btnBack.setImage(UIImage(named: "keyboard-backspace25"), for: .normal)
            lblScreenTitle.textColor = .white
            let placeholderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6)
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: placeholderColor
            ]
            txtFldNew.attributedPlaceholder = NSAttributedString(string: "New password", attributes: attributes)
            txtFldConfirm.attributedPlaceholder = NSAttributedString(string: "Confirm password", attributes: attributes)
            txtFldCurrent.attributedPlaceholder = NSAttributedString(string: "Current password", attributes: attributes)
            let textFields = [
                txtFldNew,txtFldConfirm,txtFldCurrent
            ]

            for textField in textFields {
                textField?.textColor = .white
               
            }
        }else{
            btnBack.setImage(UIImage(named: "back"), for: .normal)
            lblScreenTitle.textColor = .black
            let placeholderColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.6)
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: placeholderColor
            ]
            txtFldNew.attributedPlaceholder = NSAttributedString(string: "New password", attributes: attributes)
            txtFldConfirm.attributedPlaceholder = NSAttributedString(string: "Confirm password", attributes: attributes)
            txtFldCurrent.attributedPlaceholder = NSAttributedString(string: "Current password", attributes: attributes)
            let textFields = [
                txtFldNew,txtFldConfirm,txtFldCurrent
            ]

            for textField in textFields {
                textField?.textColor = .black
               
            }
        }
        }
    //MARK: - ACTIONS
    
    @IBAction func actionCurrent(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true{
            sender.setImage(UIImage(named: "eye-solid 126"), for: .normal)
            txtFldCurrent.isSecureTextEntry = false
        }else{
            sender.setImage(UIImage(named: "eye-slash-solid 125"), for: .normal)
            txtFldCurrent.isSecureTextEntry = true
        }
    }
    @IBAction func actionNew(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true{
            sender.setImage(UIImage(named: "eye-solid 126"), for: .normal)
            txtFldNew.isSecureTextEntry = false
        }else{
            sender.setImage(UIImage(named: "eye-slash-solid 125"), for: .normal)
            txtFldNew.isSecureTextEntry = true
        }
    }
    @IBAction func actionConfirm(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true{
            sender.setImage(UIImage(named: "eye-solid 126"), for: .normal)
            txtFldConfirm.isSecureTextEntry = false
        }else{
            sender.setImage(UIImage(named: "eye-slash-solid 125"), for: .normal)
            txtFldConfirm.isSecureTextEntry = true
        }
    }
    @IBAction func actionBack(_ sender: UIButton) {
        
        SceneDelegate().tabBarProfileVCRoot()
        
    }
    
    
   
    @IBAction func actionSubmit(_ sender: GradientButton) {
        
        if txtFldCurrent.text == ""{
            
            showSwiftyAlert("", "Please enter your current password.", false)
            
        }else if txtFldNew.text == ""{
            
            showSwiftyAlert("", "Please enter your new password.", false)
            
        }else if txtFldNew.text?.count ?? 0 < 6{
            
            showSwiftyAlert("", "Password must be at least 6 characters long.", false)
            
        }else if !isValidPassword(txtFldNew.text ?? ""){
            
            showSwiftyAlert("", "Password must be at least one uppercase letter, one lowercase letter, one digit, and one special character", false)
            
        }else if txtFldConfirm.text == ""{
            
            showSwiftyAlert("", "Please enter your confirm password.", false)
            
        }else if txtFldNew.text != txtFldConfirm.text{
            
            showSwiftyAlert("", "Password do not match.", false)
            
        }else{
            
            viewModel.changePasswordApi(oldPassword: txtFldCurrent.text ?? "", newPassword: txtFldNew.text ?? "", confirmPassword: txtFldConfirm.text ?? "") { data in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
                vc.modalPresentationStyle = .overFullScreen
                vc.message = data?.message ?? ""
                vc.callBack = {
                    SceneDelegate().tabBarProfileVCRoot()
                }
                self.navigationController?.present(vc, animated: true)
               
                
            }
        }
    }
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$&*]).{6,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }

}
extension ChangePasswordVC:UITextFieldDelegate{
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            switch textField {
            case txtFldCurrent:
                txtFldNew.becomeFirstResponder()
            case txtFldNew:
                txtFldConfirm.becomeFirstResponder()
            
            default:
                break
            }
            textField.resignFirstResponder()
            return true
        }
}
