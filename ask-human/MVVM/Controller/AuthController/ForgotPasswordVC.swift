//
//  ForgotPasswordVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 07/12/23.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var viewPasswrd: UIView!
    @IBOutlet var lblTitleScreen: UILabel!
    @IBOutlet var lblForgotPasswrd: UILabel!
    @IBOutlet var imgVwTitle: UIImageView!
    @IBOutlet weak var txtFldEmailPhone: UITextField!
    var viewModel = AuthVM()
    
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
        uiSet()
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                uiSet()
            }
        }
    func uiSet(){
        if traitCollection.userInterfaceStyle == .dark {
            
            btnBack.setImage(UIImage(named: "keyboard-backspace25"), for: .normal)
            viewPasswrd.borderWid = 1
            viewPasswrd.borderCol = .white
            viewPasswrd.layer.cornerRadius = 24
            
            imgVwTitle.image = UIImage(named: "askhumanicondark")
            lblForgotPasswrd.textColor = .white
            lblTitleScreen.textColor = .white
            let placeholderColor = UIColor(red: 199/255, green: 199/255, blue: 199/255, alpha: 1.0)
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: placeholderColor
            ]
            txtFldEmailPhone.attributedPlaceholder = NSAttributedString(string: "Enter your Email", attributes: attributes)
            txtFldEmailPhone.textColor = .white
                } else {
                    btnBack.setImage(UIImage(named: "back"), for: .normal)
                    viewPasswrd.borderWid = 1
                    viewPasswrd.borderCol = UIColor(red: 156/255, green: 156/255, blue: 156/255, alpha: 1.0)
                    viewPasswrd.layer.cornerRadius = 24
                    
                    txtFldEmailPhone.textColor = .black
                    lblForgotPasswrd.textColor = .black
                    lblTitleScreen.textColor = UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1.0)
                    imgVwTitle.image = UIImage(named: "askhumaniconlight")
                    let placeholderColor = UIColor.placeholder
                    let attributes: [NSAttributedString.Key: Any] = [
                        .foregroundColor: placeholderColor
                    ]
                    txtFldEmailPhone.attributedPlaceholder = NSAttributedString(string: "Enter your Email", attributes: attributes)
                }
    }
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func acionSendCode(_ sender: GradientButton) {
        if txtFldEmailPhone.text != ""{
            
            viewModel.forgotPasswordApi(emailOrPhone: txtFldEmailPhone.text ?? "") { data,message in
                showSwiftyAlert("", "Enter otp: \(data?.otp ?? "")", true)
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "OtpVerificationPasswordVC") as! OtpVerificationPasswordVC
                vc.emailOrPhone = self.txtFldEmailPhone.text ?? ""
                self.navigationController?.pushViewController(vc, animated:true)
            }
            
            
        }else{
            showSwiftyAlert("", "Enter your email", false)
        }
        
    }
}
