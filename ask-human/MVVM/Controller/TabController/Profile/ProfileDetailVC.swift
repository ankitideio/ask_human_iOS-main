//
//  ProfileDetailVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 07/12/23.
//

import UIKit
import IQKeyboardManagerSwift


class ProfileDetailVC: UIViewController{
    
    //MARK: - OUTLETS
    
    @IBOutlet var viewDescription: UIView!
    @IBOutlet var lblTitleUsername: UILabel!
    @IBOutlet var lblTitleUploadProfile: UILabel!
    @IBOutlet var lblTitleGender: UILabel!
    @IBOutlet var lblTitleEthni: UILabel!
    @IBOutlet var lblTitleZodi: UILabel!
    @IBOutlet var lblTitleAge: UILabel!
    @IBOutlet var lblTitlePrice: UILabel!
    @IBOutlet var lblTitleSmoke: UILabel!
    @IBOutlet var lblTitleDrink: UILabel!
    @IBOutlet var lblTitleWorkout: UILabel!
    @IBOutlet var lblTitleBodyType: UILabel!
    @IBOutlet var lblTitleDescription: UILabel!
    @IBOutlet weak var txtFldPrice: UITextField!
    @IBOutlet var sliderr: UISlider!
    @IBOutlet weak var lblSelectAge: UILabel!
    @IBOutlet var gradientVw: GradientView!
    @IBOutlet var btnEditProfilePics: UIButton!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet weak var btnCreateProfile: GradientButton!
    @IBOutlet weak var btnUploadPhoto: UIButton!
    @IBOutlet weak var lblMax: UILabel!
    @IBOutlet weak var lblMIn: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var heightVwDescription: NSLayoutConstraint!
    @IBOutlet weak var imgVwUpload: UIImageView!
    @IBOutlet weak var txtFldGender: UITextField!
    @IBOutlet weak var txtFldEthnicity: UITextField!
    @IBOutlet weak var txtFldZodiac: UITextField!
    @IBOutlet weak var txtFldSmoke: UITextField!
    @IBOutlet weak var txtFldDrink: UITextField!
    @IBOutlet weak var txtFldWorkout: UITextField!
    @IBOutlet weak var txtFldBodytype: UITextField!
    @IBOutlet weak var txtVwDescription: IQTextView!
    @IBOutlet weak var txtFldUserName: UITextField!
    
    //MARK: - VARIABLES
    var isComing = 0
    var viewModel = ProfileVM()
    var userInteraction: Bool = false
    var minValueSelected: Int = 0
    var maxValueSelected: Int = 0
    var genderValues = 0
    var isSelectImage = false
    var callBack:(()->())?
    var uploadProfile = false
    var profileImg = ""
    var userName = ""
    var message = ""
    let characterLimit = 300
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtFldPrice.delegate = self
        uiSet()
        darkMode()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardWhileClick))
                      tapGesture.cancelsTouchesInView = false
                      view.addGestureRecognizer(tapGesture)
           }
           @objc func dismissKeyboardWhileClick() {
                  view.endEditing(true)
              }
    override func viewWillAppear(_ animated: Bool) {
        txtVwDescription.delegate = self
        let thumbImageNormal = UIImage(named: "thumbb")
        sliderr.setThumbImage(thumbImageNormal, for: .normal)
        sliderr.addTarget(self, action: #selector(changeValue), for: .valueChanged)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(sliderTapped))
               self.sliderr.addGestureRecognizer(tapGestureRecognizer)
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
            
            let placeholderColor = UIColor(red: 199/255, green: 199/255, blue: 199/255, alpha: 1.0)
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: placeholderColor
            ]
            txtFldUserName.attributedPlaceholder = NSAttributedString(string: "User name", attributes: attributes)
            txtFldGender.attributedPlaceholder = NSAttributedString(string: "Select gender", attributes: attributes)
            txtFldEthnicity.attributedPlaceholder = NSAttributedString(string: "Select Ethnicity", attributes: attributes)
            txtFldZodiac.attributedPlaceholder = NSAttributedString(string: "Select Zodiac", attributes: attributes)
            txtFldSmoke.attributedPlaceholder = NSAttributedString(string: "Do you Smoke?", attributes: attributes)
            txtFldDrink.attributedPlaceholder = NSAttributedString(string: "Do you Drink?", attributes: attributes)
            txtFldWorkout.attributedPlaceholder = NSAttributedString(string: "Do you Workout?", attributes: attributes)
            txtFldBodytype.attributedPlaceholder = NSAttributedString(string: "Select Bodytype", attributes: attributes)
            txtVwDescription.attributedPlaceholder = NSAttributedString(string: "Description", attributes: attributes)
            
            btnBack.setImage(UIImage(named: "keyboard-backspace25"), for: .normal)
            
            let labels = [
                lblTitleUsername, lblTitleUploadProfile, lblTitleGender, lblTitleEthni,
                lblTitleZodi, lblTitleAge, lblTitlePrice, lblTitleSmoke, lblTitleDrink,
                lblTitleWorkout, lblTitleBodyType, lblTitleDescription, lblTitle,lblMIn,lblMax
            ]

            for label in labels {
                label?.textColor = .white
            }
            
            let textFields = [
                txtFldPrice, txtFldGender, txtFldEthnicity, txtFldZodiac,
                txtFldSmoke, txtFldDrink, txtFldWorkout, txtFldBodytype, txtFldUserName
            ]
            viewDescription.layer.borderColor = UIColor.white.cgColor
            viewDescription.layer.borderWidth = 1.0
            viewDescription.layer.cornerRadius = 5.0
            for textField in textFields {
                textField?.textColor = .white
                textField?.layer.borderColor = UIColor.white.cgColor
                textField?.layer.borderWidth = 1.0
                textField?.layer.cornerRadius = 5.0
            }
            
            
        }else{
            viewDescription.layer.borderColor = UIColor(hex: "#DCDCDC").cgColor
            viewDescription.layer.borderWidth = 1.0
            viewDescription.layer.cornerRadius = 5.0
            let placeholderColor = UIColor(red: 72/255, green: 72/255, blue: 72/255, alpha: 1.0)
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: placeholderColor
            ]
            txtFldUserName.attributedPlaceholder = NSAttributedString(string: "User name", attributes: attributes)
            txtFldGender.attributedPlaceholder = NSAttributedString(string: "Select gender", attributes: attributes)
            txtFldEthnicity.attributedPlaceholder = NSAttributedString(string: "Select Ethnicity", attributes: attributes)
            txtFldZodiac.attributedPlaceholder = NSAttributedString(string: "Select Zodiac", attributes: attributes)
            txtFldSmoke.attributedPlaceholder = NSAttributedString(string: "Do you Smoke?", attributes: attributes)
            txtFldDrink.attributedPlaceholder = NSAttributedString(string: "Do you Drink?", attributes: attributes)
            txtFldWorkout.attributedPlaceholder = NSAttributedString(string: "Do you Workout?", attributes: attributes)
            txtFldBodytype.attributedPlaceholder = NSAttributedString(string: "Select Bodytype", attributes: attributes)
            txtVwDescription.attributedPlaceholder = NSAttributedString(string: "Description", attributes: attributes)
            
            lblMIn.textColor = UIColor(red: 156/255, green: 156/255, blue: 156/255, alpha: 1.0)
            lblMax.textColor = UIColor(red: 156/255, green: 156/255, blue: 156/255, alpha: 1.0)
            btnBack.setImage(UIImage(named: "back"), for: .normal)
            let labels = [
                lblTitleUsername, lblTitleUploadProfile, lblTitleGender, lblTitleEthni,
                lblTitleZodi, lblTitleAge, lblTitlePrice, lblTitleSmoke, lblTitleDrink,
                lblTitleWorkout, lblTitleBodyType, lblTitleDescription, lblTitle
            ]

            for label in labels {
                label?.textColor = .black
            }
            let textFields = [
                txtFldPrice, txtFldGender, txtFldEthnicity, txtFldZodiac,
                txtFldSmoke, txtFldDrink, txtFldWorkout, txtFldBodytype, txtFldUserName
            ]

            for textField in textFields {
                textField?.textColor = .black
                textField?.layer.borderColor = UIColor(hex: "#DCDCDC").cgColor
                textField?.layer.borderWidth = 1.0
                textField?.layer.cornerRadius = 5.0
            }
            
        }
    }
    func uiSet(){
        if isComing == 0{
            gradientVw.startColor = .clear
            gradientVw.endColor = .clear
            btnEditProfilePics.isHidden = true
            btnUploadPhoto.isHidden = false
            lblTitle.text = "Create User Profile"
            btnCreateProfile.setTitle("Create profile", for: .normal)
            btnBack.isHidden = true
            if traitCollection.userInterfaceStyle == .dark {
                imgVwUpload.image = UIImage(named: "Group 1686556762100")
            }else{
                imgVwUpload.image = UIImage(named: "Group 1686557525")
            }
            txtFldUserName.text = userName
        }else{
            if traitCollection.userInterfaceStyle == .dark {
                imgVwUpload.image = UIImage(named: "Group 1686556762100")
            }else{
                imgVwUpload.image = UIImage(named: "Group 1686557525")
            }

            gradientVw.startColor = .appPink
            gradientVw.endColor = .appPurple
            btnUploadPhoto.isHidden = true
            btnEditProfilePics.isHidden = false
            btnBack.isHidden = false
            lblTitle.text = "Edit User Profile"
            btnCreateProfile.setTitle("Update profile", for: .normal)
            getProfileApi()
            
        }
    }
    
    @objc func sliderTapped(gestureRecognizer: UIGestureRecognizer) {
        let pointTapped: CGPoint = gestureRecognizer.location(in: self.view)
        let positionOfSlider: CGPoint = sliderr.frame.origin
        let widthOfSlider: CGFloat = sliderr.frame.size.width
        let newValue = ((pointTapped.x - positionOfSlider.x) * CGFloat(sliderr.maximumValue) / widthOfSlider)
        let clampedValue = max(min(newValue, CGFloat(sliderr.maximumValue)), CGFloat(sliderr.minimumValue))
        
        sliderr.value = Float(clampedValue)
        
        let selectedValue = Int(sliderr.value)
        
        if selectedValue < 18 {
            sliderr.value = 18
            lblSelectAge.text = "Select Age(18)"
        } else {
            lblSelectAge.text = "Select Age(\(selectedValue))"
        }
    }
    @objc func changeValue(slider:ThumbTextSlider){
        let selectedValue = Int(slider.value)
        
        if selectedValue < 18 {
            slider.value = Float(18)
            lblSelectAge.text = "Select Age(18)"
        } else {
            lblSelectAge.text = "Select Age(\(selectedValue))"
        }
    }
    func getProfileApi(){
        if Store.userDetail?["profile"] as? String ?? "" == ""{
            self.imgVwUpload.image = UIImage(named: "user")
            uploadProfile = false
        }else{
            self.imgVwUpload.imageLoad(imageUrl: Store.userDetail?["profile"] as? String ?? "")
            uploadProfile = true
        }
        if Store.userDetail?["gender"] as? Int ?? 0 == 0{
            self.txtFldGender.text = "Male"
        }else if Store.userDetail?["gender"] as? Int ?? 0 == 1{
            self.txtFldGender.text = "Female"
        }else{
            self.txtFldGender.text = "TS"
        }
        
        self.txtFldUserName.text = Store.userDetail?["userName"] as? String ?? ""
        self.txtFldEthnicity.text = Store.userDetail?["ethnicity"] as? String ?? ""
        self.txtFldZodiac.text = Store.userDetail?["zodiac"] as? String ?? ""
        self.txtFldSmoke.text = Store.userDetail?["smoke"] as? String ?? ""
        self.txtFldDrink.text = Store.userDetail?["drink"] as? String ?? ""
        self.txtFldWorkout.text = Store.userDetail?["workout"] as? String ?? ""
        self.txtFldBodytype.text = Store.userDetail?["bodyType"] as? String ?? ""
        self.txtFldPrice.text = "\(Store.userDetail?["hoursPrice"] as? Int ?? 0)"
        self.lblMax.text = "72 Max"
        self.sliderr.value = Float(Store.userDetail?["age"] as? Int ?? 0)
        self.lblSelectAge.text = "Select Age(\(Store.userDetail?["age"] as? Int ?? 0))"
        self.txtVwDescription.text = Store.userDetail?["description"] as? String ?? ""
        
    }
    
    //MARK: - button actions    
    @IBAction func actionEthnicity(_ sender: UIButton) {
        txtFldUserName.resignFirstResponder()
        txtFldPrice.resignFirstResponder()
        txtVwDescription.resignFirstResponder()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfilePopUpsVC") as! ProfilePopUpsVC
        vc.isSelect = 2
        vc.modalPresentationStyle = .popover
        vc.preferredContentSize = CGSize(width: sender.frame.width - 50, height: 260)
        let popOver : UIPopoverPresentationController = vc.popoverPresentationController!
        popOver.sourceView = sender
        popOver.delegate = self
        popOver.permittedArrowDirections = .up
        vc.callBack = { (index,title,selecIndex) in
            sender.tag = index
            self.txtFldEthnicity.text = title
            
        }
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func actionZodiac(_ sender: UIButton) {
        txtFldUserName.resignFirstResponder()
        txtFldPrice.resignFirstResponder()
        txtVwDescription.resignFirstResponder()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfilePopUpsVC") as! ProfilePopUpsVC
        vc.isSelect = 3
        vc.modalPresentationStyle = .popover
        vc.preferredContentSize = CGSize(width: sender.frame.width - 50, height: 150)
        let popOver : UIPopoverPresentationController = vc.popoverPresentationController!
        popOver.sourceView = sender
        popOver.delegate = self
        popOver.permittedArrowDirections = .up
        vc.callBack = { (index,title,selecIndex) in
            sender.tag = index
            self.txtFldZodiac.text = title
            
        }
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func actionSmoke(_ sender: UIButton) {
        txtFldUserName.resignFirstResponder()
        txtFldPrice.resignFirstResponder()
        txtVwDescription.resignFirstResponder()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfilePopUpsVC") as! ProfilePopUpsVC
        vc.isSelect = 4
        vc.modalPresentationStyle = .popover
        vc.preferredContentSize = CGSize(width: sender.frame.width - 50, height: 110)
        let popOver : UIPopoverPresentationController = vc.popoverPresentationController!
        popOver.sourceView = sender
        popOver.delegate = self
        popOver.permittedArrowDirections = .up
        vc.callBack = { (index,title,selecIndex) in
            sender.tag = index
            self.txtFldSmoke.text = title
            
        }
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func actionDrink(_ sender: UIButton) {
        txtFldUserName.resignFirstResponder()
        txtFldPrice.resignFirstResponder()
        txtVwDescription.resignFirstResponder()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfilePopUpsVC") as! ProfilePopUpsVC
        vc.isSelect = 5
        vc.modalPresentationStyle = .popover
        vc.preferredContentSize = CGSize(width: sender.frame.width - 50, height: 110)
        let popOver : UIPopoverPresentationController = vc.popoverPresentationController!
        popOver.sourceView = sender
        popOver.delegate = self
        popOver.permittedArrowDirections = .up
        vc.callBack = { (index,title,selecIndex) in
            sender.tag = index
            self.txtFldDrink.text = title
            
        }
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func actionWorkout(_ sender: UIButton) {
        txtFldUserName.resignFirstResponder()
        txtFldPrice.resignFirstResponder()
        txtVwDescription.resignFirstResponder()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfilePopUpsVC") as! ProfilePopUpsVC
        vc.isSelect = 6
        vc.modalPresentationStyle = .popover
        vc.preferredContentSize = CGSize(width: sender.frame.width - 50, height: 150)
        let popOver : UIPopoverPresentationController = vc.popoverPresentationController!
        popOver.sourceView = sender
        popOver.delegate = self
        popOver.permittedArrowDirections = .up
        vc.callBack = { (index,title,selecIndex) in
            sender.tag = index
            self.txtFldWorkout.text = title
            
        }
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func actionBodytype(_ sender: UIButton) {
        txtFldUserName.resignFirstResponder()
        txtFldPrice.resignFirstResponder()
        txtVwDescription.resignFirstResponder()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfilePopUpsVC") as! ProfilePopUpsVC
        vc.isSelect = 8
        vc.modalPresentationStyle = .popover
        vc.preferredContentSize = CGSize(width: sender.frame.width - 50, height: 185)
        let popOver : UIPopoverPresentationController = vc.popoverPresentationController!
        popOver.sourceView = sender
        popOver.delegate = self
        popOver.permittedArrowDirections = .up
        vc.callBack = { (index,title,selecIndex) in
            sender.tag = index
            self.txtFldBodytype.text = title
            
        }
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func actionGender(_ sender: UIButton) {
        txtFldUserName.resignFirstResponder()
        txtFldPrice.resignFirstResponder()
        txtVwDescription.resignFirstResponder()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfilePopUpsVC") as! ProfilePopUpsVC
        vc.isSelect = 1
        vc.modalPresentationStyle = .popover
        vc.preferredContentSize = CGSize(width: sender.frame.width - 50, height: 120)
        let popOver : UIPopoverPresentationController = vc.popoverPresentationController!
        popOver.sourceView = sender
        popOver.delegate = self
        popOver.permittedArrowDirections = .up
        vc.callBack = { (index,title,selecIndex) in
            sender.tag = index
            if index == 0{
                self.genderValues = 0
                self.txtFldGender.text = title
                print("title:--\(title)")
            }else if index == 1{
                self.genderValues = 1
                self.txtFldGender.text = title
                print("title:--\(title)")
            }else{
                self.genderValues = 3
                self.txtFldGender.text = title
                print("title:--\(title)")
            }
            
            
        }
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func actionEditUploadImage(_ sender: UIButton) {
        txtFldUserName.resignFirstResponder()
        txtFldPrice.resignFirstResponder()
        txtVwDescription.resignFirstResponder()
        ImagePicker().pickImage(self) { image in
            self.uploadProfile = true
            self.imgVwUpload.image = image
            self.isSelectImage = true
        }
        
    }
    @IBAction func actionUploadImage(_ sender: UIButton) {
        txtFldUserName.resignFirstResponder()
        txtFldPrice.resignFirstResponder()
        txtVwDescription.resignFirstResponder()
        ImagePicker().pickImage(self) { image in
            
            self.uploadProfile = true
            self.imgVwUpload.image = image
            self.isSelectImage = true
        }
        
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        txtFldUserName.resignFirstResponder()
        txtFldPrice.resignFirstResponder()
        txtVwDescription.resignFirstResponder()
        if isComing == 1{
            SceneDelegate().tabBarProfileVCRoot()
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func actionCreateProfile(_ sender: GradientButton) {
        txtFldUserName.resignFirstResponder()
        txtFldPrice.resignFirstResponder()
        txtVwDescription.resignFirstResponder()
        if isComing != 1{
            if uploadProfile == false{
                showSwiftyAlert("", "Profile image must be selected.", false)
            }else if txtFldUserName.text == ""{
                    showSwiftyAlert("", "Name must be entered.", false)
            }else  if txtFldUserName.text?.count ?? 0 < 3 || txtFldUserName.text?.count ?? 0 > 30{
                showSwiftyAlert("", "Name must be between 3 and 30 characters long.", false)
            }else if txtFldGender.text == "" {
                showSwiftyAlert("", "Gender must be selected.", false)
            } else if txtFldEthnicity.text == "" {
                showSwiftyAlert("", "Ethnicity must be selected.", false)
            } else if txtFldZodiac.text == "" {
                showSwiftyAlert("", "Zodiac must be selected.", false)
            } else if lblMax.text == "0"{
                showSwiftyAlert("", "Age must be selected.", false)
            } else if txtFldPrice.text == ""{
                showSwiftyAlert("", "Please enter your hourly price.", false)
            }else if txtFldSmoke.text == "" {
                showSwiftyAlert("", "Smoking habit must be selected.", false)
            } else if txtFldDrink.text == "" {
                showSwiftyAlert("", "Drinking habit must be selected.", false)
            } else if txtFldWorkout.text == "" {
                showSwiftyAlert("", "Workout habit must be selected.", false)
            } else if txtFldBodytype.text == "" {
                showSwiftyAlert("", "Body type must be selected.", false)
            } else if txtVwDescription.text == "" {
                showSwiftyAlert("", "Description must be entered.", false)
            } else {
                
                viewModel.setProfileDetailApi(name: txtFldUserName.text ?? "",
                                              about: txtVwDescription.text ?? "",
                                              gender: genderValues,
                                              ethnicity: txtFldEthnicity.text ?? "",
                                              zodiac: txtFldZodiac.text ?? "",
                                              age: Int(sliderr.value),
                                              smoke: txtFldSmoke.text ?? "",
                                              drink: txtFldDrink.text ?? "",
                                              workout: txtFldWorkout.text ?? "",
                                              bodytype: txtFldBodytype.text ?? "", price: txtFldPrice.text ?? "",
                                              profileImage: imgVwUpload, imageUpload: uploadProfile) { data in
                    self.viewModel.getProfileApi { data in
                        
                        let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "ConfirmEmailVC") as! ConfirmEmailVC
                        Store.autoLogin = "true"
                        self.navigationController?.pushViewController(vc2, animated:true)
                        
                    }
                    
                }
                
            }
            
        }else if isComing == 1{
            if uploadProfile == false{
                showSwiftyAlert("", "Profile image must be selected.", false)
            }else if txtFldUserName.text == "" {
                    showSwiftyAlert("", "Name must be entered.", false)
            }else  if txtFldUserName.text?.count ?? 0 < 3 || txtFldUserName.text?.count ?? 0 > 30{
                showSwiftyAlert("", "Name must be between 3 and 30 characters long.", false)
            }else if txtFldGender.text == "" {
                showSwiftyAlert("", "Gender must be selected.", false)
            } else if txtFldEthnicity.text == "" {
                showSwiftyAlert("", "Ethnicity must be selected.", false)
            } else if txtFldZodiac.text == "" {
                showSwiftyAlert("", "Zodiac must be selected.", false)
            } else if lblMax.text == "0"{
                showSwiftyAlert("", "Age must be selected.", false)
            } else if txtFldPrice.text == ""{
                showSwiftyAlert("", "Please enter your hourly price.", false)
            }else if txtFldSmoke.text == "" {
                showSwiftyAlert("", "Smoking habit must be selected.", false)
            } else if txtFldDrink.text == "" {
                showSwiftyAlert("", "Drinking habit must be selected.", false)
            } else if txtFldWorkout.text == "" {
                showSwiftyAlert("", "Workout habit must be selected.", false)
            } else if txtFldBodytype.text == "" {
                showSwiftyAlert("", "Body type must be selected.", false)
            } else if txtVwDescription.text == "" {
                showSwiftyAlert("", "Description must be entered.", false)
            } else {
                
                viewModel.setProfileDetailApi(name: txtFldUserName.text ?? "",
                                              about: txtVwDescription.text ?? "",
                                              gender: genderValues,
                                              ethnicity: txtFldEthnicity.text ?? "",
                                              zodiac: txtFldZodiac.text ?? "",
                                              age: Int(sliderr.value),
                                              smoke: txtFldSmoke.text ?? "",
                                              drink: txtFldDrink.text ?? "",
                                              workout: txtFldWorkout.text ?? "",
                                              bodytype: txtFldBodytype.text ?? "", price: txtFldPrice.text ?? "",
                                              profileImage: imgVwUpload, imageUpload: uploadProfile) { data in
                    self.message = data?.message ?? ""
                    self.viewModel.getProfileApi { data in
                        
                        //                self.navigationController?.popViewController(animated: true)
                      
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
                        vc.modalPresentationStyle = .overFullScreen
                        vc.message = self.message
                        vc.callBack = {
                            SceneDelegate().tabBarProfileVCRoot()
                            self.callBack?()
                        }
                        self.navigationController?.present(vc, animated: false)
                        
                    }
                    
                }
                
            }
            
        }else{
            
            if uploadProfile == false{
                showSwiftyAlert("", "Profile image must be selected.", false)
            }else if txtFldUserName.text == "" {
                showSwiftyAlert("", "Name must be entered.", false)
            }else if txtFldGender.text == "" {
                showSwiftyAlert("", "Gender must be selected.", false)
            } else if txtFldEthnicity.text == "" {
                showSwiftyAlert("", "Ethnicity must be selected.", false)
            } else if txtFldZodiac.text == "" {
                showSwiftyAlert("", "Zodiac must be selected.", false)
            } else if lblMax.text == "0"{
                showSwiftyAlert("", "Age must be selected.", false)
            } else if txtFldPrice.text == ""{
                showSwiftyAlert("", "Please enter your hourly price.", false)
            }else if txtFldSmoke.text == "" {
                showSwiftyAlert("", "Smoking habit must be selected.", false)
            } else if txtFldDrink.text == "" {
                showSwiftyAlert("", "Drinking habit must be selected.", false)
            } else if txtFldWorkout.text == "" {
                showSwiftyAlert("", "Workout habit must be selected.", false)
            } else if txtFldBodytype.text == "" {
                showSwiftyAlert("", "Body type must be selected.", false)
            } else if txtVwDescription.text == "" {
                showSwiftyAlert("", "Description must be entered.", false)
            } else {
                
                viewModel.setProfileDetailApi(name: txtFldUserName.text ?? "",
                                              about: txtVwDescription.text ?? "",
                                              gender: genderValues,
                                              ethnicity: txtFldEthnicity.text ?? "",
                                              zodiac: txtFldZodiac.text ?? "",
                                              age: Int(sliderr.value),
                                              smoke: txtFldSmoke.text ?? "",
                                              drink: txtFldDrink.text ?? "",
                                              workout: txtFldWorkout.text ?? "",
                                              bodytype: txtFldBodytype.text ?? "", price: txtFldPrice.text ?? "",
                                              profileImage: imgVwUpload, imageUpload: uploadProfile) { data in
                    self.viewModel.getProfileApi { data in
                     
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
                        vc.modalPresentationStyle = .overFullScreen
                        vc.message = data?.message ?? ""
                        vc.callBack = {
                            let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "NewTabBarVC") as! NewTabBarVC
                            Store.autoLogin = "true"
                            vc2.isComing = false
                           
                            self.navigationController?.pushViewController(vc2, animated:true)
                        }
                        self.navigationController?.present(vc, animated: false)
                        
                    }
                    
                    
                    
                    
                }
                
            }
            
        }
        
        
    }
}
extension ProfileDetailVC:UITextFieldDelegate{
   
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if textField == txtFldPrice{
                let allowedCharacters = "0123456789"
                let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
                let typedCharacterSet = CharacterSet(charactersIn: string)
                let alphabet = allowedCharacterSet.isSuperset(of: typedCharacterSet)
                return alphabet
                        
                    }
            return true
           
        }
    //    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    //           // Check which text field is being edited
    //           switch textField {
    //           case txtFldUserName, txtFldGender, txtFldEthnicity, txtFldZodiac, txtFldSmoke, txtFldDrink, txtFldWorkout, txtFldBodytype:
    //               // Present your ProfilePopUpsVC here
    //               presentProfilePopUpsVC()
    //               return false // Prevent the text field from being edited directly
    //           default:
    //               return true
    //           }
    //       }
    //
    //       // Function to present ProfilePopUpsVC
    //       func presentProfilePopUpsVC() {
    //
    //       }
    
}
// MARK: - Popup
extension ProfileDetailVC : UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    //UIPopoverPresentationControllerDelegate
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
    }
}

extension ProfileDetailVC:UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
          // Combine the current text with the new text to simulate the result
          let currentText = txtVwDescription.text ?? ""
          guard let stringRange = Range(range, in: currentText) else { return false }
          let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
          
          // Check if the new text exceeds the limit
          return updatedText.count <= characterLimit
      }
}
