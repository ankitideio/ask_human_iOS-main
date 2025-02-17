//
//  SocialLoginDetailsVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 31/12/24.
//

import UIKit
import CountryPickerView

class SocialLoginDetailsVC: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet var viewDateOfBirth: UIView!
    @IBOutlet var viewPhoneNumber: UIView!
    @IBOutlet var viewName: UIView!
    @IBOutlet var viewBackCountryPicker: UIView!
    @IBOutlet var viewPhone: UIView!

    @IBOutlet var widthCountryPickerVw: NSLayoutConstraint!
    @IBOutlet var viewCountryPicker: CountryPickerView!
    @IBOutlet var txtFldName: UITextField!
    @IBOutlet var txtFldEmail: UITextField!
    @IBOutlet var txtFldPhonenumber: UITextField!
    @IBOutlet var txtFldDateofbirth: UITextField!
    @IBOutlet var lblScrenTitle: UILabel!
    @IBOutlet var imgVwTitle: UIImageView!
    @IBOutlet var btnBack: UIButton!
    
    //MARK: - Variables
    var userName = ""
    var viewModel = ProfileVM()
    var selectedAge:Int?
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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .light
        uiSet()
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                uiSet()
            }
        }
    func uiSet(){
       
        viewCountryPicker.delegate = self
        viewCountryPicker.showCountryCodeInView = false
        txtFldName.text = userName
        txtFldEmail.text = Store.userDetail?["email"] as? String ?? ""
        lblScrenTitle.text = "Finish Setting  up your \n account"
        setupDatePicker(for: txtFldDateofbirth, mode: .date, selector: #selector(dateOfBirth))
        adjustCountryPickerWidth()
        darkMode()
    }
    func darkMode(){
        if traitCollection.userInterfaceStyle == .dark {
            viewName.borderCol = .white
            viewDateOfBirth.borderCol = .white
            
            viewBackCountryPicker.borderWid = 1
            viewBackCountryPicker.borderCol = .white
            viewBackCountryPicker.layer.cornerRadius = 24
            viewBackCountryPicker.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]

            viewPhone.borderWid = 1
            viewPhone.borderCol = .white
            viewPhone.layer.cornerRadius = 24
            viewPhone.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]

            btnBack.setImage(UIImage(named: "keyboard-backspace25"), for: .normal)
            viewCountryPicker.textColor = .white
            txtFldName.textColor = .white
            txtFldDateofbirth.textColor = .white
            txtFldEmail.textColor = .white
            txtFldPhonenumber.textColor = .white
            imgVwTitle.image = UIImage(named: "askhumanicondark")
            lblScrenTitle.textColor = .white
                   let placeholderColor = UIColor(red: 199/255, green: 199/255, blue: 199/255, alpha: 1.0)
                   let attributes: [NSAttributedString.Key: Any] = [
                       .foregroundColor: placeholderColor
                   ]
            txtFldName.attributedPlaceholder = NSAttributedString(string: "Enter your full name", attributes: attributes)
            txtFldEmail.attributedPlaceholder = NSAttributedString(string: "Enter your email here", attributes: attributes)
            txtFldPhonenumber.attributedPlaceholder = NSAttributedString(string: "Phone number", attributes: attributes)
            txtFldDateofbirth.attributedPlaceholder = NSAttributedString(string: "MM-DD-YY", attributes: attributes)
                }else{
                    viewName.borderCol = .bordercolor
                    viewDateOfBirth.borderCol = .bordercolor

                    viewBackCountryPicker.borderWid = 1
                    viewBackCountryPicker.borderCol = .bordercolor
                    viewBackCountryPicker.layer.cornerRadius = 24
                    viewBackCountryPicker.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]

                    viewPhone.borderWid = 1
                    viewPhone.borderCol = .bordercolor
                    viewPhone.layer.cornerRadius = 24
                    viewPhone.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]

                    lblScrenTitle.textColor = UIColor(hex: "#303030")
                    btnBack.setImage(UIImage(named: "back"), for: .normal)
                    txtFldName.textColor = .black
                    txtFldDateofbirth.textColor = .black
                     txtFldEmail.textColor = .black
                    txtFldPhonenumber.textColor = .black
                    viewCountryPicker.textColor = .black
                    imgVwTitle.image = UIImage(named: "askhumaniconlight")
                    let placeholderColor = UIColor.placeholder
                    let attributes: [NSAttributedString.Key: Any] = [
                        .foregroundColor: placeholderColor
                    ]
                    txtFldName.attributedPlaceholder = NSAttributedString(string: "Enter your full name", attributes: attributes)
                    txtFldEmail.attributedPlaceholder = NSAttributedString(string: "Enter your email here", attributes: attributes)
                    txtFldPhonenumber.attributedPlaceholder = NSAttributedString(string: "Phone number", attributes: attributes)
                    txtFldDateofbirth.attributedPlaceholder = NSAttributedString(string: "MM-DD-YY", attributes: attributes)
                }
    }
    func adjustCountryPickerWidth() {
        if let digits = digits(for: viewCountryPicker.selectedCountry.name) {
            txtFldPhonenumber.maxLength = digits
        }
        let phoneCodeLength = viewCountryPicker.selectedCountry.phoneCode.count
        switch phoneCodeLength {
        case 2:
            widthCountryPickerVw.constant = 50
        case 3:
            widthCountryPickerVw.constant = 55
        case 4:
            widthCountryPickerVw.constant = 65
        default:
            widthCountryPickerVw.constant = 75
        }
    }

    //MARK: - ACTIONS
    
    @IBAction func actionCountryPicker(_ sender: UIButton) {
        viewCountryPicker.showCountriesList(from: self)
    }
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionSignup(_ sender: UIButton) {
        if txtFldName.text?.trimWhiteSpace == ""{
            
            showSwiftyAlert("", "Name must be entered.", false)
            
        }else  if txtFldName.text?.count ?? 0 < 3 || txtFldName.text?.count ?? 0 > 30{
            
            showSwiftyAlert("", "Name must be between 3 and 30 characters long.", false)
            
        }else  if txtFldPhonenumber.text == ""{
            
            showSwiftyAlert("", "Please enter your phone number.", false)
            
        }else if txtFldPhonenumber.text?.count != txtFldPhonenumber.maxLength{
            
            showSwiftyAlert("", "Please enter valid phone number", false)
            
        }else if txtFldDateofbirth.text == ""{
            
            showSwiftyAlert("", "Please enter your date of birth.", false)
            
        }else if selectedAge ?? 0 < 18{
            
            showSwiftyAlert("", "You must be at least 18 years old to proceed.", false)
            
        }else{
            let countryCode = viewCountryPicker.selectedCountry.phoneCode.replacingOccurrences(of: "+", with: "")
            print("Selected Country Code: \(countryCode)")

            viewModel.setProfileAfterSocialLoginApi(name: txtFldName.text ?? "", age: selectedAge ?? 0, dob: txtFldDateofbirth.text ?? "", countryCode: countryCode) { data in
                self.viewModel.getProfileApi { data in
                    let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "ConfirmEmailVC") as! ConfirmEmailVC
                    Store.autoLogin = "true"
                    self.navigationController?.pushViewController(vc2, animated:true)
                }
                
            }
        }
    }
}
//MARK: - UITextFieldDelegate
extension SocialLoginDetailsVC:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtFldPhonenumber{
            let allowedCharacters = "0123456789"
            let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
            let typedCharacterSet = CharacterSet(charactersIn: string)
            let alphabet = allowedCharacterSet.isSuperset(of: typedCharacterSet)
            return alphabet
                    
                }
        return true
       
    }
//        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//            switch textField {
//            case txtFldEmail:
//                txtFldPhonenumber.becomeFirstResponder()
//            case txtFldPhone:
//                txtFldPassword.becomeFirstResponder()
//            case txtFldPassword:
//                txtFldConfirmPassword.becomeFirstResponder()
//            default:
//                break
//            }
//            textField.resignFirstResponder()
//            return true
//        }
   
}
//MARK: - CountryPickerViewDelegate
extension SocialLoginDetailsVC:CountryPickerViewDelegate{
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
            txtFldPhonenumber.maxLength = digits
            txtFldPhonenumber.text = ""
        }
        adjustCountryPickerWidth()
    }
    
}

//MARK: - setupDatePicker
extension SocialLoginDetailsVC {
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
        if let datePicker = txtFldDateofbirth.inputView as? UIDatePicker {
            let selectedDate = datePicker.date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM, yyyy"
            txtFldDateofbirth.text = dateFormatter.string(from: selectedDate)
            
            // Calculate age based on selected date of birth
            calculateAge(from: selectedDate)
        }
        txtFldDateofbirth.resignFirstResponder()
    }

    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM, yyyy"
        txtFldDateofbirth.text = dateFormatter.string(from: selectedDate)
        
        // Calculate age based on selected date of birth
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
