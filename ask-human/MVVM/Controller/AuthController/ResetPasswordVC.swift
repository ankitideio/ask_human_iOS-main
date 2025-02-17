//
//  ResetPasswordVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 12/12/23.
//

import UIKit

class ResetPasswordVC: UIViewController {

    @IBOutlet var viewNewPasswrd: UIView!
    @IBOutlet var viewpasswrd: UIView!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var lblYourNewPasswd: UILabel!
    @IBOutlet var lblCreateNewPaswrd: UILabel!
    @IBOutlet var imgVwTitle: UIImageView!
    @IBOutlet var txtFldPassword: UITextField!
    @IBOutlet var txtFldNewPasswrd: UITextField!
    var viewModel = AuthVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        darkMode()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardWhileClick))
                      tapGesture.cancelsTouchesInView = false
                      view.addGestureRecognizer(tapGesture)
           }
           @objc func dismissKeyboardWhileClick() {
                  view.endEditing(true)
              }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                darkMode()
            }
        }
    func darkMode(){
        if traitCollection.userInterfaceStyle == .dark {
            imgVwTitle.image = UIImage(named: "askhumanicondark")
            

            btnBack.setImage(UIImage(named: "keyboard-backspace25"), for: .normal)
           
            let placeholderColor = UIColor(red: 199/255, green: 199/255, blue: 199/255, alpha: 1.0)
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: placeholderColor
            ]
     txtFldPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: attributes)
     txtFldNewPasswrd.attributedPlaceholder = NSAttributedString(string: "Confirm password", attributes: attributes)
     
            txtFldPassword.textColor = .white
            txtFldNewPasswrd.textColor = .white
            viewpasswrd.layer.borderColor = UIColor.white.cgColor
            viewNewPasswrd.layer.borderColor = UIColor.white.cgColor
            lblYourNewPasswd.textColor = .white
            lblCreateNewPaswrd.textColor = .white
        }else{
            imgVwTitle.image = UIImage(named: "askhumaniconlight")
            btnBack.setImage(UIImage(named: "back"), for: .normal)
            let placeholderColor = UIColor.placeholder
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: placeholderColor
            ]
     txtFldPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: attributes)
     txtFldNewPasswrd.attributedPlaceholder = NSAttributedString(string: "Confirm password", attributes: attributes)
     
            txtFldPassword.textColor = .black
            txtFldNewPasswrd.textColor = .black
            viewpasswrd.layer.borderColor = UIColor(hex: "#9C9C9C").cgColor
            viewNewPasswrd.layer.borderColor = UIColor(hex: "#9C9C9C").cgColor
            lblYourNewPasswd.textColor = UIColor(hex: "#4C4C4C")
            lblCreateNewPaswrd.textColor = UIColor(hex: "#303030")
        }
        }
    @IBAction func acionResetPasswrd(_ sender: GradientButton) {
        if txtFldPassword.text == ""{
            showSwiftyAlert("", "Enter your new password", false)
        }else if txtFldPassword.text?.count ?? 0 < 6 || !isValidPassword(txtFldPassword.text ?? ""){
            showSwiftyAlert("", "Password must be at least 6 characters long, and contain at least one uppercase letter, one lowercase letter, one digit, and one special character.", false)
        }else if txtFldNewPasswrd.text == ""{
            showSwiftyAlert("", "Enter your confirm password", false)
        }else if txtFldPassword.text != txtFldNewPasswrd.text{
            showSwiftyAlert("", "Your password don’t match.", false)
        }else{
        
            viewModel.setNewPasswordApi(token: Store.authKey ?? "" , password: txtFldPassword.text ?? "", confirmPassword: txtFldNewPasswrd.text ?? "") { data in
                
                showSwiftyAlert("", "Password changed successfully.", true)
                
                SceneDelegate().loginVCRoot()
            }
        }
    }
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$&*]).{6,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }


    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionEyePassword(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true{
            sender.setImage(UIImage(named: "eye-solid 126"), for: .normal)
            txtFldPassword.isSecureTextEntry = false
        }else{
            sender.setImage(UIImage(named: "eye-slash-solid 125"), for: .normal)
            txtFldPassword.isSecureTextEntry = true
        }
    }
    @IBAction func actionEyeNewPasswrd(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true{
            sender.setImage(UIImage(named: "eye-solid 126"), for: .normal)
            txtFldNewPasswrd.isSecureTextEntry = false
        }else{
            sender.setImage(UIImage(named: "eye-slash-solid 125"), for: .normal)
            txtFldNewPasswrd.isSecureTextEntry = true
        }
    }
}
