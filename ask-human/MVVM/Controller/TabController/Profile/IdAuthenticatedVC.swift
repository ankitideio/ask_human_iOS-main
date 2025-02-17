//
//  IdAuthenticatedVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 24/12/24.
//

import UIKit

class IdAuthenticatedVC: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet var viewBack: UIView!
    @IBOutlet var viewTop: UIView!
    @IBOutlet var viewDetails: UIView!
    @IBOutlet var lblZodiac: UILabel!
    @IBOutlet var lblAge: UILabel!
    @IBOutlet var lblGender: UILabel!
    @IBOutlet var btnEdit: UIButton!
    @IBOutlet var lblTitleZodiac: UILabel!
    @IBOutlet var lblTitleAge: UILabel!
    @IBOutlet var lblTitleGender: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblIdAuth: UILabel!
    @IBOutlet var btnProcess: GradientButton!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var imgVwTitle: UIImageView!
    @IBOutlet var txtFldGender: UITextField!
    @IBOutlet var txtFldZodiac: UITextField!
    @IBOutlet var txtFldAge: UITextField!
    @IBOutlet var imgVwGender: UIImageView!
    @IBOutlet var imgVwAge: UIImageView!
    @IBOutlet var imgVwZodiac: UIImageView!
    
    //MARK: - variables
    var callBack:((_ gender:String,_ age:Int,_ zodiac:String)->())?
    var gender:Int?
    
    var isEdit = false
    var isComing = false
    var age:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSet()
    }
    override func viewWillAppear(_ animated: Bool) {
        darkMode()
    }
    //MARK: - functions
    func uiSet(){
        txtFldAge.delegate = self
        // Create and add a tap gesture recognizer for txtFldGender
        let genderTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleGenderTap))
        txtFldGender.addGestureRecognizer(genderTapGesture)
        txtFldGender.isUserInteractionEnabled = true // Make sure the text field is interactive
        
        // Create and add a tap gesture recognizer for txtFldZodiac
        let zodiacTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleZodiacTap))
        txtFldZodiac.addGestureRecognizer(zodiacTapGesture)
        txtFldZodiac.isUserInteractionEnabled = true // Make sure the text field is interactive
        
//        let lblGenderTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLblGenderTap))
//        lblGender.addGestureRecognizer(lblGenderTapGesture)
//        lblGender.isUserInteractionEnabled = true // Make sure the text field is interactive

        if isComing{
            btnEdit.isHidden = true
            viewDetails.isHidden = true
            lblTitleGender.isHidden = false
            lblTitleAge.isHidden = false
            lblTitleZodiac.isHidden = false
            txtFldAge.isHidden = false
            txtFldGender.isHidden = false
            txtFldZodiac.isHidden = false
            lblTitle.text = "Ask Human will autofill your mentioned data."
            
        }else{
            btnEdit.isHidden = false
            viewDetails.isHidden = false
            lblTitleGender.isHidden = true
            lblTitleAge.isHidden = true
            lblTitleZodiac.isHidden = true
            txtFldAge.isHidden = true
            txtFldGender.isHidden = true
            txtFldZodiac.isHidden = true
            lblTitle.text = "Ask Human will autofill your mentioned data."
            
        }
        if gender == 0{
            self.txtFldGender.text = "Male"
            self.lblGender.text = "Male"
        }else if gender == 1{
            self.txtFldGender.text = "Female"
            self.lblGender.text = "Female"
        }else{
            self.txtFldGender.text = "Others"
            self.lblGender.text = "Others"
        }
        txtFldZodiac.text = Store.userDetail?["zodiac"] as? String ?? ""
        lblZodiac.text = Store.userDetail?["zodiac"] as? String ?? ""
        txtFldAge.text = "\(Store.userDetail?["age"] as? Int ?? 0)"
        lblAge.text = "\(Store.userDetail?["age"] as? Int ?? 0) years"
        age = Store.userDetail?["age"] as? Int ?? 0
        if let dob = Store.userDetail?["dob"] as? String, !dob.isEmpty {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM, yyyy"
            if let dateOfBirth = formatter.date(from: dob) {
                let calendar = Calendar.current
                let components = calendar.dateComponents([.month, .day], from: dateOfBirth)
                if let month = components.month, let day = components.day {
                    self.txtFldZodiac.text = getZodiacSign(month: month, day: day)
                    self.lblZodiac.text = getZodiacSign(month: month, day: day)
                }
            }
        }
    }
    
//    @objc func handleLblGenderTap(sender:UITapGestureRecognizer){
//        presentGenderPopOver(sender: sender)
//    }
    func presentGenderPopOver(sender: UITapGestureRecognizer){
        view.endEditing(true)
        guard let sourceView = sender.view else { return }
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfilePopUpsVC") as! ProfilePopUpsVC
        vc.isSelect = 1
        vc.selectedTitle = txtFldGender.text ?? ""
        vc.modalPresentationStyle = .popover
        vc.preferredContentSize = CGSize(width: sourceView.frame.width, height: 145)
        let popOver : UIPopoverPresentationController = vc.popoverPresentationController!
        popOver.sourceView = sender.view
        popOver.delegate = self
        popOver.permittedArrowDirections = .up
        vc.callBack = { (index,title,selecIndex) in
            if index == 0{
                self.gender = 0
                self.txtFldGender.text = title
                self.lblGender.text = title
            }else if index == 1{
                self.gender = 1
                self.txtFldGender.text = title
                self.lblGender.text = title
            }else{
                self.gender = 2
                self.txtFldGender.text = title
                self.lblGender.text = title
            }
        }
        self.present(vc, animated: true, completion: nil)
    }
    // Handle tap on Gender field
    @objc func handleGenderTap(sender:UITapGestureRecognizer) {
        presentGenderPopOver(sender: sender)
    }
    
    // Handle tap on Zodiac field
    @objc func handleZodiacTap(sender:UITapGestureRecognizer) {
        view.endEditing(true)
        guard let sourceView = sender.view else { return }
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfilePopUpsVC") as! ProfilePopUpsVC
        vc.isSelect = 20
        vc.selectedTitle = txtFldZodiac.text ?? ""
        vc.modalPresentationStyle = .popover
        vc.preferredContentSize = CGSize(width: sourceView.frame.width, height: 420)
        let popOver : UIPopoverPresentationController = vc.popoverPresentationController!
        popOver.sourceView = sender.view
        popOver.delegate = self
        popOver.permittedArrowDirections = .up
        vc.callBack = { (index,title,selecIndex) in
            self.txtFldZodiac.text = title
            print("title:--\(title)")
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    func darkMode(){
        let isDarkMode = traitCollection.userInterfaceStyle == .dark
        btnBack.setImage(isDarkMode ? UIImage(named: "keyboard-backspace25") :  UIImage(named: "back"), for: .normal)
        imgVwTitle.image = isDarkMode ? UIImage(named: "askhumanicondark") : UIImage(named: "askhumaniconlight")
        lblIdAuth.textColor = isDarkMode ? UIColor.white : .black
        lblTitle.textColor = isDarkMode ? UIColor.white : .black
        viewBack.backgroundColor = isDarkMode ? UIColor(hex: "#161616") : UIColor(hex: "#D9D9D9").withAlphaComponent(0.50)
        viewTop.backgroundColor = isDarkMode ? UIColor(hex: "#161616") : UIColor(hex: "#D9D9D9").withAlphaComponent(0.50)
        lblGender.textColor = isDarkMode ? UIColor(hex: "#979797") : .black
        lblAge.textColor = isDarkMode ? UIColor(hex: "#979797") : .black
        lblZodiac.textColor = isDarkMode ? UIColor(hex: "#979797") : .black
        
        lblTitleAge.textColor = isDarkMode ? UIColor.white : .black
        lblTitleGender.textColor = isDarkMode ? UIColor.white : .black
        lblTitleZodiac.textColor = isDarkMode ? UIColor.white : .black
        imgVwAge.image = UIImage(named: isDarkMode ? "ageDark" : "age")
        imgVwGender.image = UIImage(named: isDarkMode ? "genderDark" : "gender")
        imgVwZodiac.image = UIImage(named: isDarkMode ? "zodiacDark" : "zodiac")
        
    }
    private func getZodiacSign(month: Int, day: Int) -> String {
        switch (month, day) {
        case (1, 20...), (2, 1...18): return "Aquarius"
        case (2, 19...), (3, 1...20): return "Pisces"
        case (3, 21...), (4, 1...19): return "Aries"
        case (4, 20...), (5, 1...20): return "Taurus"
        case (5, 21...), (6, 1...20): return "Gemini"
        case (6, 21...), (7, 1...22): return "Cancer"
        case (7, 23...), (8, 1...22): return "Leo"
        case (8, 23...), (9, 1...22): return "Virgo"
        case (9, 23...), (10, 1...22): return "Libra"
        case (10, 23...), (11, 1...21): return "Scorpio"
        case (11, 22...), (12, 1...21): return "Sagittarius"
        case (12, 22...), (1, 1...19): return "Capricorn"
        default: return "Unknown"
        }
    }
    //MARK: - IBAction
    @IBAction func actionEdit(_ sender: Any) {
        isEdit = true
        viewDetails.isHidden = true
        lblTitleGender.isHidden = false
        lblTitleAge.isHidden = false
        lblTitleZodiac.isHidden = false
        txtFldAge.isHidden = false
        txtFldGender.isHidden = false
        txtFldZodiac.isHidden = false
        lblTitle.isHidden = false
        btnEdit.isHidden = true
        lblTitle.text = ""
    }
    
    @IBAction func actionProceed(_ sender: Any) {
        if lblGender.text == "Others" || txtFldGender.text == "Others"{
            showSwiftyAlert("", "Please select your gender.", false)
        }else if txtFldGender.text == "" {
                showSwiftyAlert("", "Please select your gender.", false)
            }else if txtFldAge.text == ""{
                showSwiftyAlert("", "Please enter your age.", false)
            }else if let age = Int(txtFldAge.text!), age < 18 {
                showSwiftyAlert("", "You must be at least 18 years old to proceed.", false)
            }else if txtFldZodiac.text == ""{
                showSwiftyAlert("", "Please select your zodiac.", false)
            }else{
                self.navigationController?.popViewController(animated: true)
                if let ageText = txtFldAge.text, let age = Int(ageText) {
                    callBack?(txtFldGender.text ?? "", age, txtFldZodiac.text ?? "")
                }
            }
    }
    @IBAction func actionBack(_ sender: UIButton) {
        if isEdit{
            isEdit = false
            btnEdit.isHidden = false
            viewDetails.isHidden = false
            lblTitleGender.isHidden = true
            lblTitleAge.isHidden = true
            lblTitleZodiac.isHidden = true
            txtFldAge.isHidden = true
            txtFldGender.isHidden = true
            txtFldZodiac.isHidden = true
            lblTitle.text = "Ask Human will autofill your mentioned data."
        }else{
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
}
// MARK: - Popup
extension IdAuthenticatedVC : UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    //UIPopoverPresentationControllerDelegate
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
    }
}
extension IdAuthenticatedVC:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtFldAge{
            if string.isEmpty {
                return true
            }
            guard let currentText = textField.text else { return true }
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            if let number = Int(newText), number >= 1, number <= 65 {
                return true
            }
            return false
        }
        return true
    }
}

