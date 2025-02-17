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
    
    @IBOutlet var lblSubtitle: UILabel!
    @IBOutlet var btnBAck: UIButton!
    @IBOutlet var viewBackCountryPicker: UIView!
    @IBOutlet var viewName: UIView!
    @IBOutlet var viewDob: UIView!
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
    @IBOutlet weak var txtFldDob: UITextField!
    @IBOutlet weak var txtFldName: UITextField!
    
    //MARK: - VARIABLES
    var mobileNo,countryCode:Int?
    var viewModelProfile = ProfileVM()
    var viewModel = AuthVM()
    var signupDetail: SignUpData?
    var selectedAge:Int?
    
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
    private func uiSet(){
        setupDatePicker(for: txtFldDob, mode: .date, selector: #selector(dateOfBirth))
        if traitCollection.userInterfaceStyle == .dark {
            btnBAck.setImage(UIImage(named: "keyboard-backspace25"), for: .normal)
            lblSubtitle.textColor = .white
            viewCountryPicker.textColor = .white
            viewEmail.borderWid = 1
            viewEmail.borderCol = .white
            viewEmail.layer.cornerRadius = 24
            
            viewBackCountryPicker.borderWid = 1
            viewBackCountryPicker.borderCol = .white
            viewBackCountryPicker.layer.cornerRadius = 24
            viewBackCountryPicker.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            
            viewPhone.borderWid = 1
            viewPhone.borderCol = .white
            viewPhone.layer.cornerRadius = 24
            viewPhone.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            
            viewName.borderWid = 1
            viewName.borderCol = .white
            viewName.layer.cornerRadius = 24
            
            
            viewDob.borderWid = 1
            viewDob.borderCol = .white
            viewDob.layer.cornerRadius = 24
            
            
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
            txtFldName.attributedPlaceholder = NSAttributedString(string: "Full name", attributes: attributes)
            txtFldEmail.attributedPlaceholder = NSAttributedString(string: "Enter your email here", attributes: attributes)
            txtFldPhone.attributedPlaceholder = NSAttributedString(string: "Phone number", attributes: attributes)
            txtFldPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: attributes)
            txtFldConfirmPassword.attributedPlaceholder = NSAttributedString(string: "Confirm password", attributes: attributes)
            txtFldDob.attributedPlaceholder = NSAttributedString(string: "dd MMM, yyyy", attributes: attributes)
            
            txtFldName.textColor = .white
            txtFldDob.textColor = .white
            txtFldEmail.textColor = .white
            txtFldPhone.textColor = .white
            txtFldPassword.textColor = .white
            txtFldConfirmPassword.textColor = .white
        } else {
            btnBAck.setImage(UIImage(named: "back"), for: .normal)
            lblSubtitle.textColor = .black
            viewCountryPicker.textColor = UIColor(hex: "#707070")
            btnSigninApple.borderWid = 0
            btnSigninApple.borderCol = .black
            btnSigninApple.cornerRadi = 24
            
            viewName.borderWid = 1
            viewName.borderCol = .bordercolor
            viewName.layer.cornerRadius = 24
            
            viewDob.borderWid = 1
            viewDob.borderCol = .bordercolor
            viewDob.layer.cornerRadius = 24
            
            viewEmail.borderWid = 1
            viewEmail.borderCol = .bordercolor
            viewEmail.layer.cornerRadius = 24
            
            viewBackCountryPicker.borderWid = 1
            viewBackCountryPicker.borderCol = .bordercolor
            viewBackCountryPicker.layer.cornerRadius = 24
            viewBackCountryPicker.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            
            viewPhone.borderWid = 1
            viewPhone.borderCol = .bordercolor
            viewPhone.layer.cornerRadius = 24
            viewPhone.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            
            viewPassword.borderWid = 1
            viewPassword.borderCol = .bordercolor
            viewPassword.layer.cornerRadius = 24
            
            viewConfirmPasswrd.borderWid = 1
            viewConfirmPasswrd.borderCol = .bordercolor
            viewConfirmPasswrd.layer.cornerRadius = 24
            
            txtFldPassword.textColor = .black
            txtFldEmail.textColor = .black
            lblSignup.textColor = UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1.0)
            lblDontHaveAccount.textColor = UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1.0)
            imgVwTitle.image = UIImage(named: "askhumaniconlight")
            lblDontHaveAccount.textColor = UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1.0)
            btnSigninApple.borderWid = 0
            btnSigninApple.borderCol = .black
            let placeholderColor = UIColor.placeholder
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: placeholderColor
            ]
            txtFldName.attributedPlaceholder = NSAttributedString(string: "Full name", attributes: attributes)
            
            txtFldDob.attributedPlaceholder = NSAttributedString(string: "dd MMM, yyyy", attributes: attributes)
            
            txtFldEmail.attributedPlaceholder = NSAttributedString(string: "Enter your email here", attributes: attributes)
            txtFldPhone.attributedPlaceholder = NSAttributedString(string: "Phone number", attributes: attributes)
            txtFldPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: attributes)
            txtFldConfirmPassword.attributedPlaceholder = NSAttributedString(string: "Confirm password", attributes: attributes)
            
            txtFldName.textColor = .black
            txtFldDob.textColor = .black
            txtFldEmail.textColor = .black
            txtFldPhone.textColor = .black
            txtFldPassword.textColor = .black
            txtFldConfirmPassword.textColor = .black
        }
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: selectedDate, to: Date())
        let selectedAge = components.year ?? 0  // Store the calculated age
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM, yyyy"
        txtFldDob.text = dateFormatter.string(from: selectedDate)
        print("Selected Age: \(selectedAge)")
    }
    
    
    //MARK: - ACTIONS
    
    @IBAction func actionBAck(_ sender: UIButton) {
        SceneDelegate().loginVCRoot()
    }
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
        if txtFldName.text?.trimWhiteSpace == ""{
            showSwiftyAlert("", "Name must be entered.", false)
        }else  if txtFldName.text?.count ?? 0 < 3 || txtFldName.text?.count ?? 0 > 30{
            showSwiftyAlert("", "Name must be between 3 and 30 characters long.", false)
        }else if txtFldDob.text == ""{
            
            showSwiftyAlert("", "Please select your date of birth.", false)
            
        }else if selectedAge ?? 0 < 18{
            
            showSwiftyAlert("", "You must be at least 18 years old to proceed.", false)
            
        }else{
            viewModelProfile.signupUserDetailsApi(name: txtFldName.text ?? "", age: selectedAge ?? 0, dob: txtFldDob.text ?? "") { data in
                DispatchQueue.main.asyncAfter(deadline: .now()){
                    self.viewModelProfile.getProfileApi { data in
                        Store.autoLogin = "true"
                        Store.isSocialLogin = false
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ConfirmEmailVC") as! ConfirmEmailVC
                        self.navigationController?.pushViewController(vc, animated:true)
                    }
                }
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

//MARK: - UITextFieldDelegate
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
//Optional(GoogleSignInSwift.GoogleSignIn.User(id: "107224184435755511720", email: Optional("gurjinders030@gmail.com"), verifiedEmail: Optional(true), name: Optional("Gurjinder kansal"), givenName: Optional("Gurjinder"), familyName: Optional("kansal"), picture: Optional(https://lh3.googleusercontent.com/a/ACg8ocKqdMtzN4e8rXlIamfemuUCS_xJ80jbv1Gqr1zSJA7afTfDvGg=s96-c), locale: nil))
//["socialId": "107224184435755511720", "socialType": "google", "email": "gurjinders030@gmail.com", "fcmToken": "dqXjb1W_cUxBjkaq9305n1:APA91bHkqF3mJD3TtcbiM7POuhRMDpxw720KBGZXytTyKZuphwRvmYD1oXsqdTXBi4qvp7n0edTfYWml1zDzkWzXycPCNPIybva-EXofDnQ69Vjjb_fdpZc"]
extension SignUpVC: GoogleSignInDelegate {
    func googleSignIn(didSignIn auth: GoogleSignIn.Auth?, user: GoogleSignIn.User?, error: Error?) {
        print(user)
        if let email = user?.email {
            DispatchQueue.main.asyncAfter(deadline: .now()){
                self.viewModel.socialaAuthApi(socialId: user?.id ?? "", socialType: "google", email: user?.email ?? "", fcmToken: Store.deviceToken ?? "") { data in
                    Store.authKey = data?.token ?? ""
                    Store.isSocialLogin = true
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

//MARK: - setupDatePicker
extension SignUpVC {
    func setupDatePicker(for textField: UITextField, mode: UIDatePicker.Mode, selector: Selector) {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = mode
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        let currentDate = Date()
        let calendar = Calendar.current
        if let maxDate = calendar.date(byAdding: .year, value: -65, to: currentDate) {
            datePicker.maximumDate = currentDate
            datePicker.minimumDate = maxDate
        }
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        textField.inputView = datePicker
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: selector)
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        textField.inputAccessoryView = toolbar
        
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        datePicker.tag = textField.tag
    }
    
    @objc func dateOfBirth() {
        if let datePicker = txtFldDob.inputView as? UIDatePicker {
            let selectedDate = datePicker.date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM, yyyy"
            txtFldDob.text = dateFormatter.string(from: selectedDate)
            calculateAge(from: selectedDate)
        }
        txtFldDob.resignFirstResponder()
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM, yyyy"
        txtFldDob.text = dateFormatter.string(from: selectedDate)
        calculateAge(from: selectedDate)
    }
    
    func calculateAge(from birthDate: Date) {
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthDate, to: Date())
        
        if let age = ageComponents.year {
            print("Age: \(age) years")
            selectedAge = age
        }
    }
}
