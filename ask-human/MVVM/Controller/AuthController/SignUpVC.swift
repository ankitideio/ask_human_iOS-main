//
//  SignUpVC.swift
//  ask-human
//
//  Created by meet sharma on 15/11/23.
//

import UIKit
import AuthenticationServices
import GoogleSignInSwift
import CountryPickerView

class SignUpVC: UIViewController {
    
    //MARK: - OUTLETS
    
    @IBOutlet var widthCountryPickerVw: NSLayoutConstraint!
    @IBOutlet var viewCountryPicker: CountryPickerView!
    @IBOutlet var lblDontHaveAccount: UILabel!
    @IBOutlet var btnSigninApple: UIButton!
    @IBOutlet var viewConfirmPasswrd: UIView!
    @IBOutlet var viewPassword: UIView!
    @IBOutlet var viewPhone: UIView!
    @IBOutlet var viewEmail: UIView!
    @IBOutlet var lblSignup: UILabel!
    @IBOutlet var imgVwTitle: UIImageView!
    @IBOutlet weak var txtFldConfirmPassword: UITextField!
    @IBOutlet weak var txtFldPassword: UITextField!
    @IBOutlet weak var txtFldPhone: UITextField!
    @IBOutlet weak var txtFldEmail: UITextField!
    
    //MARK: - VARIABLES
    
    var viewModel = AuthVM()
    var signupDetail: SignUpData?
    let countriesPhoneNumbers: [(country: String, digits: Int)] = [
        ("Afghanistan", 9),
        ("Albania", 8),
        ("Algeria", 9),
        ("Andorra", 6),
        ("Angola", 9),
        ("Argentina", 10),
        ("Armenia", 8),
        ("Australia", 9),
        ("Austria", 10),
        ("Azerbaijan", 9),
        ("Bahamas", 7),
        ("Bahrain", 8),
        ("Bangladesh", 10),
        ("Barbados", 7),
        ("Belarus", 9),
        ("Belgium", 9),
        ("Belize", 7),
        ("Benin", 8),
        ("Bhutan", 8),
        ("Bolivia", 8),
        ("Bosnia and Herzegovina", 8),
        ("Botswana", 7),
        ("Brazil", 11),
        ("Brunei", 7),
        ("Bulgaria", 9),
        ("Burkina Faso", 8),
        ("Burundi", 8),
        ("Cabo Verde", 7),
        ("Cambodia", 9),
        ("Cameroon", 9),
        ("Canada", 10),
        ("Central African Republic", 8),
        ("Chad", 8),
        ("Chile", 9),
        ("China", 11),
        ("Colombia", 10),
        ("Comoros", 7),
        ("Congo (Republic)", 9),
        ("Congo (Democratic Republic)", 9),
        ("Costa Rica", 8),
        ("Croatia", 9),
        ("Cuba", 8),
        ("Cyprus", 8),
        ("Czech Republic", 9),
        ("Denmark", 8),
        ("Djibouti", 8),
        ("Dominica", 7),
        ("Dominican Republic", 10),
        ("Ecuador", 9),
        ("Egypt", 10),
        ("El Salvador", 8),
        ("Equatorial Guinea", 9),
        ("Eritrea", 7),
        ("Estonia", 8),
        ("Eswatini", 8),
        ("Ethiopia", 9),
        ("Fiji", 7),
        ("Finland", 10),
        ("France", 9),
        ("Gabon", 7),
        ("Gambia", 7),
        ("Georgia", 9),
        ("Germany", 11),
        ("Ghana", 9),
        ("Greece", 10),
        ("Grenada", 7),
        ("Guatemala", 8),
        ("Guinea", 9),
        ("Guinea-Bissau", 7),
        ("Guyana", 7),
        ("Haiti", 8),
        ("Honduras", 8),
        ("Hungary", 9),
        ("Iceland", 7),
        ("India", 10),
        ("Indonesia", 12),
        ("Iran", 10),
        ("Iraq", 10),
        ("Ireland", 9),
        ("Israel", 9),
        ("Italy", 10),
        ("Ivory Coast", 10),
        ("Jamaica", 7),
        ("Japan", 10),
        ("Jordan", 9),
        ("Kazakhstan", 10),
        ("Kenya", 10),
        ("Kiribati", 5),
        ("Kuwait", 8),
        ("Kyrgyzstan", 9),
        ("Laos", 9),
        ("Latvia", 8),
        ("Lebanon", 8),
        ("Lesotho", 8),
        ("Liberia", 8),
        ("Libya", 9),
        ("Liechtenstein", 7),
        ("Lithuania", 8),
        ("Luxembourg", 9),
        ("Madagascar", 9),
        ("Malawi", 7),
        ("Malaysia", 9),
        ("Maldives", 7),
        ("Mali", 8),
        ("Malta", 8),
        ("Marshall Islands", 7),
        ("Mauritania", 8),
        ("Mauritius", 7),
        ("Mexico", 10),
        ("Micronesia", 7),
        ("Moldova", 8),
        ("Monaco", 8),
        ("Mongolia", 8),
        ("Montenegro", 8),
        ("Morocco", 9),
        ("Mozambique", 9),
        ("Myanmar", 9),
        ("Namibia", 9),
        ("Nauru", 7),
        ("Nepal", 10),
        ("Netherlands", 9),
        ("New Zealand", 10),
        ("Nicaragua", 8),
        ("Niger", 8),
        ("Nigeria", 10),
        ("North Macedonia", 8),
        ("Norway", 8),
        ("Oman", 8),
        ("Pakistan", 10),
        ("Palau", 7),
        ("Palestine", 9),
        ("Panama", 8),
        ("Papua New Guinea", 8),
        ("Paraguay", 9),
        ("Peru", 9),
        ("Philippines", 10),
        ("Poland", 9),
        ("Portugal", 9),
        ("Qatar", 8),
        ("Romania", 9),
        ("Russia", 10),
        ("Rwanda", 9),
        ("Saint Kitts and Nevis", 7),
        ("Saint Lucia", 7),
        ("Saint Vincent and the Grenadines", 7),
        ("Samoa", 5),
        ("San Marino", 9),
        ("Sao Tome and Principe", 7),
        ("Saudi Arabia", 9),
        ("Senegal", 9),
        ("Serbia", 9),
        ("Seychelles", 7),
        ("Sierra Leone", 8),
        ("Singapore", 8),
        ("Slovakia", 9),
        ("Slovenia", 8),
        ("Solomon Islands", 7),
        ("Somalia", 8),
        ("South Africa", 9),
        ("South Korea", 10),
        ("South Sudan", 9),
        ("Spain", 9),
        ("Sri Lanka", 10),
        ("Sudan", 9),
        ("Suriname", 7),
        ("Sweden", 9),
        ("Switzerland", 9),
        ("Syria", 9),
        ("Taiwan", 9),
        ("Tajikistan", 9),
        ("Tanzania", 9),
        ("Thailand", 9),
        ("Timor-Leste", 7),
        ("Togo", 8),
        ("Tonga", 5),
        ("Trinidad and Tobago", 7),
        ("Tunisia", 8),
        ("Turkey", 10),
        ("Turkmenistan", 8),
        ("Tuvalu", 5),
        ("Uganda", 9),
        ("Ukraine", 9),
        ("United Arab Emirates", 9),
        ("United Kingdom", 10),
        ("United States", 10),
        ("Uruguay", 8),
        ("Uzbekistan", 9),
        ("Vanuatu", 7),
        ("Venezuela", 10),
        ("Vietnam", 9),
        ("Yemen", 9),
        ("Zambia", 9),
        ("Zimbabwe", 9)
    ]

    //MARK: - LIFE CYCLE METHOD
    override func viewDidLoad() {
        super.viewDidLoad()
        viewCountryPicker.delegate = self
       
        viewCountryPicker.showCountryCodeInView = false
        viewCountryPicker.flagImageView.isHidden = true
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
        adjustCountryPickerWidth()
        if traitCollection.userInterfaceStyle == .dark {
            viewCountryPicker.textColor = .white
            viewEmail.borderWid = 1
            viewEmail.borderCol = .white
            viewEmail.layer.cornerRadius = 24
            
            viewPhone.borderWid = 1
            viewPhone.borderCol = .white
            viewPhone.layer.cornerRadius = 24
            
            viewPassword.borderWid = 1
            viewPassword.borderCol = .white
            viewPassword.layer.cornerRadius = 24
            
            viewConfirmPasswrd.borderWid = 1
            viewConfirmPasswrd.borderCol = .white
            viewConfirmPasswrd.layer.cornerRadius = 24
            
            btnSigninApple.borderWid = 1
            btnSigninApple.borderCol = .white
            btnSigninApple.cornerRadi = 24
            imgVwTitle.image = UIImage(named: "askhumanicondark")
            lblDontHaveAccount.textColor = .white
            lblSignup.textColor = .white
            lblDontHaveAccount.textColor = .white
            
            btnSigninApple.borderWid = 1
            btnSigninApple.borderCol = .white
            btnSigninApple.cornerRadi = 24
           
                   let placeholderColor = UIColor(red: 199/255, green: 199/255, blue: 199/255, alpha: 1.0)
                   let attributes: [NSAttributedString.Key: Any] = [
                       .foregroundColor: placeholderColor
                   ]
                   txtFldEmail.attributedPlaceholder = NSAttributedString(string: "Enter your Email here", attributes: attributes)
            txtFldPhone.attributedPlaceholder = NSAttributedString(string: "Enter your Phone number", attributes: attributes)
            txtFldPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: attributes)
            txtFldConfirmPassword.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: attributes)
            
            txtFldEmail.textColor = .white
            txtFldPhone.textColor = .white
            txtFldPassword.textColor = .white
            txtFldConfirmPassword.textColor = .white
                } else {
                    viewCountryPicker.textColor = .black
                    btnSigninApple.borderWid = 0
                    btnSigninApple.borderCol = .black
                    btnSigninApple.cornerRadi = 24
                    
                    
                    viewEmail.borderWid = 1
                    viewEmail.borderCol = UIColor(red: 156/255, green: 156/255, blue: 156/255, alpha: 1.0)
                    viewEmail.layer.cornerRadius = 24
                    
                    viewPhone.borderWid = 1
                    viewPhone.borderCol = UIColor(red: 156/255, green: 156/255, blue: 156/255, alpha: 1.0)
                    viewPhone.layer.cornerRadius = 24
                    
                    viewPassword.borderWid = 1
                    viewPassword.borderCol = UIColor(red: 156/255, green: 156/255, blue: 156/255, alpha: 1.0)
                    viewPassword.layer.cornerRadius = 24
                    
                    viewConfirmPasswrd.borderWid = 1
                    viewConfirmPasswrd.borderCol = UIColor(red: 156/255, green: 156/255, blue: 156/255, alpha: 1.0)
                    viewConfirmPasswrd.layer.cornerRadius = 24
                    
                    txtFldPassword.textColor = .black
                    txtFldEmail.textColor = .black
                    lblSignup.textColor = UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1.0)
                    lblDontHaveAccount.textColor = UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1.0)
                    imgVwTitle.image = UIImage(named: "askhumaniconlight")
                    lblDontHaveAccount.textColor = UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1.0)
                    btnSigninApple.borderWid = 0
                    btnSigninApple.borderCol = .black
                    let placeholderColor = UIColor(red: 72/255, green: 72/255, blue: 72/255, alpha: 1.0)
                    let attributes: [NSAttributedString.Key: Any] = [
                        .foregroundColor: placeholderColor
                    ]
                    txtFldEmail.attributedPlaceholder = NSAttributedString(string: "Enter your Email here", attributes: attributes)
             txtFldPhone.attributedPlaceholder = NSAttributedString(string: "Enter your Phone number", attributes: attributes)
             txtFldPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: attributes)
             txtFldConfirmPassword.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: attributes)
             
             txtFldEmail.textColor = .black
             txtFldPhone.textColor = .black
             txtFldPassword.textColor = .black
             txtFldConfirmPassword.textColor = .black
                }
    }
    func adjustCountryPickerWidth() {
        if let digits = digits(for: viewCountryPicker.selectedCountry.name) {
            txtFldPhone.maxLength = digits
            
        }
        let phoneCodeLength = viewCountryPicker.selectedCountry.phoneCode.count
        switch phoneCodeLength {
        case 2:
            widthCountryPickerVw.constant = 35
        case 3:
            widthCountryPickerVw.constant = 45
        case 4:
            widthCountryPickerVw.constant = 55
        default:
            widthCountryPickerVw.constant = 60
        }
    }

    //MARK: - ACTIONS\
    
    @IBAction func actionCountryPicker(_ sender: UIButton) {
        viewCountryPicker.showCountriesList(from: self)
        
        
    }
    @IBAction func actionPassword(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected == true{
            
            sender.setImage(UIImage(named: "eye-solid 126"), for: .normal)
            txtFldPassword.isSecureTextEntry = false
            
        }else{
            
            sender.setImage(UIImage(named: "eye-slash-solid 125"), for: .normal)
            txtFldPassword.isSecureTextEntry = true
            
        }
    }
    @IBAction func actionConfirmPassword(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected == true{
            
            sender.setImage(UIImage(named: "eye-solid 126"), for: .normal)
            txtFldConfirmPassword.isSecureTextEntry = false
            
        }else{
            
            sender.setImage(UIImage(named: "eye-slash-solid 125"), for: .normal)
            txtFldConfirmPassword.isSecureTextEntry = true
            
        }
    }
    
    @IBAction func actionSignUp(_ sender: GradientButton) {
        
        if txtFldEmail.text == ""{
            
            showSwiftyAlert("", "Please enter your email address.", false)
            
        }else if txtFldEmail.isValidEmail(txtFldEmail.text ?? "") == false{
            
            showSwiftyAlert("", "Please enter a valid email address.", false)
            
        }else if txtFldPhone.text == ""{
            
            showSwiftyAlert("", "Please enter your phone number.", false)
            
        }else if txtFldPhone.text?.count != txtFldPhone.maxLength{
            
            showSwiftyAlert("", "Please enter valid phone number", false)
            
        }else if txtFldPassword.text == ""{
            
            showSwiftyAlert("", "Please enter your password.", false)
            
        }else if txtFldPassword.text?.count ?? 0 < 6{
            
            showSwiftyAlert("", "Password must be at least 6 characters long.", false)
            
        }else if !isValidPassword(txtFldPassword.text ?? ""){
            showSwiftyAlert("", "Password must be at least one uppercase letter, one lowercase letter, one digit, and one special character", false)
        }else if txtFldConfirmPassword.text == ""{
            
            showSwiftyAlert("", "Please enter confirm password.", false)
            
        }else if txtFldPassword.text != txtFldConfirmPassword.text{
            
            showSwiftyAlert("", "Password do not match.", false)
            
        }else{
            
            viewModel.signUpApi(email: txtFldEmail.text ?? "",
                                mobile: txtFldPhone.text ?? "",
                                password: txtFldPassword.text ?? "",
                                confirmPassword: txtFldConfirmPassword.text ?? "", countryCode: viewCountryPicker.selectedCountry.phoneCode,
                                fcmToken: Store.deviceToken ?? "") { data in

//                    showSwiftyAlert("", "A verification email has been sent. Please check your email and click on the verification link to complete the signup process.", true)
               
                    Store.isSocialLogin = false
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "OtpVC") as! OtpVC
                    Store.comingOtp = 0
                    vc.mobileOtp = data?.data?.mobileOtp ?? ""
                    vc.mobileNo = data?.data?.user?.mobile ?? 0
                    self.navigationController?.pushViewController(vc, animated:true)
                let vcPop = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
                vcPop.modalPresentationStyle = .overFullScreen
                vcPop.message = "A verification email has been sent. Please check your email and click on the verification link to complete the signup process."
                vcPop.callBack = {
                    showSwiftyAlert("", "Enter otp: \(data?.data?.mobileOtp ?? "")", true)
                }
                self.navigationController?.present(vcPop, animated: false)
            }
            
        }
    }
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$&*]).{6,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }

    @IBAction func actionSignIn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        
        self.navigationController?.pushViewController(vc, animated:true)
    }
    
    @IBAction func actionSignUpGoogle(_ sender: UIButton) {
        GoogleSignIn.shared.email = true
        GoogleSignIn.shared.presentingWindow = view.window
        GoogleSignIn.shared.signIn()
    }
    
    @IBAction func actionSignUpApple(_ sender: UIButton) {
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
extension SignUpVC:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtFldPhone{
            let allowedCharacters = "0123456789"
            let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
            let typedCharacterSet = CharacterSet(charactersIn: string)
            let alphabet = allowedCharacterSet.isSuperset(of: typedCharacterSet)
            return alphabet
                    
                }
        return true
       
    }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            switch textField {
            case txtFldEmail:
                txtFldPhone.becomeFirstResponder()
            case txtFldPhone:
                txtFldPassword.becomeFirstResponder()
            case txtFldPassword:
                txtFldConfirmPassword.becomeFirstResponder()
            default:
                break
            }
            textField.resignFirstResponder()
            return true
        }
   
}

extension SignUpVC: ASAuthorizationControllerDelegate {

     // ASAuthorizationControllerDelegate function for authorization failed

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {

        print(error.localizedDescription)

    }

       // ASAuthorizationControllerDelegate function for successful authorization

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {

        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {

            // Create an account as per your requirement

            let appleId = appleIDCredential.user

            let appleUserFirstName = appleIDCredential.fullName?.givenName

            let appleUserLastName = appleIDCredential.fullName?.familyName

            let appleUserEmail = appleIDCredential.email

            DispatchQueue.main.asyncAfter(deadline: .now()){
                self.viewModel.socialaAuthApi(socialId: appleId, socialType: "apple", email: appleUserEmail ?? "", fcmToken: Store.deviceToken ?? "") { data in
                    Store.authKey = data?.token ?? ""
                    Store.isSocialLogin = true
                        if data?.user?.profileComplete == 0{
                            
                            let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "ProfileDetailVC") as! ProfileDetailVC
                            vc2.isComing = 0
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

            //Write your code

        }

    }

}

extension SignUpVC: ASAuthorizationControllerPresentationContextProviding {

    //For present window

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {

        return self.view.window!

    }

}
    //MARK: - GoogleSignInDelegate
extension SignUpVC: GoogleSignInDelegate {
    func googleSignIn(didSignIn auth: GoogleSignIn.Auth?, user: GoogleSignIn.User?, error: Error?) {
           
            
            if let email = user?.email {
                DispatchQueue.main.asyncAfter(deadline: .now()){
                    self.viewModel.socialaAuthApi(socialId: user?.id ?? "", socialType: "google", email: user?.email ?? "", fcmToken: Store.deviceToken ?? "") { data in
                        Store.authKey = data?.token ?? ""
                        Store.isSocialLogin = true
                            if data?.user?.profileComplete == 0{
                                
                                let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "ProfileDetailVC") as! ProfileDetailVC
                                vc2.isComing = 0
                                vc2.profileImg = user?.picture?.absoluteString ?? ""
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
//MARK: - CountryPickerViewDelegate
extension SignUpVC:CountryPickerViewDelegate{
    func digits(for countryName: String) -> Int? {
        for (country, digits) in countriesPhoneNumbers {
            if country == countryName {
                return digits
            }
        }
        return nil  // Return nil if country name is not found
    }

    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: CPVCountry){
        if let digits = digits(for: country.name) {
            txtFldPhone.maxLength = digits
            txtFldPhone.text = ""
        }
        if country.phoneCode.count == 2{
            widthCountryPickerVw.constant = 35
            
        }else  if country.phoneCode.count == 3{
            widthCountryPickerVw.constant = 45
            
        }else  if country.phoneCode.count == 4{
            widthCountryPickerVw.constant = 55
            
        }else{
            widthCountryPickerVw.constant = 60
            
        }
    }
    
}
