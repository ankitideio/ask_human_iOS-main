//
//  AddNewEmailVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 19/12/23.
//

import UIKit

class AddNewEmailVC: UIViewController {
    @IBOutlet var viewBackTxtfld: UIView!
    @IBOutlet var lblTitleMessage: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var imgVwTitle: UIImageView!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var txtFldEmail: UITextField!
    var email = ""
    var viewModel = ProfileVM()
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
            viewBackTxtfld.borderCol = UIColor(hex: "#D9D9D9")
            viewBackTxtfld.borderWid = 1
            btnBack.setImage(UIImage(named: "keyboard-backspace25"), for: .normal)
            imgVwTitle.image = UIImage(named: "askhumanicondark")
            lblTitle.textColor = .white
            lblTitleMessage.textColor = .white
            let placeholderColor = UIColor(hex: "#CBCBCB")
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: placeholderColor
            ]
            txtFldEmail.attributedPlaceholder = NSAttributedString(string: "Enter your new email", attributes: attributes)
            txtFldEmail.textColor = .white
        }else{
            viewBackTxtfld.borderCol = UIColor(hex: "#9C9C9C")
            viewBackTxtfld.borderWid = 1
            btnBack.setImage(UIImage(named: "back"), for: .normal)
            imgVwTitle.image = UIImage(named: "askhumaniconlight")
            lblTitle.textColor =  UIColor(hex: "#303030")
            lblTitleMessage.textColor =  UIColor(hex: "#4C4C4C")
            let placeholderColor = UIColor.placeholder
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: placeholderColor
            ]
            txtFldEmail.attributedPlaceholder = NSAttributedString(string: "Enter your new email", attributes: attributes)
            txtFldEmail.textColor = .black
            
        }
        }
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionSendCode(_ sender: GradientButton) {
        if txtFldEmail.text == ""{
            showSwiftyAlert("", "Please enter your email", false)
        }else if txtFldEmail.isValidEmail(txtFldEmail.text ?? "") == false{
            showSwiftyAlert("", "Please enter a valid email", false)
        }else{
            
            viewModel.changeEmailApi(email: txtFldEmail.text ?? "") { message in
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
                vc.modalPresentationStyle = .overFullScreen
                Store.comingOtp = 2
                vc.message = message ?? ""
                vc.callBack = {
                    Store.authKey = ""
                    Store.autoLogin = "false"
                    SceneDelegate().loginVCRoot()
                    
                }
                self.navigationController?.present(vc, animated: false)
                
               
                
            }
        }
    }
    

}
