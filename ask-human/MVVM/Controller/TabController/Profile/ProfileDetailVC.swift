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
import Vision
import MBDocCapture


class ProfileDetailVC: UIViewController{
    //MARK: - OUTLETS
    @IBOutlet var viewAppId: UIView!
    @IBOutlet var lblTitleLanguage: UILabel!
    @IBOutlet var lblTitleEthics: UILabel!
    @IBOutlet var lblTitleAge: UILabel!
    @IBOutlet var lblNoHashtag: UILabel!
    @IBOutlet var heightCollVwHAshtag: NSLayoutConstraint!
    @IBOutlet var viewUrIdentity: UIView!
    @IBOutlet var btnProfilePicture: UIButton!
    @IBOutlet var imgVwEdit: UIImageView!
    @IBOutlet var txtFldAge: UITextField!
    @IBOutlet var viewHashtag: UIView!
    @IBOutlet var viewAddId: UIView!
    @IBOutlet var viewImageDocument: UIView!
    @IBOutlet var btnEditDocument: UIButton!
    @IBOutlet var txtFldOtherLanguage: UITextField!
    @IBOutlet var viewEthnicity: UIView!
    @IBOutlet var viewChooseLanguage: UIView!
    @IBOutlet var viewOtherLanguage: UIView!
    @IBOutlet var lblLAnguage: UILabel!
    @IBOutlet var lblEthics: UILabel!
    @IBOutlet var heightCollVwLanguage: NSLayoutConstraint!
    @IBOutlet var collVwLAnguage: UICollectionView!
    @IBOutlet var txtFldIdAuthType: UITextField!
    @IBOutlet var lblAuthIdTitle: UILabel!
    @IBOutlet var btnIdAuth: UIButton!
    @IBOutlet var lblZodiac: UILabel!
    @IBOutlet var lblAgeDocument: UILabel!
    @IBOutlet var lblGender: UILabel!
    @IBOutlet var viewDocumentUserDetails: UIView!
    @IBOutlet var imgVwDocument: UIImageView!
    @IBOutlet var lblAddHashtag: UILabel!
    @IBOutlet var btnVerifyhashtag: UIButton!
    @IBOutlet var lblDateofbirth: UILabel!
    @IBOutlet var lblAge: UILabel!
    @IBOutlet var txtFldDateofbirth: UITextField!
    @IBOutlet var heightCollVwSuggestHashtag: NSLayoutConstraint!
    @IBOutlet var txtfldHashtag: UITextField!
    @IBOutlet var collVwSuggestHashtag: UICollectionView!
    @IBOutlet var collVwHashtag: UICollectionView!
    @IBOutlet var viewDescription: UIView!
    @IBOutlet var lblTitleUsername: UILabel!
    @IBOutlet var lblTitleGender: UILabel!
    @IBOutlet var lblTitleZodi: UILabel!
    @IBOutlet var lblTitlePrice: UILabel!
    @IBOutlet var lblTitleDescription: UILabel!
    @IBOutlet weak var txtFldPrice: UITextField!
    @IBOutlet var gradientVw: GradientView!
    @IBOutlet var btnEditProfilePics: UIButton!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet weak var btnCreateProfile: GradientButton!
    @IBOutlet weak var btnUploadPhoto: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var heightVwDescription: NSLayoutConstraint!
    @IBOutlet weak var imgVwUpload: UIImageView!
    @IBOutlet weak var txtFldGender: UITextField!
    @IBOutlet weak var txtFldZodiac: UITextField!
    @IBOutlet weak var txtVwDescription: IQTextView!
    @IBOutlet weak var txtFldUserName: UITextField!
    @IBOutlet var viewZodiac: UIView!
    @IBOutlet var viewAge: UIView!
    @IBOutlet var viewGender: UIView!
    //MARK: - VARIABLES
    
    var image: UIImage?
    let document = Store.userDetail?["document"] as? String ?? ""
    let videoVerify = Store.userDetail?["videoVerify"] as? Int ?? 0
    var getAge:Int?
    var getGender = 0
    var isContainLanguage = false
    var arrSelectedLanguages = [String]()
    var arrSelectedEthics = [String]()
    var arrLanguages = [Language]()
    var arrEthnic = [Ethnic]()
    var arrEthicsIds = [String]()
    var arrLanguageIds = [String]()
    var SelectedEthics:String?
    var EthicsIds:String?
    var isComing = false
    var viewModelLanguageEthics = NoteVM()
    var viewModel = ProfileVM()
    var userInteraction: Bool = false
    var minValueSelected: Int = 0
    var maxValueSelected: Int = 0
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
    var selectedIdType: Int? = nil
    var isMatched = false
    var finalDocumentType: Int? = nil
    var isBack = false
    var profilePicUpdated = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTapGestures()
        uiSet()
        darkMode()
    }
    private func uiSet(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.getLanguagesApi()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.getEthnicityApi()
        }
        txtVwDescription.delegate = self
        
        txtFldPrice.delegate = self
        txtfldHashtag.delegate = self
        txtFldDateofbirth.delegate = self
        setupDatePicker(for: txtFldDateofbirth, mode: .date, selector: #selector(dateOfBirth))
        registedNibs()
        setCollVwLayout()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM, yyyy"
        let currentDate = Date()
        txtFldDateofbirth.text = dateFormatter.string(from: currentDate)
        btnVerifyhashtag.isHidden = true
        if traitCollection.userInterfaceStyle == .dark {
            imgVwUpload.image = UIImage(named: "Group 1686556762100")
        }else{
            imgVwUpload.image = UIImage(named: "Group 1686557525")
        }
        gradientVw.startColor = .appPink
        gradientVw.endColor = .appPurple
        btnBack.isHidden = false
        getProfileDetails()
        collVwHashtag.reloadData()
        collVwSuggestHashtag.reloadData()
    }
    private func setCollVwLayout(){
        let alignedFlowLayoutCollVwHashtag = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .top)
        collVwHashtag.collectionViewLayout = alignedFlowLayoutCollVwHashtag
        let alignedFlowLayoutCollVwHashtag2 = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .top)
        collVwSuggestHashtag.collectionViewLayout = alignedFlowLayoutCollVwHashtag2
        let alignedFlowLayoutCollVwHashtag3 = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .top)
        collVwLAnguage.collectionViewLayout = alignedFlowLayoutCollVwHashtag3
        
        if let flowLayoutHashtag = collVwHashtag.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayoutHashtag.estimatedItemSize = CGSize(width: 0, height: 20)
            flowLayoutHashtag.itemSize = UICollectionViewFlowLayout.automaticSize
            flowLayoutHashtag.invalidateLayout()
        }
        if let flowLayoutSuggest = collVwSuggestHashtag.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayoutSuggest.estimatedItemSize = CGSize(width: 0, height: 20)
            flowLayoutSuggest.itemSize = UICollectionViewFlowLayout.automaticSize
            flowLayoutSuggest.invalidateLayout()
        }
        if let flowLayoutLanguage = collVwLAnguage.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayoutLanguage.estimatedItemSize = CGSize(width: 0, height: 20)
            flowLayoutLanguage.itemSize = UICollectionViewFlowLayout.automaticSize
            flowLayoutLanguage.invalidateLayout()
        }
        
    }
    private func registedNibs(){
        let nib = UINib(nibName: "AddHashtagCVC", bundle: nil)
        collVwHashtag.register(nib, forCellWithReuseIdentifier: "AddHashtagCVC")
        let nib2 = UINib(nibName: "AddHashtagCVC", bundle: nil)
        collVwSuggestHashtag.register(nib2, forCellWithReuseIdentifier: "AddHashtagCVC")
        let nib3 = UINib(nibName: "AddHashtagCVC", bundle: nil)
        collVwLAnguage.register(nib3, forCellWithReuseIdentifier: "AddHashtagCVC")
        
    }
    private func getProfileDetails(){
        if Store.userDetail?["profile"] as? String ?? "" == ""{
            self.imgVwUpload.image = UIImage(named: "user")
            uploadProfile = false
        }else{
            self.imgVwUpload.imageLoad(imageUrl: Store.userDetail?["profile"] as? String ?? "")
            uploadProfile = true
            if Store.userDetail?["gender"] as? Int ?? 0 == 0{
                self.txtFldGender.text = "Male"
                self.lblGender.text = "Male"
            }else if Store.userDetail?["gender"] as? Int ?? 0 == 1{
                self.txtFldGender.text = "Female"
                self.lblGender.text = "Female"
            }else{
                self.txtFldGender.text = "Others"
                self.lblGender.text = "Others"
            }
        }
        
        self.txtFldZodiac.text = Store.userDetail?["zodiac"] as? String ?? ""
        self.lblAge.text =  "\(Store.userDetail?["age"] as? Int ?? 0) Years age"
        getAge = Store.userDetail?["age"] as? Int ?? 0
        lblAgeDocument.text = "\(Store.userDetail?["age"] as? Int ?? 0)"
        txtFldAge.text = "\(Store.userDetail?["age"] as? Int ?? 0)"
        if isComing{
            viewUrIdentity.isHidden = false
            imgVwEdit.isHidden = true
            lblTitle.text = "Complete profile"
            btnCreateProfile.setTitle("Complete profile", for: .normal)
            viewAge.isHidden = true
            viewGender.isHidden = true
            viewZodiac.isHidden = true
            if Store.userDetail?["document"] as? String ?? "" == ""{
                viewAddId.isHidden = false
                viewDocumentUserDetails.isHidden = true
                viewImageDocument.isHidden = true
                uploadDocument = false
                txtFldIdAuthType.text =  ""
            }else{
                viewAddId.isHidden = true
                viewImageDocument.isHidden = false
                viewDocumentUserDetails.isHidden = false
                imgVwDocument.imageLoad(imageUrl: Store.userDetail?["document"] as? String ?? "")
                uploadDocument = true
                if Store.userDetail?["identity"] as? Int == 0{
                    txtFldIdAuthType.text =  "Passport"
                }else if Store.userDetail?["identity"] as? Int == 1{
                    txtFldIdAuthType.text =  "Driving Licence"
                }else if Store.userDetail?["identity"] as? Int == 2{
                    txtFldIdAuthType.text =  "Country ID"
                }else{
                    txtFldIdAuthType.text =  ""
                }
            }
            
        }else{
            viewUrIdentity.isHidden = true
            imgVwEdit.isHidden = false
            viewAge.isHidden = false
            viewGender.isHidden = false
            viewZodiac.isHidden = false
            viewAddId.isHidden = true
            viewDocumentUserDetails.isHidden = true
            viewImageDocument.isHidden = true
            lblTitle.text = "Edit profile"
            btnCreateProfile.setTitle("Save", for: .normal)
        }
        
        self.txtFldUserName.text = Store.userDetail?["userName"] as? String ?? ""
        self.txtFldDateofbirth.text = Store.userDetail?["dob"] as? String ?? ""
        if Store.userDetail?["ethnicity"] as? String ?? "" == ""{
            if traitCollection.userInterfaceStyle == .dark {
                self.lblEthics.textColor = UIColor(red: 199/255, green: 199/255, blue: 199/255, alpha: 1.0)
            }else{
                self.lblEthics.textColor = UIColor.placeholder
            }
            self.lblEthics.text = "Choose Ethnicity"
        }else{
            if traitCollection.userInterfaceStyle == .dark {
                self.lblEthics.textColor = .white
            }else{
                self.lblEthics.textColor = UIColor(hex: "#000000")
            }
            self.lblEthics.text = Store.userDetail?["ethnicity"] as? String ?? ""
        }
        
        if Store.userDetail?["hoursPrice"] as? Int ?? 0 > 0{
            self.txtFldPrice.text = "\(Store.userDetail?["hoursPrice"] as? Int ?? 0)"
        }else{
            self.txtFldPrice.text = ""
        }
        self.txtVwDescription.text = Store.userDetail?["description"] as? String ?? ""
        
        arrHashtags = Store.Hashtags?.data?.user?.hashtags ?? []
        if let languages = Store.Hashtags?.data?.user?.languages{
            for language in languages {
                if let id = language.id {
                    arrLanguageIds.append(id)
                }
                if let name = language.name {
                    arrSelectedLanguages.append(name)
                }
            }
        }
        collVwLAnguage.reloadData()
        collVwSuggestHashtag.reloadData()
        collVwHashtag.reloadData()
        updateCollectionViewHeight()
        updateHeight(for: collVwLAnguage, constraint: heightCollVwLanguage)
        updateHeight(for: collVwHashtag, constraint: heightCollVwHAshtag)
        self.heightCollVwLanguage.constant = self.collVwLAnguage.contentSize.height
        self.updateCollectionViewHeight()
    }
    private func setupTapGestures() {
        // addTapGesture(to: viewHashtag, action: #selector(viewTapped(_:)))
        addTapGesture(to: viewEthnicity, action: #selector(viewTapped(_:)))
        addTapGesture(to: viewChooseLanguage, action: #selector(viewTapped(_:)))
        addTapGesture(to: viewOtherLanguage, action: #selector(viewTapped(_:)))
        addTapGesture(to: viewAppId, action: #selector(viewTapped(_:)))
    }
    private func addTapGesture(to view: UIView, action: Selector) {
        let tapGesture = UITapGestureRecognizer(target: self, action: action)
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func viewTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        if let tappedView = sender.view {
            switch tappedView {
            case viewEthnicity:
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "FilterOptionsVC") as! FilterOptionsVC
                vc.isSelect = 1
                vc.arrEthnic = arrEthnic
                vc.fromProfile = true
                vc.selectedEthic = lblEthics.text ?? ""
                // vc.arrSelectedEthics = arrSelectedEthics
                vc.modalPresentationStyle = .popover
                vc.preferredContentSize = CGSize(width: tappedView.frame.width, height: CGFloat(arrEthnic.count*45))
                let popOver : UIPopoverPresentationController = vc.popoverPresentationController!
                popOver.sourceView = sender.view
                popOver.delegate = self
                popOver.permittedArrowDirections = .up
                vc.callBack = { index,title,ids  in
                    self.arrEthicsIds.append(ids)
                    self.EthicsIds = ids
                    self.SelectedEthics = title
                    let selectedEthicsString = self.arrSelectedEthics.joined(separator: ", ")
                    self.lblEthics.text = title
                    if self.traitCollection.userInterfaceStyle == .dark {
                        self.lblEthics.textColor = .white
                    }else{
                        self.lblEthics.textColor = UIColor(hex: "#000000")
                    }
                }
                self.present(vc, animated: true, completion: nil)
                
            case viewChooseLanguage:
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "FilterOptionsVC") as! FilterOptionsVC
                vc.isSelect = 0
                vc.arrLanguages = arrLanguages
                vc.arrSelectedLanguages = arrSelectedLanguages
                vc.arrLanguageIds = arrLanguageIds
                vc.modalPresentationStyle = .popover
                vc.preferredContentSize = CGSize(width: tappedView.frame.width, height: CGFloat(arrLanguages.count*45))
                let popOver : UIPopoverPresentationController = vc.popoverPresentationController!
                popOver.sourceView = sender.view
                popOver.delegate = self
                popOver.permittedArrowDirections = .up
                vc.callBack = { index,title,ids in
                    if title != "Add more" {
                        DispatchQueue.main.async {
                            
                            self.viewOtherLanguage.isHidden = true
                            self.arrSelectedLanguages.append(title)
                            self.arrLanguageIds.append(ids)
                            self.isContainLanguage = false
                            self.collVwLAnguage.reloadData()
                            self.updateHeightLanguage(for: self.collVwLAnguage, constraint: self.heightCollVwLanguage)
                        }
                    }else{
                        self.viewOtherLanguage.isHidden = false
                    }
                    
                }
                self.present(vc, animated: true, completion: nil)
            case viewHashtag:
                if arrHashtags.count == 0{
                    txtfldHashtag.becomeFirstResponder()
                }
            case viewAppId:
                print("View Tapped: viewAppId")
                presentDocumentScanner()
            default:
                break
            }
        }
        
    }
    private func presentDocumentScanner(){
        if txtFldIdAuthType.text == ""{
            showSwiftyAlert("", "Please select a valid ID for authentication.", false)
        }else{
            let scannerViewController = ImageScannerController(delegate: self)
            scannerViewController.modalPresentationStyle = .overFullScreen
            scannerViewController.shouldScanTwoFaces = false // Use this to scan front and back of document
            present(scannerViewController, animated: true)
        }

    }

    private func getDocumentImageAndfText(from image: UIImage) {
        WebService.showLoader()
        guard let cgImage = image.cgImage else {
            print("Failed to convert UIImage to CGImage")
            return
        }
        
        let request = VNRecognizeTextRequest { (request, error) in
            guard let observations = request.results as? [VNRecognizedTextObservation], error == nil else {
                print("Text recognition error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            // Convert all extracted text to lowercase
            let extractedText = observations
                .compactMap { $0.topCandidates(1).first?.string }
                .joined(separator: " ")
                .lowercased()
            
            print("Extracted Text:\n\(extractedText)")
            
            let passportKeywords = ["passport", "travel document", "passeport", "reisepass"]
            let drivingLicenseRegex = "\\b(driver'?s?[ -]?license|drivers?[ -]?licence|driving[ -]?(license|licence)|license number|permis de conduire|führerschein|rijbewijs|carnet de conducir|patente di guida|prawo jazdy|vezetői engedély|permis de conduire|ajokortti|körkort|řidičský průkaz|carteira de motorista|vozačka dozvola)\\b"


            let countryIDKeywords = ["id card", "national id", "identification", "身份证", "aadhaar", "आधार", "government","govt","election","voting","voter"]
            
            let maleKeywords = ["male", "indian m", "sex:m","sex m", "man", "mr.", "gentleman", "boy", "masculino", "hombre", "पुरुष","ਮਰਦ","ਪੁਰਸ਼"]
            let femaleKeywords = ["female", "indian f", "sex:f","sex f", "woman", "ms.", "mrs.", "lady", "girl", "femenino", "mujer", "महिला","ਮਹਿਲਾ","ਇਸਤਰੀ","ਔਰਤ","miss"]
            
            var detectedIDType: String?
            
            switch self.selectedIdType {
            case 0:
                if passportKeywords.contains(where: extractedText.contains) {
                    detectedIDType = "Passport"
                }
            case 1:
                let regex = try? NSRegularExpression(pattern: drivingLicenseRegex, options: .caseInsensitive)
                if let regex = regex, regex.firstMatch(in: extractedText, options: [], range: NSRange(location: 0, length: extractedText.utf16.count)) != nil {
                    detectedIDType = "Driving License"
                }
            case 2:
                if countryIDKeywords.contains(where: extractedText.contains) {
                    detectedIDType = "Country ID"
                }
            default:
                print("Invalid ID type selected.")
            }
            
            var detectedGender: String?
            
            if maleKeywords.contains(where: extractedText.contains) {
                detectedGender = "Male"
                self.getGender = 0
            } else if femaleKeywords.contains(where: extractedText.contains) {
                detectedGender = "Female"
                self.getGender = 1
            } else {
                detectedGender = "Others"
                self.getGender = 2
            }
            
            if let gender = detectedGender {
                print("Detected Gender: \(gender)")
            } else {
                print("No gender information detected.")
            }
            
            if let idType = detectedIDType {
                print("Detected ID Type: \(idType)")
                DispatchQueue.main.async {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "IdAuthenticatedVC") as! IdAuthenticatedVC
                    vc.gender = self.getGender
                    vc.callBack = {[self] gender, age, Zodiac in
                        getAge = age
                        finalDocumentType = selectedIdType
                        lblAgeDocument.text = "\(age)"
                        lblZodiac.text = Zodiac
                        if gender == "Male" {
                            lblGender.text = "Male"
                            getGender = 0
                        } else if gender == "Female" {
                            lblGender.text = "Female"
                            getGender = 1
                        } else {
                            lblGender.text = "Others"
                            getGender = 2
                        }
                        uploadDocument = true
                        self.viewAddId.isHidden = true
                        self.viewImageDocument.isHidden = false
                        self.viewDocumentUserDetails.isHidden = false
                        self.imgVwDocument.image = image
                    }
                    self.navigationController?.pushViewController(vc, animated: true)
                    WebService.hideLoader()
                }
                
            } else {
                DispatchQueue.main.async {
                    WebService.hideLoader()
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
                    vc.modalPresentationStyle = .overFullScreen
                    vc.message = "Uploaded document does not match the selected document type."
                    vc.callBack = {
                        self.dismiss(animated: true)
                    }
                    self.navigationController?.present(vc, animated: false)
                    WebService.hideLoader()
                }
            }
        }
        
        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = true
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try requestHandler.perform([request])
            } catch {
                print("Failed to perform text recognition: \(error.localizedDescription)")
            }
        }
    }

    private func getLanguagesApi(){
        viewModelLanguageEthics.getLanguagesApi { data in
            self.arrLanguages = data?.languages ?? []
        }
    }
    private func getEthnicityApi(){
        viewModelLanguageEthics.getEthnicityApi { data in
            self.arrEthnic = data?.ethnics ?? []
            self.arrEthicsIds = Store.filterDetail?["Ethnicity"] ?? [""]
            for datas in data?.ethnics  ?? []{
                if self.arrEthicsIds.contains(datas.id ?? ""){
                    self.arrSelectedEthics.insert(datas.ethnic ?? "", at: 0)
                }
            }
        }
    }
    private func updateCollectionViewHeight() {
        updateHeight(for: collVwSuggestHashtag, constraint: heightCollVwSuggestHashtag)
        updateHeight(for: collVwHashtag, constraint: heightCollVwHAshtag)
        updateHeight(for: collVwLAnguage, constraint: heightCollVwLanguage)
    }
    private func updateHeight(for collectionView: UICollectionView, constraint: NSLayoutConstraint) {
        collectionView.layoutIfNeeded()
        DispatchQueue.main.async {
            if collectionView == self.collVwHashtag{
                if self.arrHashtags.count > 0{
                    self.lblNoHashtag.isHidden = true
                    constraint.constant = collectionView.contentSize.height
                }else{
                    self.lblNoHashtag.isHidden = false
                    constraint.constant = 60
                }
                
            }else{
                
                constraint.constant = collectionView.contentSize.height
            }
        }
    }
    private func updateHeightLanguage(for collectionView: UICollectionView, constraint: NSLayoutConstraint) {
        collectionView.layoutIfNeeded()
        collectionView.collectionViewLayout.invalidateLayout()
        DispatchQueue.main.async {
            if collectionView == self.collVwLAnguage{
                if self.arrSelectedLanguages.count == 0 {
                    constraint.constant = 0
                    
                }else if self.arrSelectedLanguages.count == 1{
                    constraint.constant = 45
                }else {
                    if self.isContainLanguage == true{
                        constraint.constant = collectionView.contentSize.height+20
                    }else{
                        constraint.constant = collectionView.contentSize.height
                    }
                }
            }
        }
    }
    private func getSearchHashtags(searchText:String){
        viewModel.getSearchHashtagApi(searchBy: searchText) { data
            in
            self.arrSuggestHashtags = data
            self.collVwSuggestHashtag.reloadData()
            self.updateCollectionViewHeight()
            self.heightCollVwSuggestHashtag.constant = self.collVwSuggestHashtag.contentSize.height
            
        }
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            darkMode()
            
        }
    }
    
    
    private func darkMode() {
        let isDarkMode = traitCollection.userInterfaceStyle == .dark
        let textColor: UIColor = isDarkMode ? .white : .black
        let placeholderColor: UIColor = isDarkMode ? UIColor(red: 199/255, green: 199/255, blue: 199/255, alpha: 1.0) : UIColor.placeholder
        let borderColor: UIColor = isDarkMode ? .white : UIColor(hex: "#DCDCDC")
        let buttonTitleColor: UIColor = isDarkMode ? .white : .black
        let borderColorForViewDescription: CGColor = borderColor.cgColor
        lblLAnguage.textColor = placeholderColor
        btnBack.setImage(UIImage(named: isDarkMode ? "keyboard-backspace25" : "back"), for: .normal)
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: placeholderColor
        ]
        
        let placeholders: [UITextField] = [
            txtFldOtherLanguage, txtFldAge, txtFldIdAuthType, txtFldPrice,
            txtFldDateofbirth, txtfldHashtag, txtFldUserName, txtFldGender,
            txtFldZodiac
        ]
        
        placeholders.forEach { $0.attributedPlaceholder = NSAttributedString(string: $0.placeholder ?? "", attributes: attributes) }
        txtVwDescription.textColor = textColor
        txtVwDescription.layer.borderColor = borderColor.cgColor
        txtVwDescription.layer.borderWidth = 1.0
        txtVwDescription.layer.cornerRadius = 5.0
        
        let labels: [UILabel] = [lblTitleAge, lblTitleEthics, lblTitleLanguage, lblTitleUsername,
                                 lblTitleGender, lblTitleZodi, lblTitlePrice, lblAuthIdTitle, lblTitleDescription,
                                 lblTitle, lblAge, lblDateofbirth, lblAddHashtag
        ]
        
        labels.forEach { $0.textColor = textColor }
        
        let textFields: [UITextField] = [
            txtFldAge, txtFldPrice, txtFldGender, txtFldZodiac, txtFldIdAuthType,
            txtFldUserName, txtFldDateofbirth
        ]
        textFields.forEach {
            $0.textColor = textColor
            $0.layer.borderColor = borderColor.cgColor
            $0.layer.borderWidth = 1.0
            $0.layer.cornerRadius = 5.0
        }
        btnProfilePicture.setTitleColor(buttonTitleColor, for: .normal)
        viewDescription.layer.borderColor = borderColorForViewDescription
    }
    
    
    //MARK: - button actions
    @IBAction func actionEditDocuments(_ sender: UIButton) {
        presentDocumentScanner()
    }
    
    @IBAction func actionDoneOtherLanguage(_ sender: UIButton) {
        view.endEditing(true)
        if let text = txtFldOtherLanguage.text, !text.isEmpty {
            isLanguageExist = true
            viewModelLanguageEthics.addLanguagesApi(name: text) { data in
                self.view.endEditing(true)
                self.txtFldOtherLanguage.text = ""
                self.getLanguagesApi()
            }
        } else {
            viewOtherLanguage.isHidden = true
        }
    }
    @IBAction func actionChooseIdtype(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfilePopUpsVC") as! ProfilePopUpsVC
        vc.isSelect = 13
        vc.modalPresentationStyle = .popover
        vc.preferredContentSize = CGSize(width: sender.frame.width, height: 140)
        vc.selectedTitle = txtFldIdAuthType.text ?? ""
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
    @IBAction func actionZodiac(_ sender: UIButton) {
        view.endEditing(true)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfilePopUpsVC") as! ProfilePopUpsVC
        vc.isSelect = 20
        vc.selectedTitle = txtFldZodiac.text ?? ""
        vc.modalPresentationStyle = .popover
        vc.preferredContentSize = CGSize(width: sender.frame.width, height: 420)
        let popOver : UIPopoverPresentationController = vc.popoverPresentationController!
        popOver.sourceView = sender
        popOver.delegate = self
        popOver.permittedArrowDirections = .up
        vc.callBack = { (index,title,selecIndex) in
            sender.tag = index
            self.txtFldZodiac.text = title
            print("title:--\(title)")
        }
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func actionGender(_ sender: UIButton) {
        view.endEditing(true)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfilePopUpsVC") as! ProfilePopUpsVC
        vc.isSelect = 1
        vc.selectedTitle = txtFldGender.text ?? ""
        vc.modalPresentationStyle = .popover
        vc.preferredContentSize = CGSize(width: sender.frame.width, height: 145)
        let popOver : UIPopoverPresentationController = vc.popoverPresentationController!
        popOver.sourceView = sender
        popOver.delegate = self
        popOver.permittedArrowDirections = .up
        vc.callBack = { (index,title,selecIndex) in
            sender.tag = index
            if index == 0{
                self.getGender = 0
                self.txtFldGender.text = title
                print("title:--\(title)")
            }else if index == 1{
                self.getGender = 1
                self.txtFldGender.text = title
                print("title:--\(title)")
            }else{
                self.getGender = 2
                self.txtFldGender.text = title
                print("title:--\(title)")
            }
        }
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func actionEditUploadImage(_ sender: UIButton) {
        print("document:-\(document)")
        print("videoVerify:-\(videoVerify)")
        view.endEditing(true)
        if !document.isEmpty || videoVerify == 1 {
              let vc = self.storyboard?.instantiateViewController(withIdentifier: "LogoutPopUpVC") as! LogoutPopUpVC
              vc.modalPresentationStyle = .overFullScreen
              vc.isComing = 2
              vc.callBack = { [weak self] in
                  DispatchQueue.main.async {
                      self?.showImagePicker()
                  }
              }
              self.navigationController?.present(vc, animated: true)
          } else {
              showImagePicker()
          }
    }
    @IBAction func actionUploadImage(_ sender: UIButton) {
        print("document:-\(document)")
        print("videoVerify:-\(videoVerify)")
        view.endEditing(true)
      if !document.isEmpty || videoVerify == 1 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LogoutPopUpVC") as! LogoutPopUpVC
            vc.modalPresentationStyle = .overFullScreen
            vc.isComing = 2
            vc.callBack = { [weak self] in
                DispatchQueue.main.async {
                    self?.showImagePicker()
                }
            }
            self.navigationController?.present(vc, animated: true)
        } else {
            showImagePicker()
        }
    }
    func showImagePicker(){
        ImagePicker().pickImage(self) { image in
            self.uploadProfile = true
            self.imgVwUpload.image = image
            self.isSelectImage = true
            if !self.document.isEmpty || self.videoVerify == 1 {
                self.profilePicUpdated = 1
            }else{
                self.profilePicUpdated = 0
            }

        }
        
    }
    @IBAction func actionBack(_ sender: UIButton) {
        view.endEditing(true)
        if isComing == true{
            if isBack{
                self.navigationController?.popViewController(animated: true)
            }else{
                SceneDelegate().tabBarHomeVCRoot()
            }
        }else{
            SceneDelegate().tabBarProfileVCRoot()
        }
    }
    
    @IBAction func actionCreateProfile(_ sender: GradientButton) {
        
        if isComing{
            if uploadProfile == false{
                showSwiftyAlert("", "Profile image must be selected.", false)
            }else if txtFldUserName.text?.trimWhiteSpace == ""{
                showSwiftyAlert("", "Name must be entered.", false)
            }else  if txtFldUserName.text?.count ?? 0 < 3 || txtFldUserName.text?.count ?? 0 > 30{
                showSwiftyAlert("", "Name must be between 3 and 30 characters long.", false)
            }else if imgVwDocument.image == UIImage(named: ""){
                showSwiftyAlert("", "Document must be uploaded.", false)
            }else if lblEthics.text == "Choose Ethnicity" {
                showSwiftyAlert("", "Ethnicity must be selected.", false)
            }else if arrSelectedLanguages.isEmpty{
                showSwiftyAlert("", "Language must be selected.", false)
            }else{
                
                viewModel.setProfileDetailApi(name: txtFldUserName.text ?? "",
                                              about: txtVwDescription.text ?? "",
                                              gender: getGender,
                                              ethnicity: lblEthics.text ?? "",
                                              zodiac: lblZodiac.text ?? "",
                                              age: getAge ?? 0,
                                              dob: txtFldDateofbirth.text ?? "",
                                              hoursPrice:txtFldPrice.text ?? "",
                                              countryCode:Store.userDetail?["countryCode"] as? String ?? "",
                                              nationality: Store.nationality ?? "",
                                              identity:finalDocumentType ?? 0,
                                              profileImage: imgVwUpload,
                                              document: imgVwDocument,
                                              imageUpload: uploadProfile,
                                              uploadDocument: uploadDocument, profilePicUpdated: profilePicUpdated,
                                              languages: arrLanguageIds,
                                              hashtags: [arrHashtags]) { data in
                    self.message = data?.message ?? ""
                    self.viewModel.getProfileApi { data in
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
                        vc.modalPresentationStyle = .overFullScreen
                        vc.message = self.message
                        vc.callBack = {
                            print("isComing:--\(self.isComing)")
                            if self.isBack{
                                SceneDelegate().verifiedVCRootToProfile()
                            }else{
                                if self.isComing == true{
                                    SceneDelegate().verifiedVCRootToHome()
                                }else{
                                    SceneDelegate().tabBarProfileVCRoot()
                                }
                            }
                            
                            self.callBack?()
                        }
                        self.navigationController?.present(vc, animated: false)
                    }
                }
            }
        }else{
            if uploadProfile == false{
                showSwiftyAlert("", "Profile image must be selected.", false)
            }else if txtFldUserName.text?.trimWhiteSpace == ""{
                showSwiftyAlert("", "Name must be entered.", false)
            }else  if txtFldUserName.text?.count ?? 0 < 3 || txtFldUserName.text?.count ?? 0 > 30{
                showSwiftyAlert("", "Name must be between 3 and 30 characters long.", false)
            }else if txtFldGender.text == "" {
                showSwiftyAlert("", "Gender must be selected.", false)
            }else if txtFldAge.text?.isEmpty ?? true {
                showSwiftyAlert("", "Age must be entered.", false)
            } else if let ageText = txtFldAge.text, let age = Int(ageText), age < 18 {
                showSwiftyAlert("", "You must be at least 18 years old to proceed.", false)
            }else if txtFldZodiac.text == "" {
                showSwiftyAlert("", "Zodiac must be selected.", false)
            }else if lblEthics.text == "Choose Ethnicity" {
                showSwiftyAlert("", "Ethnicity must be selected.", false)
            } else if arrSelectedLanguages.isEmpty{
                showSwiftyAlert("", "Language must be selected.", false)
            }else{
                if let ageText = txtFldAge.text, let age = Int(ageText) {
                    viewModel.setProfileDetailApi(name: txtFldUserName.text ?? "",
                                                  about: txtVwDescription.text ?? "",
                                                  gender: getGender,
                                                  ethnicity: lblEthics.text ?? "",
                                                  zodiac: txtFldZodiac.text ?? "",
                                                  age: age,
                                                  dob: txtFldDateofbirth.text ?? "",
                                                  hoursPrice:txtFldPrice.text ?? "",
                                                  countryCode:Store.userDetail?["countryCode"] as? String ?? "",
                                                  nationality: Store.nationality ?? "",
                                                  identity:finalDocumentType ?? 0,
                                                  profileImage: imgVwUpload,
                                                  document: imgVwDocument,
                                                  imageUpload: uploadProfile,
                                                  uploadDocument: uploadDocument, profilePicUpdated: profilePicUpdated,
                                                  languages: arrLanguageIds,
                                                  hashtags: [arrHashtags]) { data in
                        self.message = data?.message ?? ""
                        self.viewModel.getProfileApi { data in
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
                            vc.modalPresentationStyle = .overFullScreen
                            vc.message = self.message
                            vc.callBack = {
                                print("isComing:--\(self.isComing)")
                                if self.isBack{
                                    SceneDelegate().verifiedVCRootToProfile()
                                }else{
                                    if self.isComing == true{
                                        SceneDelegate().tabBarHomeVCRoot()
                                    }else{
                                        SceneDelegate().tabBarProfileVCRoot()
                                    }
                                }
                                
                                self.callBack?()
                            }
                            self.navigationController?.present(vc, animated: false)
                        }
                    }
                }
            }
        }
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
                collVwHashtag.reloadData()
                collVwSuggestHashtag.reloadData()
                updateCollectionViewHeight()
                heightCollVwSuggestHashtag.constant = collVwSuggestHashtag.contentSize.height
                
            } else {
                print("Hashtag already exists")
            }
            textField.text = ""
            textField.resignFirstResponder()
        }else if textField == txtFldOtherLanguage{
            view.endEditing(true)
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtFldPrice{
            if string.contains(" ") {
                return false
            }
            let allowedCharacters = "0123456789"
            let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
            let typedCharacterSet = CharacterSet(charactersIn: string)
            let alphabet = allowedCharacterSet.isSuperset(of: typedCharacterSet)
            return alphabet
            
        }else if textField == txtfldHashtag{
            if string.contains(" ") {
                return false
            }
            let currentText = (textField.text ?? "") as NSString
            let newText = currentText.replacingCharacters(in: range, with: string)
            print("newText:--\(newText)")
            if newText == ""{
                self.arrSuggestHashtags.removeAll()
                self.collVwSuggestHashtag.reloadData()
                self.updateCollectionViewHeight()
                self.heightCollVwSuggestHashtag.constant = self.collVwSuggestHashtag.contentSize.height
                
            }else{
                arrSuggestHashtags.removeAll()
                getSearchHashtags(searchText: newText)
            }
        }else if textField == txtFldOtherLanguage{
            if string.contains(" ") {
                return false
            }
        }else if textField == txtFldAge{
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
//MARK: - COLLECTIONVIEW DELEGATE AND DATASOURCE
extension ProfileDetailVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collVwHashtag{
            return arrHashtags.count
        }else if collectionView == collVwLAnguage{
            return arrSelectedLanguages.count
        }else{
            return  arrSuggestHashtags.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let isDarkMode = traitCollection.userInterfaceStyle == .dark
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddHashtagCVC", for: indexPath) as? AddHashtagCVC else {
            fatalError("Could not dequeue AddHashtagCVC")
        }

        if collectionView == collVwHashtag{
            cell.viewBack.borderWid = 0
            cell.viewBack.layer.cornerRadius = 12
            cell.viewBtnDelete.isHidden = true
            cell.lblHashtag.text = "#\(arrHashtags[indexPath.row].title ?? "")"
            if arrHashtags[indexPath.row].isVerified == 1 {
                cell.widthImgVerify.constant = 14
            } else {
                cell.widthImgVerify.constant = 0
            }
            cell.imgVwDeleteBtn.image = isDarkMode ? UIImage(named: "darkCros") : UIImage(named: "crossTag")
            cell.lblHashtag.textColor = isDarkMode ? UIColor.white : .black
            cell.viewBack.backgroundColor = isDarkMode ? UIColor(hex: "#610D38") : UIColor(hex: "#EDBFD7")
        }else if collectionView == collVwLAnguage{
            cell.imgVwDeleteBtn.image = isDarkMode ? UIImage(named: "darkCros") : UIImage(named: "crossTag")
            cell.lblHashtag.textColor = isDarkMode ? UIColor.white : .black
            cell.viewBack.backgroundColor = isDarkMode ? UIColor(hex: "#610D38") : UIColor(hex: "#EDBFD7")
            cell.viewBtnDelete.isHidden = false
            cell.lblHashtag.text = arrSelectedLanguages[indexPath.row]
            cell.viewBack.layer.cornerRadius = 12
            cell.viewBack.borderCol = .clear
            cell.imgVwVerify.image = UIImage(named: "certificate-solid 1")
            cell.btnDelete.tag = indexPath.row
            cell.btnDelete.addTarget(self, action: #selector(actionDeleteLanguage), for: .touchUpInside)
            
        }else{
            cell.lblHashtag.textColor = .black
            cell.viewBack.borderWid = 0
            if let customFont = UIFont(name: "Nunito-Medium", size: 10) {
                cell.lblHashtag.font = customFont
            }
            cell.viewBack.layer.cornerRadius = 12
            cell.viewBtnDelete.isHidden = true
            
            let suggestHashtag = arrSuggestHashtags[indexPath.row]
            cell.lblHashtag.text = "#\(suggestHashtag.title ?? "")"
            isMatched = arrHashtags.contains { $0.title == suggestHashtag.title }
            
            
            if isMatched {
                cell.viewBack.backgroundColor = .app
                cell.imgVwVerify.image = UIImage(named: "whiteverify")
                cell.lblHashtag.textColor = .white
            } else {
                cell.viewBack.backgroundColor = UIColor(hex: "#EE0C81").withAlphaComponent(0.07)
                cell.imgVwVerify.image = UIImage(named: "certificate-solid 1")
                cell.lblHashtag.textColor = isDarkMode ? UIColor.white : .black
            }
            
            if suggestHashtag.isVerified == 1 {
                cell.widthImgVerify.constant = 14
            } else {
                cell.widthImgVerify.constant = 0
            }
            cell.viewUserCount.setGradientBackground(
                colors: [UIColor(hex: "#F10B81"), UIColor(hex: "#950D98")],
                startPoint: CGPoint(x: 0.0, y: 0.0),
                endPoint: CGPoint(x: 1.0, y: 1.0)
            )
            
            if suggestHashtag.usedCount == 0 {
                cell.viewUserCount.isHidden = true
            } else if suggestHashtag.usedCount ?? 0 < 100 {
                cell.viewUserCount.isHidden = false
                cell.widthViewUsedCount.constant = 18
                cell.heightUsedCount.constant = 18
                cell.viewUserCount.layer.cornerRadius = 9
            } else {
                cell.viewUserCount.isHidden = false
                cell.widthViewUsedCount.constant = 20
                cell.heightUsedCount.constant = 20
                cell.viewUserCount.layer.cornerRadius = 10
            }
            cell.lblUsedCount.text = formatUsedCount(suggestHashtag.usedCount ?? 0)
            
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
    
    @objc func actionDeleteLanguage(sender:UIButton){
        view.endEditing(true)
        arrSelectedLanguages.remove(at: sender.tag)
        arrLanguageIds.remove(at: sender.tag)
        collVwLAnguage.reloadData()
        updateHeightLanguage(for: collVwLAnguage, constraint: heightCollVwLanguage)
    }
    
    @objc func actionDelete(sender:UIButton){
        view.endEditing(true)
        arrSuggestHashtags.removeAll()
        arrHashtags.remove(at: sender.tag)
        collVwHashtag.reloadData()
        collVwSuggestHashtag.reloadData()
        updateCollectionViewHeight()
        heightCollVwSuggestHashtag.constant = collVwSuggestHashtag.contentSize.height
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collVwSuggestHashtag {
            view.endEditing(true)
            let selectedHashtag = arrSuggestHashtags[indexPath.row]
            let exists = arrHashtags.contains { $0.title == selectedHashtag.title }
            if !exists {
                let newHashtag = Hashtag(id: "", title: selectedHashtag.title ?? "", userIDS: [selectedHashtag.id ?? ""], isVerified:  nil, usedCount: nil, createdBy: "", createdAt: "", updatedAt: "")
                
                arrHashtags.append(newHashtag)
                txtfldHashtag.text = ""
                collVwHashtag.reloadData()
                collVwSuggestHashtag.reloadData()
                updateCollectionViewHeight()
                heightCollVwSuggestHashtag.constant = collVwSuggestHashtag.contentSize.height
            }
        }
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
                getAge = age
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
            getAge = age
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
extension ProfileDetailVC: ImageScannerControllerDelegate {
    
    func imageScannerController(_ scanner: MBDocCapture.ImageScannerController, didFinishScanningWithResults results: MBDocCapture.ImageScannerResults) {
        scanner.dismiss(animated: true, completion: nil)
        
        // Get the scanned image
        let scannedImage = results.scannedImage // Extract the cropped scan
        getDocumentImageAndfText(from: scannedImage)
        print("Scanned Image: \(scannedImage)")
        
    }
    
    func imageScannerController(_ scanner: MBDocCapture.ImageScannerController, didFinishScanningWithPage1Results page1Results: MBDocCapture.ImageScannerResults, andPage2Results page2Results: MBDocCapture.ImageScannerResults) {
        scanner.dismiss(animated: true, completion: nil)
        
        // Get both scanned images
        let frontImage = page1Results.scannedImage
        let backImage = page2Results.scannedImage
        print("Front Image: \(frontImage)")
        print("Back Image: \(backImage)")
        
        // You can now use both images as needed
    }
    
    func imageScannerControllerDidCancel(_ scanner: ImageScannerController) {
        scanner.dismiss(animated: true, completion: nil)
    }
    
    func imageScannerController(_ scanner: ImageScannerController, didFailWithError error: Error) {
        scanner.dismiss(animated: true, completion: nil)
        print("Scanning failed with error: \(error.localizedDescription)")
    }
}
