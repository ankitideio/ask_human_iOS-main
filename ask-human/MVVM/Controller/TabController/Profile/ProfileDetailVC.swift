//
//  ProfileDetailVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 07/12/23.
//

import UIKit
import IQKeyboardManagerSwift
import AlignedCollectionViewFlowLayout
import VisionKit


class ProfileDetailVC: UIViewController{
    
    //MARK: - OUTLETS
    @IBOutlet var txtFldIdAuthType: UITextField!
    @IBOutlet var lblAuthIdTitle: UILabel!
    @IBOutlet var btnIdAuth: UIButton!
    @IBOutlet var lblZodiac: UILabel!
    @IBOutlet var lblAgeDocument: UILabel!
    @IBOutlet var lblCountry: UILabel!
    @IBOutlet var lblGender: UILabel!
    @IBOutlet var viewDocumentUserDetails: UIView!
    @IBOutlet var imgVwDocument: UIImageView!
    @IBOutlet var btnDocumentUpload: UIButton!
    @IBOutlet var lblAddHashtag: UILabel!
    @IBOutlet var btnVerifyhashtag: UIButton!
    @IBOutlet var lblDateofbirth: UILabel!
    @IBOutlet var lblAge: UILabel!
    @IBOutlet var txtFldDateofbirth: UITextField!
    @IBOutlet var heightCollVwSuggestHashtag: NSLayoutConstraint!
    @IBOutlet var txtfldHashtag: UITextField!
    @IBOutlet var collVwSuggestHashtag: UICollectionView!
    @IBOutlet var heighCollvwHAshtag: NSLayoutConstraint!
    @IBOutlet var collVwHashtag: UICollectionView!
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
    var uploadDocument = false
    var profileImg = ""
    var userName = ""
    var message = ""
    let characterLimit = 300
    var arrHashtags = [Hashtag]()
    var arrSuggestHashtags = [GetSearchHashtagData]()
    var selectedAge:Int?
    var selectedIdType = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSet()
        darkMode()
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
    private func updateCollectionViewHeight() {
        updateHeight(for: collVwHashtag, constraint: heighCollvwHAshtag)
            updateHeight(for: collVwSuggestHashtag, constraint: heightCollVwSuggestHashtag)
        }
        
        private func updateHeight(for collectionView: UICollectionView, constraint: NSLayoutConstraint) {
            collectionView.layoutIfNeeded()
            constraint.constant = collectionView.contentSize.height
        }
        
    func getSearchHashtags(searchText:String){
            viewModel.getSearchHashtagApi(searchBy: searchText) { data
                in
                self.arrSuggestHashtags = data
                self.collVwSuggestHashtag.reloadData()
                    self.updateCollectionViewHeight()
                self.updateheightCollVwSuggestHashtags()
                    }
            }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            darkMode()
            
        }
    }
    
    func uiSet(){
        lblCountry.text = Store.nationality
        txtFldPrice.delegate = self
        txtfldHashtag.delegate = self
        txtFldDateofbirth.delegate = self

        setupDatePicker(for: txtFldDateofbirth, mode: .date, selector: #selector(dateOfBirth))
        let nib = UINib(nibName: "HashtagCVC", bundle: nil)
        collVwHashtag.register(nib, forCellWithReuseIdentifier: "HashtagCVC")
        let nib2 = UINib(nibName: "HashtagCVC", bundle: nil)
        collVwSuggestHashtag.register(nib2, forCellWithReuseIdentifier: "HashtagCVC")
        let alignedFlowLayoutCollVwHashtag = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .top)
        collVwHashtag.collectionViewLayout = alignedFlowLayoutCollVwHashtag
        let alignedFlowLayoutCollVwHashtag2 = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .top)
        collVwSuggestHashtag.collectionViewLayout = alignedFlowLayoutCollVwHashtag2
        
        if let flowLayout = collVwHashtag.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 0, height: 50)
            flowLayout.itemSize = UICollectionViewFlowLayout.automaticSize
        }
        if let flowLayoutSuggest = collVwSuggestHashtag.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayoutSuggest.estimatedItemSize = CGSize(width: 0, height: 50)
            flowLayoutSuggest.itemSize = UICollectionViewFlowLayout.automaticSize
        }
       
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM, yyyy"
            let currentDate = Date()
            txtFldDateofbirth.text = dateFormatter.string(from: currentDate)
//        if isComing == 0{
//            btnVerifyhashtag.isHidden = true
//            gradientVw.startColor = .clear
//            gradientVw.endColor = .clear
//            btnEditProfilePics.isHidden = true
//            btnUploadPhoto.isHidden = false
//            lblTitle.text = "Create User Profile"
//            btnCreateProfile.setTitle("Create profile", for: .normal)
//            btnBack.isHidden = true
//            if traitCollection.userInterfaceStyle == .dark {
//                imgVwUpload.image = UIImage(named: "Group 1686556762100")
//            }else{
//                imgVwUpload.image = UIImage(named: "Group 1686557525")
//            }
//            txtFldUserName.text = userName
//        }else{
            btnVerifyhashtag.isHidden = false
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
            
      //  }
        collVwHashtag.reloadData()
        collVwSuggestHashtag.reloadData()
        updateheightCollVwHashtags()
        updateHeight(for: collVwHashtag, constraint: heighCollvwHAshtag)

    }
    func darkMode(){
        if traitCollection.userInterfaceStyle == .dark {
            let placeholderColor = UIColor(red: 199/255, green: 199/255, blue: 199/255, alpha: 1.0)
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: placeholderColor
            ]
            txtFldPrice.attributedPlaceholder = NSAttributedString(string: "Hourly Price", attributes: attributes)
            txtFldIdAuthType.attributedPlaceholder = NSAttributedString(string: "Choose ID to authenticate", attributes: attributes)
            txtfldHashtag.attributedPlaceholder = NSAttributedString(string: "# Add hashtags", attributes: attributes)
            txtFldDateofbirth.attributedPlaceholder = NSAttributedString(string: "Date of birth", attributes: attributes)
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
                lblTitleZodi, lblTitleAge, lblTitlePrice, lblTitleSmoke, lblTitleDrink,lblAuthIdTitle,
                lblTitleWorkout, lblTitleBodyType, lblTitleDescription, lblTitle,lblMIn,lblMax,lblDateofbirth,lblAge,lblAddHashtag
            ]

            for label in labels {
                label?.textColor = .white
            }
            let textFields = [
                txtFldPrice, txtFldGender, txtFldEthnicity, txtFldZodiac,txtFldIdAuthType,
                txtFldSmoke, txtFldDrink, txtFldWorkout, txtFldBodytype, txtFldUserName,txtFldDateofbirth
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
            let placeholderColor = UIColor.placeholder
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: placeholderColor
            ]
            txtFldIdAuthType.attributedPlaceholder = NSAttributedString(string: "Choose ID to authenticate", attributes: attributes)
            txtFldPrice.attributedPlaceholder = NSAttributedString(string: "Hourly Price", attributes: attributes)
            txtFldDateofbirth.attributedPlaceholder = NSAttributedString(string: "Date of birth", attributes: attributes)
            txtfldHashtag.attributedPlaceholder = NSAttributedString(string: "# Add hashtags", attributes: attributes)
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
                lblTitleZodi, lblTitleAge, lblTitlePrice, lblTitleSmoke, lblTitleDrink,lblAuthIdTitle,
                lblTitleWorkout, lblTitleBodyType, lblTitleDescription, lblTitle,lblAge,lblDateofbirth,lblAddHashtag
            ]

            for label in labels {
                label?.textColor = .black
            }
            let textFields = [
                txtFldPrice, txtFldGender, txtFldEthnicity, txtFldZodiac,txtFldIdAuthType,
                txtFldSmoke, txtFldDrink, txtFldWorkout, txtFldBodytype, txtFldUserName,txtFldDateofbirth
            ]

            for textField in textFields {
                textField?.textColor = .black
                textField?.layer.borderColor = UIColor(hex: "#DCDCDC").cgColor
                textField?.layer.borderWidth = 1.0
                textField?.layer.cornerRadius = 5.0
            }
            
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
            self.lblGender.text = "Male"
        }else if Store.userDetail?["gender"] as? Int ?? 0 == 1{
            self.txtFldGender.text = "Female"
            self.lblGender.text = "Female"
        }else{
            self.txtFldGender.text = "TS"
            self.lblGender.text = "TS"
        }
        if Store.userDetail?["document"] as? String ?? "" == ""{
            viewDocumentUserDetails.isHidden = true
            btnDocumentUpload.setImage(UIImage(named: "camera"), for: .normal)
            uploadDocument = false
        }else{
            btnDocumentUpload.setImage(UIImage(named: "edit 1"), for: .normal)
            viewDocumentUserDetails.isHidden = false
            imgVwDocument.imageLoad(imageUrl: Store.userDetail?["document"] as? String ?? "")
            uploadDocument = true
        }
        if Store.userDetail?["identity"] as? Int == 0{
            txtFldIdAuthType.text =  "Passport"
        }else if Store.userDetail?["identity"] as? Int == 1{
            txtFldIdAuthType.text =  "Driving Licence"
        }else if Store.userDetail?["identity"] as? Int == 2{
            txtFldIdAuthType.text =  "Country ID"
        }else{
            txtFldIdAuthType.text =  ""
        }
        self.txtFldUserName.text = Store.userDetail?["userName"] as? String ?? ""
        self.txtFldDateofbirth.text = Store.userDetail?["dob"] as? String ?? ""
        self.txtFldEthnicity.text = Store.userDetail?["ethnicity"] as? String ?? ""
        
        self.txtFldZodiac.text = Store.userDetail?["zodiac"] as? String ?? ""
        self.txtFldSmoke.text = Store.userDetail?["smoke"] as? String ?? ""
        self.txtFldDrink.text = Store.userDetail?["drink"] as? String ?? ""
        self.txtFldWorkout.text = Store.userDetail?["workout"] as? String ?? ""
        self.txtFldBodytype.text = Store.userDetail?["bodyType"] as? String ?? ""
        if Store.userDetail?["hoursPrice"] as? Int ?? 0 > 0{
            self.txtFldPrice.text = "\(Store.userDetail?["hoursPrice"] as? Int ?? 0)"
        }else{
            self.txtFldPrice.text = ""
        }
        self.lblMax.text = "72 Max"
        self.sliderr.value = Float(Store.userDetail?["age"] as? Int ?? 0)
        self.lblAge.text =  "\(Store.userDetail?["age"] as? Int ?? 0) Years age" 
        selectedAge = Store.userDetail?["age"] as? Int ?? 0
        lblAgeDocument.text = "\(Store.userDetail?["age"] as? Int ?? 0)"
        self.txtVwDescription.text = Store.userDetail?["description"] as? String ?? ""
        arrHashtags = Store.Hashtags?.data?.user?.hashtags ?? []
       
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
    //MARK: - button actions
    @IBAction func actionChooseIdtype(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfilePopUpsVC") as! ProfilePopUpsVC
        vc.isSelect = 13
        vc.modalPresentationStyle = .popover
        vc.preferredContentSize = CGSize(width: sender.frame.width, height: 110)
        vc.filterIndex = filterIndex
        let popOver : UIPopoverPresentationController = vc.popoverPresentationController!
        popOver.sourceView = sender
        popOver.delegate = self
        popOver.permittedArrowDirections = .up
        vc.callBack = { (index,title,selectIndex) in
            self.txtFldIdAuthType.text = title
            self.selectedIdType = index
        }
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func actionDocumentUpload(_ sender: UIButton) {
        
        if txtFldIdAuthType.text == ""{
            showSwiftyAlert("", "Please select a valid ID for authentication.", false)
        }else{
            openDocumentScanner()
        }
    }
    private func openDocumentScanner() {
            if VNDocumentCameraViewController.isSupported {
                let documentCameraViewController = VNDocumentCameraViewController()
                documentCameraViewController.delegate = self
                documentCameraViewController.view.tintColor = .app
                
                present(documentCameraViewController, animated: true, completion: nil)
            } else {
                // Handle the case where the device does not support scanning
                let alert = UIAlertController(title: "Not Supported",
                                              message: "This device does not support document scanning.",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        }
        
    @IBAction func actionVerifyHashtag(_ sender: UIButton) {
        var validHashtags = [Hashtag]()
        var invalidHashtagIndices = [Int]()
        for (index, hashtag) in arrHashtags.enumerated() {
            if let id = hashtag.id, !id.isEmpty {
                let newHashtag = Hashtag(id: id, title: hashtag.title ?? "", userIDS: [""], isVerified:  hashtag.isVerified ?? 0, usedCount: hashtag.usedCount ?? 0, createdBy: "", createdAt: "", updatedAt: "")
                validHashtags.append(newHashtag)
            } else {
                invalidHashtagIndices.append(index)
            }
        }
        
        
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HashtagListVC") as! HashtagListVC
                vc.modalPresentationStyle = .overFullScreen
                vc.arrNewHashtags = validHashtags
                vc.callBack = {
                    self.uiSet()
                }
                self.present(vc, animated: true)
            }
        
    }
    @IBAction func actionEthnicity(_ sender: UIButton) {
        view.endEditing(true)
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
//        txtFldUserName.resignFirstResponder()
//        txtFldPrice.resignFirstResponder()
//        txtVwDescription.resignFirstResponder()
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfilePopUpsVC") as! ProfilePopUpsVC
//        vc.isSelect = 3
//        vc.modalPresentationStyle = .popover
//        vc.preferredContentSize = CGSize(width: sender.frame.width - 50, height: 150)
//        let popOver : UIPopoverPresentationController = vc.popoverPresentationController!
//        popOver.sourceView = sender
//        popOver.delegate = self
//        popOver.permittedArrowDirections = .up
//        vc.callBack = { (index,title,selecIndex) in
//            sender.tag = index
//            self.txtFldZodiac.text = title
//
//        }
//        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func actionSmoke(_ sender: UIButton) {
        view.endEditing(true)
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
        view.endEditing(true)
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
        view.endEditing(true)
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
        view.endEditing(true)
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
        view.endEditing(true)
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
        view.endEditing(true)
        ImagePicker().pickImage(self) { image in
            self.uploadProfile = true
            self.imgVwUpload.image = image
            self.isSelectImage = true
        }
        
    }
    @IBAction func actionUploadImage(_ sender: UIButton) {
        view.endEditing(true)
        ImagePicker().pickImage(self) { image in
            
            self.uploadProfile = true
            self.imgVwUpload.image = image
            self.isSelectImage = true
        }
        
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        view.endEditing(true)
        if isComing == 1{
            SceneDelegate().tabBarProfileVCRoot()
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func actionCreateProfile(_ sender: GradientButton) {
//        print(selectedAge)
//        txtFldUserName.resignFirstResponder()
//        txtFldPrice.resignFirstResponder()
//        txtVwDescription.resignFirstResponder()
//        if isComing != 1{
//            if uploadProfile == false{
//                showSwiftyAlert("", "Profile image must be selected.", false)
//            }else if txtFldUserName.text == ""{
//                    showSwiftyAlert("", "Name must be entered.", false)
//            }else  if txtFldUserName.text?.count ?? 0 < 3 || txtFldUserName.text?.count ?? 0 > 30{
//                showSwiftyAlert("", "Name must be between 3 and 30 characters long.", false)
//            }else if txtFldGender.text == "" {
//                showSwiftyAlert("", "Gender must be selected.", false)
//            } else if txtFldDateofbirth.text == ""{
//                showSwiftyAlert("", "Date of birth must be selected.", false)
//            }else if selectedAge ?? 0 < 11 {
//                showSwiftyAlert("", "You must be at least 11 years old to proceed.", false)
//            } else if txtFldEthnicity.text == "" {
//                showSwiftyAlert("", "Ethnicity must be selected.", false)
//            } else if txtFldZodiac.text == "" {
//                showSwiftyAlert("", "Zodiac must be selected.", false)
//            } else if txtFldPrice.text == ""{
//                showSwiftyAlert("", "Please enter your hourly price.", false)
//            }else if txtFldSmoke.text == "" {
//                showSwiftyAlert("", "Smoking habit must be selected.", false)
//            } else if txtFldDrink.text == "" {
//                showSwiftyAlert("", "Drinking habit must be selected.", false)
//            } else if txtFldWorkout.text == "" {
//                showSwiftyAlert("", "Workout habit must be selected.", false)
//            } else if txtFldBodytype.text == "" {
//                showSwiftyAlert("", "Body type must be selected.", false)
//            }
////            else if txtVwDescription.text == "" {
////                showSwiftyAlert("", "Description must be entered.", false)
////            }
//            else {
//                
//                viewModel.setProfileDetailApi(name: txtFldUserName.text ?? "",
//                                              about: txtVwDescription.text ?? "",
//                                              gender: genderValues,
//                                              ethnicity: txtFldEthnicity.text ?? "",
//                                              zodiac: txtFldZodiac.text ?? "",
//                                              age: selectedAge ?? 0, dob: txtFldDateofbirth.text ?? "",
//                                              smoke: txtFldSmoke.text ?? "",
//                                              drink: txtFldDrink.text ?? "",
//                                              workout: txtFldWorkout.text ?? "",
//                                              bodytype: txtFldBodytype.text ?? "", price: txtFldPrice.text ?? "",
//                                              profileImage: imgVwUpload, imageUpload: uploadProfile, hashtags: [arrHashtags]) { data in
//                    self.viewModel.getProfileApi { data in
//                        
//                        let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "ConfirmEmailVC") as! ConfirmEmailVC
//                        Store.autoLogin = "true"
//                        self.navigationController?.pushViewController(vc2, animated:true)
//                        
//                    }
//                    
//                }
//                
//            }
//            
//        }else if isComing == 1{
//            if uploadProfile == false{
//                showSwiftyAlert("", "Profile image must be selected.", false)
//            }else if txtFldUserName.text == "" {
//                    showSwiftyAlert("", "Name must be entered.", false)
//            }else  if txtFldUserName.text?.count ?? 0 < 3 || txtFldUserName.text?.count ?? 0 > 30{
//                showSwiftyAlert("", "Name must be between 3 and 30 characters long.", false)
//            }else if txtFldGender.text == "" {
//                showSwiftyAlert("", "Gender must be selected.", false)
//            } else if txtFldDateofbirth.text == ""{
//                showSwiftyAlert("", "Date of birth must be selected.", false)
//            }else if selectedAge ?? 0 < 11 {
//                showSwiftyAlert("", "You must be at least 11 years old to proceed.", false)
//            }  else if txtFldEthnicity.text == "" {
//                showSwiftyAlert("", "Ethnicity must be selected.", false)
//            } else if txtFldZodiac.text == "" {
//                showSwiftyAlert("", "Zodiac must be selected.", false)
//            }else if txtFldPrice.text == ""{
//                showSwiftyAlert("", "Please enter your hourly price.", false)
//            }else if txtFldSmoke.text == "" {
//                showSwiftyAlert("", "Smoking habit must be selected.", false)
//            } else if txtFldDrink.text == "" {
//                showSwiftyAlert("", "Drinking habit must be selected.", false)
//            } else if txtFldWorkout.text == "" {
//                showSwiftyAlert("", "Workout habit must be selected.", false)
//            } else if txtFldBodytype.text == "" {
//                showSwiftyAlert("", "Body type must be selected.", false)
//            }  else {
//                
                viewModel.setProfileDetailApi(name: txtFldUserName.text ?? "",
                                              about: txtVwDescription.text ?? "",
                                              gender: genderValues,
                                              ethnicity: txtFldEthnicity.text ?? "",
                                              zodiac: txtFldZodiac.text ?? "",
                                              age: selectedAge ?? 0, dob: txtFldDateofbirth.text ?? "",
                                              smoke: txtFldSmoke.text ?? "",
                                              drink: txtFldDrink.text ?? "",
                                              workout: txtFldWorkout.text ?? "",
                                              bodytype: txtFldBodytype.text ?? "", hoursPrice:txtFldPrice.text ?? "",
                                              countryCode:Store.userDetail?["countryCode"] as? String ?? "",
                                              nationality: Store.nationality ?? "",
                                              identity:selectedIdType,
                                              profileImage: imgVwUpload,
                                              document: imgVwDocument, imageUpload: uploadProfile, uploadDocument: uploadDocument, hashtags: [arrHashtags]) { data in
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
                
         //   }
            
//        }else{
//            
//            if uploadProfile == false{
//                showSwiftyAlert("", "Profile image must be selected.", false)
//            }else if txtFldUserName.text == "" {
//                showSwiftyAlert("", "Name must be entered.", false)
//            }else if txtFldGender.text == "" {
//                showSwiftyAlert("", "Gender must be selected.", false)
//            }else if txtFldDateofbirth.text == ""{
//                showSwiftyAlert("", "Date of birth must be selected.", false)
//            }else if selectedAge ?? 0 < 11 {
//                showSwiftyAlert("", "You must be at least 11 years old to proceed.", false)
//            } else if txtFldEthnicity.text == "" {
//                showSwiftyAlert("", "Ethnicity must be selected.", false)
//            } else if txtFldZodiac.text == "" {
//                showSwiftyAlert("", "Zodiac must be selected.", false)
//            }  else if txtFldPrice.text == ""{
//                showSwiftyAlert("", "Please enter your hourly price.", false)
//            }else if txtFldSmoke.text == "" {
//                showSwiftyAlert("", "Smoking habit must be selected.", false)
//            } else if txtFldDrink.text == "" {
//                showSwiftyAlert("", "Drinking habit must be selected.", false)
//            } else if txtFldWorkout.text == "" {
//                showSwiftyAlert("", "Workout habit must be selected.", false)
//            } else if txtFldBodytype.text == "" {
//                showSwiftyAlert("", "Body type must be selected.", false)
//            }else {
//                
//                viewModel.setProfileDetailApi(name: txtFldUserName.text ?? "",
//                                              about: txtVwDescription.text ?? "",
//                                              gender: genderValues,
//                                              ethnicity: txtFldEthnicity.text ?? "",
//                                              zodiac: txtFldZodiac.text ?? "",
//                                              age: selectedAge ?? 0, dob: txtFldDateofbirth.text ?? "",
//                                              smoke: txtFldSmoke.text ?? "",
//                                              drink: txtFldDrink.text ?? "",
//                                              workout: txtFldWorkout.text ?? "",
//                                              bodytype: txtFldBodytype.text ?? "", price: txtFldPrice.text ?? "",
//                                              profileImage: imgVwUpload, imageUpload: uploadProfile, hashtags: [arrHashtags]) { data in
//                    self.viewModel.getProfileApi { data in
//                     
//                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
//                        vc.modalPresentationStyle = .overFullScreen
//                        vc.message = data?.message ?? ""
//                        vc.callBack = {
//                            let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "NewTabBarVC") as! NewTabBarVC
//                            Store.autoLogin = "true"
//                            vc2.isComing = false
//                           
//                            self.navigationController?.pushViewController(vc2, animated:true)
//                        }
//                        self.navigationController?.present(vc, animated: false)
//                        
//                    }
//                }
//            }
//        }
    }
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
// MARK: - UITextViewDelegate
extension ProfileDetailVC:UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
          let currentText = txtVwDescription.text ?? ""
          guard let stringRange = Range(range, in: currentText) else { return false }
          let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
          return updatedText.count <= characterLimit
      }
}

// MARK: - UITextFieldDelegate
extension ProfileDetailVC:UITextFieldDelegate{
    
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if textField == txtfldHashtag{
                guard let text = textField.text, !text.isEmpty else { return false }
                let existingHashtag = arrHashtags.first { $0.title?.lowercased() == text.lowercased() }
                         if existingHashtag == nil {
                             let newHashtag = Hashtag(id: "", title: text, userIDS: [""], isVerified:  nil, usedCount: nil, createdBy: "", createdAt: "", updatedAt: "")
                             arrHashtags.append(newHashtag)
                         } else {
                             print("Hashtag already exists")
                         }
                collVwHashtag.reloadData()
                updateCollectionViewHeight()
                textField.text = ""
                textField.resignFirstResponder()
            }
            return true
        }
    
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if textField == txtFldPrice{
                let allowedCharacters = "0123456789"
                let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
                let typedCharacterSet = CharacterSet(charactersIn: string)
                let alphabet = allowedCharacterSet.isSuperset(of: typedCharacterSet)
                return alphabet
                        
            }else if textField == txtfldHashtag{
                let currentText = (textField.text ?? "") as NSString
                        let newText = currentText.replacingCharacters(in: range, with: string)
                print("newText:--\(newText)")
                if newText == ""{
                    DispatchQueue.main.asyncAfter(deadline: .now()+2.0){
                        self.arrSuggestHashtags.removeAll()
                        self.collVwSuggestHashtag.reloadData()
                        self.updateheightCollVwSuggestHashtags()
                    }
                }else{
                    getSearchHashtags(searchText: newText)
                }
            }
            return true
           
        }
    
}
//MARK: - COLLECTIONVIEW DELEGATE AND DATASOURCE
extension ProfileDetailVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collVwHashtag{
            return arrHashtags.count
        }else{
            return  arrSuggestHashtags.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HashtagCVC", for: indexPath) as! HashtagCVC
        if collectionView == collVwHashtag{
            cell.viewBtnDelete.isHidden = false
            cell.viewHashtagCount.isHidden = true
            cell.viewBtnDelete.setGradientBackground(
                colors: [UIColor(hex: "#F10B81"), UIColor(hex: "#950D98")],
                startPoint: CGPoint(x: 0.0, y: 0.0),
                endPoint: CGPoint(x: 1.0, y: 1.0)
            )
            cell.btnDelete.tag = indexPath.row
            cell.btnDelete.addTarget(self, action: #selector(actionDelete), for: .touchUpInside)
           
            if arrHashtags[indexPath.row].isVerified == 1{
                cell.widthImgVerify.constant = 14
            }else{
                cell.widthImgVerify.constant = 0
            }

            cell.btnDelete.setImage(UIImage(named: "whiteee"), for: .normal)
            cell.lblHashtag.text = "#\(arrHashtags[indexPath.row].title ?? "")"
            
        }else{
            cell.viewBtnDelete.isHidden = true
            cell.viewHashtagCount.isHidden = false
            cell.lblHashtag.text = "#\(arrSuggestHashtags[indexPath.row].title ?? "")"
            if arrSuggestHashtags[indexPath.row].isVerified == 1{
                cell.widthImgVerify.constant = 14
            }else{
                cell.widthImgVerify.constant = 0
            }
            
            cell.viewHashtagCount.setGradientBackground(
                colors: [UIColor(hex: "#F10B81"), UIColor(hex: "#950D98")],
                startPoint: CGPoint(x: 0.0, y: 0.0),
                endPoint: CGPoint(x: 1.0, y: 1.0)
            )
            if arrSuggestHashtags[indexPath.row].usedCount == 0{
                cell.viewHashtagCount.isHidden = true
            }else if arrSuggestHashtags[indexPath.row].usedCount ?? 0 < 100{
                cell.viewHashtagCount.isHidden = false
                cell.viewHashtagCount.layer.cornerRadius = 10
                cell.widthViewLblCount.constant = 20
                cell.heightViewLblCount.constant = 20

            }else{
                cell.viewHashtagCount.isHidden = false
                cell.viewHashtagCount.layer.cornerRadius = 12.5
                cell.widthViewLblCount.constant = 25
                cell.heightViewLblCount.constant = 25
            }
            cell.lblHashtagCount.text = formatUsedCount(arrSuggestHashtags[indexPath.row].usedCount ?? 0)
            
        }
        return cell
    }
    func formatUsedCount(_ count: Int) -> String {
        if count >= 1_000_000 {
            return "\(count / 1_000_000)M+"
        } else if count >= 1_000 {
            return "\(count / 1_000)K+"
        } else if count % 100 == 0 {
            return "\(count)"
        } else if count > 100 {
            return "\(count / 100 * 100)+"
        } else {
            return "\(count)"
        }
    }

    @objc func actionDelete(sender:UIButton){
        view.endEditing(true)
        arrHashtags.remove(at: sender.tag)
        collVwHashtag.reloadData()
        updateCollectionViewHeight()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collVwSuggestHashtag {
            view.endEditing(true)
            let selectedHashtag = arrSuggestHashtags[indexPath.row]
            let exists = arrHashtags.contains { $0.title == selectedHashtag.title }
            if !exists {
                let newHashtag = Hashtag(id: "", title: selectedHashtag.title ?? "", userIDS: [selectedHashtag.id ?? ""], isVerified:  nil, usedCount: nil, createdBy: "", createdAt: "", updatedAt: "")
                arrHashtags.append(newHashtag)
                collVwHashtag.reloadData()
                updateCollectionViewHeight()
                txtfldHashtag.text = ""
                    arrSuggestHashtags.removeAll()
                    collVwSuggestHashtag.reloadData()
                updateheightCollVwSuggestHashtags()
            }
        }
    }
    func updateheightCollVwHashtags() {
        let rows = ceil(CGFloat(arrHashtags.count) / 2)
        let newHeight = rows * 50 + max(0, rows - 1) * 8
        heighCollvwHAshtag.constant = newHeight
    }
    func updateheightCollVwSuggestHashtags() {
        let rows = ceil(CGFloat(arrSuggestHashtags.count) / 2)
        let newHeight = rows * 50 + max(0, rows - 1) * 8
        heightCollVwSuggestHashtag.constant = newHeight
    }
}
//MARK: - setupDatePicker
extension ProfileDetailVC{
    func setupDatePicker(for textField: UITextField, mode: UIDatePicker.Mode, selector: Selector) {
      let datePicker = UIDatePicker()
      datePicker.datePickerMode = mode
      if #available(iOS 13.4, *) {
        datePicker.preferredDatePickerStyle = .wheels
      }
      datePicker.translatesAutoresizingMaskIntoConstraints = false
      textField.inputView = datePicker
        datePicker.maximumDate = Date()
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
            let currentDate = Date()
            let age = calculateAge(from: selectedDate, to: currentDate)
            let calendar = Calendar.current
            let month = calendar.component(.month, from: selectedDate)
            let day = calendar.component(.day, from: selectedDate)
            let zodiac = getZodiacSign(month: month, day: day)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM, yyyy"
            txtFldDateofbirth.text = dateFormatter.string(from: selectedDate)
            if age > 0{
                lblAge.text = "\(age) Years age"
                selectedAge = age
            }
            txtFldZodiac.text = zodiac
        }
        txtFldDateofbirth.resignFirstResponder()
    }

    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        let currentDate = Date()
        let age = calculateAge(from: selectedDate, to: currentDate)
        let calendar = Calendar.current
        let month = calendar.component(.month, from: selectedDate)
        let day = calendar.component(.day, from: selectedDate)
        let zodiac = getZodiacSign(month: month, day: day)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM, yyyy"
        txtFldDateofbirth.text = dateFormatter.string(from: selectedDate)
        if age > 0{
            lblAge.text = "\(age) Years age"
            selectedAge = age
        }
        txtFldZodiac.text = zodiac
    }

    // Function to calculate age
    func calculateAge(from birthDate: Date, to currentDate: Date) -> Int {
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthDate, to: currentDate)
        return ageComponents.year ?? 0
    }

    // Function to determine Zodiac sign
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
}

// MARK: - VNDocumentCameraViewControllerDelegate
extension ProfileDetailVC: VNDocumentCameraViewControllerDelegate {
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        controller.dismiss(animated: true, completion: nil)
        if scan.pageCount > 0 {
            let scannedImage = scan.imageOfPage(at: 0)
            viewModel.scanDocumentApi(document: scannedImage, type: selectedIdType) { gender in
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "IdAuthenticatedVC") as! IdAuthenticatedVC
                vc.callBack = { [self] gender in
                    print(gender)

                        if gender == "Male"{
                            lblGender.text = "Male"
                        }else if gender == "Female"{
                            lblGender.text = "Female"
                        }else{
                            lblGender.text = "TS"
                        }
                        imgVwDocument.image = scannedImage
                        uploadDocument = true
                        btnDocumentUpload.setImage(UIImage(named: "edit 1"), for: .normal)
                        viewDocumentUserDetails.isHidden = false
                    }
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            
        }
    }
    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        controller.dismiss(animated: true, completion: nil)
        print("User canceled scanning.")
    }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
        controller.dismiss(animated: true, completion: nil)
        print("Scanning failed with error: \(error.localizedDescription)")
    }
}
