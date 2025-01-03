//
//  LoginVC.swift
//  ask-human
//
//  Created by meet sharma on 15/11/23.
//

import UIKit
import AuthenticationServices
import GoogleSignInSwift

class LoginVC: UIViewController {
    
    //MARK: - OUTLETS
    
    @IBOutlet var viewPasswrd: UIView!
    @IBOutlet var viewEmail: UIView!
    @IBOutlet var btnSigninApple: UIButton!
    @IBOutlet var lblDontHaveAccount: UILabel!
    @IBOutlet var btnForgotPasswrd: UIButton!
    @IBOutlet var lblWelcome: UILabel!
    @IBOutlet var imgVwtitle: UIImageView!
    @IBOutlet weak var txtFldEmail: UITextField!
    @IBOutlet weak var txtFldPassword: UITextField!
    
    //MARK: - VARIABLES
    var viewModel = AuthVM()
    var email = ""
    var userName = ""
    //MARK: - LIFE CYCLE METHOD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GoogleSignIn.shared.delegate = self
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
            viewEmail.borderWid = 1
            viewEmail.borderCol = .white
            viewEmail.layer.cornerRadius = 24
            
            viewPasswrd.borderWid = 1
            viewPasswrd.borderCol = .white
            viewPasswrd.layer.cornerRadius = 24
            
            btnSigninApple.borderWid = 1
            btnSigninApple.borderCol = .white
            btnSigninApple.cornerRadi = 24
            imgVwtitle.image = UIImage(named: "askhumanicondark")
            lblDontHaveAccount.textColor = .white
            lblWelcome.textColor = .white
            lblDontHaveAccount.textColor = .white
            btnForgotPasswrd.setTitleColor(.white, for: .normal)
           
                   let placeholderColor = UIColor(red: 199/255, green: 199/255, blue: 199/255, alpha: 1.0)
                   let attributes: [NSAttributedString.Key: Any] = [
                       .foregroundColor: placeholderColor
                   ]
                   txtFldEmail.attributedPlaceholder = NSAttributedString(string: "Enter your Email or Phone", attributes: attributes)
            txtFldPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: attributes)
            txtFldPassword.textColor = .white
            txtFldEmail.textColor = .white
                } else {
                    viewEmail.borderWid = 1
                    viewEmail.borderCol = UIColor(red: 156/255, green: 156/255, blue: 156/255, alpha: 1.0)
                    viewEmail.layer.cornerRadius = 24
                    
                    viewPasswrd.borderWid = 1
                    viewPasswrd.borderCol = UIColor(red: 156/255, green: 156/255, blue: 156/255, alpha: 1.0)
                    viewPasswrd.layer.cornerRadius = 24
                    
                    txtFldPassword.textColor = .black
                    txtFldEmail.textColor = .black
                    btnForgotPasswrd.setTitleColor(UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1.0), for: .normal)
                    lblWelcome.textColor = UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1.0)
                    lblDontHaveAccount.textColor = UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1.0)
                    imgVwtitle.image = UIImage(named: "askhumaniconlight")
                    lblDontHaveAccount.textColor = UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1.0)
                    btnSigninApple.borderWid = 0
                    btnSigninApple.borderCol = .black
                    let placeholderColor = UIColor.placeholder
                    let attributes: [NSAttributedString.Key: Any] = [
                        .foregroundColor: placeholderColor
                    ]
                    txtFldEmail.attributedPlaceholder = NSAttributedString(string: "Enter your Email or Phone", attributes: attributes)
                    txtFldPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: attributes)
                }
    }
    //MARK: - ACTIONS
    
    @IBAction func actionEye(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true{
            sender.setImage(UIImage(named: "eye-solid 126"), for: .normal)
            txtFldPassword.isSecureTextEntry = false
        }else{
            sender.setImage(UIImage(named: "eye-slash-solid 125"), for: .normal)
            txtFldPassword.isSecureTextEntry = true
        }
    }
    @IBAction func actionBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func actionForgotPassword(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(vc, animated:true)
    }
    @IBAction func actionLogin(_ sender: GradientButton) {
        
        guard let emailOrPhone = txtFldEmail.text, !emailOrPhone.isEmpty else {
            showSwiftyAlert("", "Please enter your email or phone.", false)
            return
        }
        
        if txtFldEmail.isValidEmail(txtFldEmail.text ?? "") || isValidPhoneNumber(emailOrPhone) {
            if txtFldPassword.text == "" {
                showSwiftyAlert("", "Please enter your password.", false)
            } else{
                
                viewModel.logInApi(email: txtFldEmail.text ?? "",
                                   password: txtFldPassword.text ?? "",
                                   fcmToken: Store.deviceToken ?? "") {  data in
                    print("Store.authKe:--\(Store.authKey ?? "")")
                   
                    Store.isSocialLogin = false
               
//                    Store.authKey = data?.token ?? ""
                    if data?.mobileOtp != ""{
                        
                        showSwiftyAlert("", "Enter otp: \(data?.mobileOtp ?? "")", true)
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OtpVC") as! OtpVC
                        Store.comingOtp = 0
                        vc.mobileNo = data?.mobile ?? 0
                        self.navigationController?.pushViewController(vc, animated:true)
                        
                    }else{
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewTabBarVC") as! NewTabBarVC
                        Store.autoLogin = "true"
                        vc.isComing = false
                        Store.selectTabIndex = 1
                        self.navigationController?.pushViewController(vc, animated:true)

//                        if data?.user?.profileComplete == 0{
//                            
//                            let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "ProfileDetailVC") as! ProfileDetailVC
//                            vc2.isComing = 0
//                            self.navigationController?.pushViewController(vc2, animated:true)
//                            
//                        }else{
                            
//                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewTabBarVC") as! NewTabBarVC
//                            Store.autoLogin = "true"
//                            vc.isComing = false
//                            Store.selectTabIndex = 1
//                            self.navigationController?.pushViewController(vc, animated:true)
                            
                        //}
                    }
                }
            }
        }else {
            showSwiftyAlert("", "Enter valid email.", false)
        }
    }
   

    // Helper function to validate phone number
    func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
     
        let numericCharacterSet = CharacterSet.decimalDigits
        return phoneNumber.rangeOfCharacter(from: numericCharacterSet.inverted) == nil
        
    }
    @IBAction func actionSignUp(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        
        self.navigationController?.pushViewController(vc, animated:true)
    }
    
    @IBAction func actionSignInGoogle(_ sender: UIButton) {
        GoogleSignIn.shared.email = true
        GoogleSignIn.shared.presentingWindow = view.window
        GoogleSignIn.shared.signIn()
    }
    
    @IBAction func actionSignInApple(_ sender: UIButton) {
        self.setupSOAppleSignIn()
    }
    func setupSOAppleSignIn() {

           actionHandleAppleSignin()

       }

   func actionHandleAppleSignin() {

           let appleIDProvider = ASAuthorizationAppleIDProvider()

           let request = appleIDProvider.createRequest()

       request.requestedScopes = [.fullName, .email]

           let authorizationController = ASAuthorizationController(authorizationRequests: [request])

           authorizationController.delegate = self

           authorizationController.presentationContextProvider = self

           authorizationController.performRequests()

       }
    
}
extension LoginVC:UITextFieldDelegate{

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case txtFldEmail:
            txtFldPassword.becomeFirstResponder()
        default:
            break
        }
        textField.resignFirstResponder()
        return true
    }
    
}

extension LoginVC: ASAuthorizationControllerDelegate {
    
    // ASAuthorizationControllerDelegate function for authorization failed
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
        print(error.localizedDescription)
        
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            // Create an account as per your requirement
            
            let appleId = appleIDCredential.user
            
            _ = appleIDCredential.fullName?.namePrefix ?? ""
            let appleUserFirstName = appleIDCredential.fullName?.givenName
            
            let appleUserLastName = appleIDCredential.fullName?.familyName
            
            let appleUserEmail = appleIDCredential.email
           
            DispatchQueue.main.asyncAfter(deadline: .now()){
                self.viewModel.socialaAuthApi(socialId: appleId, socialType: "apple", email: appleUserEmail ?? "", fcmToken: Store.deviceToken ?? "") { data in
                    Store.authKey = data?.token ?? ""
                    Store.isSocialLogin = true
                    
                    if data?.user?.profileComplete == 0{
                        
                        let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "SocialLoginDetailsVC") as! SocialLoginDetailsVC
                        vc2.userName = (appleUserFirstName ?? "") + (appleUserLastName ?? "")
                        self.navigationController?.pushViewController(vc2, animated:true)
                        
                    }else{
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewTabBarVC") as! NewTabBarVC
                        Store.autoLogin = "true"
                        vc.isComing = false
                        Store.selectTabIndex = 1
                        self.navigationController?.pushViewController(vc, animated:true)
                        
                    }

                }
            }
            
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            
            let appleUsername = passwordCredential.user
            
            let applePassword = passwordCredential.password
            print(appleUsername,"UserName-------")
            //Write your code
            
        }
        
    }
}

extension LoginVC: ASAuthorizationControllerPresentationContextProviding {

    //For present window

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {

        return self.view.window!

    }

}
extension LoginVC: GoogleSignInDelegate {
    func googleSignIn(didSignIn auth: GoogleSignIn.Auth?, user: GoogleSignIn.User?, error: Error?) {
           print(user)
            
            if let email = user?.email {
                DispatchQueue.main.asyncAfter(deadline: .now()){
                    self.viewModel.socialaAuthApi(socialId: user?.id ?? "", socialType: "google", email: user?.email ?? "", fcmToken: Store.deviceToken ?? "") { data in
                        Store.isSocialLogin = true
                        Store.authKey = data?.token ?? ""
                        if data?.user?.profileComplete == 0{
                            
                            let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "SocialLoginDetailsVC") as! SocialLoginDetailsVC
                            vc2.userName = user?.name ?? ""
                            self.navigationController?.pushViewController(vc2, animated:true)
                            
                        }else{
                            
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewTabBarVC") as! NewTabBarVC
                            Store.autoLogin = "true"
                            vc.isComing = false
                            Store.selectTabIndex = 1
                            self.navigationController?.pushViewController(vc, animated:true)
                            
                        }
                    }
                }
              
                
            } else {
                print("Google User Email not available")
            }
        
    }
}
