//
//  UserProfileVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 21/01/25.
//

import UIKit

class UserProfileVC: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet var viewPersonalAndSecurity: UIView!
    @IBOutlet var collVwPersonalAndSecurity: UICollectionView!
    @IBOutlet var btnEdit: UIButton!
    @IBOutlet var lblIdVerification: UILabel!
    @IBOutlet var lblIdentification: UILabel!
    @IBOutlet var lblHourlyPrice: UILabel!
    @IBOutlet var lblHashtag: UILabel!
    @IBOutlet var lblWallet: UILabel!
    @IBOutlet var lblBank: UILabel!
    @IBOutlet var lblTransactions: UILabel!
    @IBOutlet var lblAppliedtReq: UILabel!
    @IBOutlet var lblAllDisput: UILabel!
    @IBOutlet var lblAllContract: UILabel!
    @IBOutlet var lblDeleteAcc: UILabel!
    @IBOutlet var lblPhoneNumber: UILabel!
    @IBOutlet var lblDarkMmode: UILabel!
    @IBOutlet var lblNotification: UILabel!
    @IBOutlet var lblAbout: UILabel!
    @IBOutlet var lblContactUs: UILabel!
    @IBOutlet var lblPrivacy: UILabel!
    @IBOutlet var lblHelp: UILabel!
    @IBOutlet var imgVwDarkModeBottom: NSLayoutConstraint!
    @IBOutlet var viewSetting: UIView!
    @IBOutlet var imgVwDarkmode: UIImageView!
    @IBOutlet var lblMobileNumber: UILabel!
    @IBOutlet var lblEmail: UILabel!
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var imgVwUser: UIImageView!
    @IBOutlet var viewIdVerification: UIView!
    @IBOutlet var viewIdentification: UIView!
    @IBOutlet var viewHaurly: UIView!
    @IBOutlet var viewHashtag: UIView!
    @IBOutlet var viewWallet: UIView!
    @IBOutlet var viewAddbank: UIView!
    @IBOutlet var viewTransection: UIView!
    @IBOutlet var viewAppliedRequest: UIView!
    @IBOutlet var viewAllDisput: UIView!
    @IBOutlet var viewAllContract: UIView!
    @IBOutlet var viewDeleteAc: UIView!
    @IBOutlet var viewNotification: UIView!
    @IBOutlet var viewDarkmode: UIView!
    @IBOutlet var viewHelp: UIView!
    @IBOutlet var viewAbout: UIView!
    @IBOutlet var viewPrivacy: UIView!
    @IBOutlet var viewContactUs: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    //MARK: - variables
    var arrBank = [BankData]()
    var viewModelBank = WalletVM()
    var arrProfile = [ProfileData]()
    var viewModel = ProfileVM()
    var profileDetail: ProfileDetailData?
    var email = ""
    var phone:Int?
    var arrContent = [ContentPolicies]()
    var isSelectView = true
    
    //MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSet()
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            darkMode()
        }
    }
    
    func darkMode() {
        let isDarkMode = traitCollection.userInterfaceStyle == .dark
        lblUserName.textColor = isDarkMode ? .white : .black
        btnEdit.setImage(isDarkMode ? UIImage(named: "darkEdit") : UIImage(named: "editHashtag"), for: .normal)
        let textColor: UIColor = isDarkMode ? UIColor(hex: "#979797") : UIColor(hex: "#000000").withAlphaComponent(0.77)
        let secondaryTextColor: UIColor = isDarkMode ? .white.withAlphaComponent(0.7) : UIColor(hex: "#000000").withAlphaComponent(0.69)
        let viewBackgroundColor: UIColor = isDarkMode ? UIColor(hex: "#161616") : UIColor(hex: "#FBD3E8")
        let secondaryBackgroundColor: UIColor = isDarkMode ? UIColor(hex: "#2C2C2C") : UIColor(hex: "#F5F5F5")
        
        [lblEmail, lblMobileNumber, lblIdVerification, lblIdentification, lblHourlyPrice,
         lblHashtag, lblWallet, lblBank, lblTransactions, lblAppliedtReq, lblAllDisput, lblAllContract,
         lblDeleteAcc, lblPhoneNumber, lblDarkMmode, lblNotification, lblAbout, lblContactUs,
         lblPrivacy, lblHelp].forEach { label in
            label?.textColor = textColor
        }
        
        lblEmail.textColor = secondaryTextColor
        lblMobileNumber.textColor = secondaryTextColor
        
        imgVwDarkmode.image = UIImage(named: isDarkMode ? "dark" : "light")
        imgVwDarkModeBottom.constant = -3
        
        [viewIdVerification, viewIdentification, viewHaurly, viewHashtag, viewWallet, viewAddbank,
         viewTransection, viewAppliedRequest, viewAllDisput, viewAllContract, viewDeleteAc, viewNotification,
         viewDarkmode, viewHelp, viewAbout, viewPrivacy, viewContactUs, viewSetting].forEach { view in
            view?.backgroundColor = viewBackgroundColor
        }
    }
    func uiSet(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfscrollView(notification:)), name: Notification.Name("scrollView"), object: nil)
        
        arrProfile.removeAll()
        let nib2 = UINib(nibName: "SecurityCVC", bundle: nil)
        collVwPersonalAndSecurity.register(nib2, forCellWithReuseIdentifier: "SecurityCVC")
        darkMode()
        scrollView.delegate = self
        addTapGestures()
        DispatchQueue.global(qos: .userInitiated).async {
            self.getProfileApi()
        }
        DispatchQueue.global(qos: .userInitiated).async {
            self.getBankDetailsApi()
        }
        getUserDetails()
    }
    @objc func methodOfscrollView(notification:Notification){
        Store.ScrollviewCurrentOffset = 0
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        uiSet()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let storedOffset = Store.ScrollviewCurrentOffset ?? 0
        scrollView.setContentOffset(CGPoint(x: 0, y: storedOffset), animated: false)
        
    }
    private func addTapGestures() {
        addTapGesture(to: viewIdVerification, action: #selector(handleIdVerificationTap))
        addTapGesture(to: viewIdentification, action: #selector(handleIdentificationTap))
        addTapGesture(to: viewHaurly, action: #selector(handleHaurlyTap))
        addTapGesture(to: viewHashtag, action: #selector(handleHashtagTap))
        addTapGesture(to: viewWallet, action: #selector(handleWalletTap))
        addTapGesture(to: viewAddbank, action: #selector(handleAddBankTap))
        addTapGesture(to: viewTransection, action: #selector(handleTransactionTap))
        addTapGesture(to: viewAppliedRequest, action: #selector(handleAppliedRequestTap))
        addTapGesture(to: viewAllDisput, action: #selector(handleAllDisputTap))
        addTapGesture(to: viewAllContract, action: #selector(handleAllContractTap))
        addTapGesture(to: viewDeleteAc, action: #selector(handleDeleteAccountTap))
        addTapGesture(to: viewNotification, action: #selector(handleNotificationTap))
        addTapGesture(to: viewDarkmode, action: #selector(handleDarkmodeTap))
        addTapGesture(to: viewHelp, action: #selector(handleHelpTap))
        addTapGesture(to: viewAbout, action: #selector(handleAboutTap))
        addTapGesture(to: viewPrivacy, action: #selector(handlePrivacyTap))
        addTapGesture(to: viewContactUs, action: #selector(handleContactUsTap))
        addTapGesture(to: viewSetting, action: #selector(handleSettingTap))
    }
    private func getUserDetails(){
        if Store.userDetail?["profile"] as? String ?? "" == ""{
            self.imgVwUser.image = UIImage(named: "user")
        }else{
            self.imgVwUser.imageLoad(imageUrl: Store.userDetail?["profile"] as? String ?? "")
        }
        self.phone = Int(Store.userDetail?["phone"] as? String ?? "")
        
        self.lblUserName.text = Store.userDetail?["userName"] as? String ?? ""
        self.lblEmail.text = ""
        if Store.userDetail?["phone"] as? Int ?? 0 != 0{
            self.lblMobileNumber.text = "+\((Store.userDetail?["countryCode"] as? String ?? ""))\(Store.userDetail?["phone"] as? Int ?? 0)"
        }
        
        if (!(Store.userDetail?["document"] as? String ?? "").isEmpty &&
            (Store.userDetail?["videoVerify"] as? Int ?? 0) == 1) {
            viewPersonalAndSecurity.isHidden = true
        } else {
            viewPersonalAndSecurity.isHidden = false
            
            if (Store.userDetail?["document"] as? String ?? "").isEmpty {
                arrProfile.append(ProfileData(title: "Id Verification", img: "idVerification1"))
            }
            if (Store.userDetail?["videoVerify"] as? Int ?? 0) != 1 {
                arrProfile.append(ProfileData(title: "Identification", img: "identification1"))
            }
        }
        collVwPersonalAndSecurity.reloadData()
        
        
    }
    private func getBankDetailsApi(){
        viewModelBank.getBankDetailsApi(loader: false) { data in
            self.arrBank = data?.data ?? []
        }
    }
    
    private func getProfileApi(){
        viewModel.getProfileApi{ data in
        }
    }
    
    private func addTapGesture(to view: UIView, action: Selector) {
        let tapGesture = UITapGestureRecognizer(target: self, action: action)
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
    }
    //MARK: - handle tap gestures
    
    @objc func handleSettingTap() {
        if isSelectView{
            isSelectView = false
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddNewPhoneNumberVC") as! AddNewPhoneNumberVC
            vc.phone = phone ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    @objc func handleIdVerificationTap() {
        if isSelectView{
            isSelectView = false
            if Store.userDetail?["document"] as? String ?? "" == ""{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "IdNotVerifiedVC") as! IdNotVerifiedVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "IdVerifiedVC") as! IdVerifiedVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @objc func handleIdentificationTap() {
        if isSelectView{
            isSelectView = false
            if Store.userDetail?["videoVerify"] as? Int ?? 0 == 3{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "reviewVideoVC") as! reviewVideoVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "VideoIdentificationVC") as! VideoIdentificationVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @objc func handleHaurlyTap() {
        if isSelectView{
            isSelectView = false
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HourlyPriceVC") as! HourlyPriceVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func handleHashtagTap() {
        if isSelectView{
            isSelectView = false
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileHashtagsVC") as! ProfileHashtagsVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func handleWalletTap() {
        if isSelectView{
            isSelectView = false
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "WalletVC") as! WalletVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func handleAddBankTap() {
        if isSelectView{
            isSelectView = false
            if arrBank.count > 0{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "BankListVC") as! BankListVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddBankVC") as! AddBankVC
                vc.isComing = true
                self.navigationController?.pushViewController(vc, animated: true)

            }
        }
    }
    
    @objc func handleTransactionTap() {
        if isSelectView{
            isSelectView = false
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TransectionsVC") as! TransectionsVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func handleAppliedRequestTap() {
        if isSelectView{
            isSelectView = false
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AppliedReqVC") as! AppliedReqVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func handleAllDisputTap() {
        if isSelectView{
            isSelectView = false
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AllDisputeVC") as! AllDisputeVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func handleAllContractTap() {
        if isSelectView{
            isSelectView = false
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func handleDeleteAccountTap() {
        if isSelectView{
            isSelectView = false
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DeleteAccountVC") as! DeleteAccountVC
            vc.type = "delete"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func handleNotificationTap() {
        if isSelectView{
            isSelectView = false
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotificationsVC") as! NotificationsVC
            vc.isComing = 0
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func handleDarkmodeTap() {
        if isSelectView{
            isSelectView = false
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DarkModeVC") as! DarkModeVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func handleHelpTap() {
        if isSelectView{
            isSelectView = false
            self.viewModel.getContentPolicyAboutApi(type: "help"){ data in
                self.arrContent = data?.content ?? []
                DispatchQueue.main.async {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "HelpVC") as! HelpVC
                    vc.arrOption = self.arrContent
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    @objc func handleAboutTap() {
        if isSelectView{
            isSelectView = false
            self.viewModel.getContentPolicyAboutApi(type: "about"){ data in
                self.arrContent = data?.content ?? []
                DispatchQueue.main.async {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "PolicyAndAboutVC") as! PolicyAndAboutVC
                    vc.arrContent = self.arrContent
                    vc.type = "about"
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    @objc func handlePrivacyTap() {
        if isSelectView{
            isSelectView = false
            self.viewModel.getContentPolicyAboutApi(type: "privacy_policy"){ data in
                self.arrContent = data?.content ?? []
                DispatchQueue.main.async {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "PolicyAndAboutVC") as! PolicyAndAboutVC
                    vc.arrContent = self.arrContent
                    vc.type = "privacy_policy"
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    @objc func handleContactUsTap() {
        if isSelectView{
            isSelectView = false
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContactUsVC") as! ContactUsVC
            vc.email = self.email
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    //MARK: - IBAction
    @IBAction func actionLogout(_ sender: UIButton) {
        if isSelectView{
            isSelectView = false
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LogoutPopUpVC") as! LogoutPopUpVC
            vc.modalPresentationStyle = .overFullScreen
            vc.isComing = 1
            vc.callBack = {
                self.isSelectView = true
            }
            self.navigationController?.present(vc, animated: false)
        }
    }
    @IBAction func actionEdit(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileDetailVC") as! ProfileDetailVC
        vc.isComing = false
        vc.callBack = {
            self.getProfileApi()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UIScrollViewDelegate
extension UserProfileVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        Store.ScrollviewCurrentOffset = currentOffset
    }
}
// MARK: - UICollectionViewDelegate
extension UserProfileVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrProfile.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecurityCVC", for:  indexPath) as! SecurityCVC
        let isDarkMode = traitCollection.userInterfaceStyle == .dark
        let viewBackgroundColor: UIColor = isDarkMode ? UIColor(hex: "#161616") : UIColor(hex: "#FBD3E8")
        let textColor: UIColor = isDarkMode ? UIColor(hex: "#979797") : UIColor(hex: "#000000").withAlphaComponent(0.77)
        cell.viewBAck.backgroundColor = viewBackgroundColor
        cell.lblTitle.textColor = textColor
        cell.lblTitle.text = arrProfile[indexPath.row].title
        cell.lblTitlImg.image = UIImage(named: arrProfile[indexPath.row].img ?? "")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collVwPersonalAndSecurity.frame.width/2 - 8, height: 85)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedProfile = arrProfile[indexPath.row].title
        
        switch selectedProfile {
        case "Id Verification":
            if Store.userDetail?["document"] as? String ?? "" == ""{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "IdNotVerifiedVC") as! IdNotVerifiedVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "IdVerifiedVC") as! IdVerifiedVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
        case "Identification":
            if Store.userDetail?["videoVerify"] as? Int ?? 0 == 3{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "reviewVideoVC") as! reviewVideoVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "VideoIdentificationVC") as! VideoIdentificationVC
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            
        default:
            break
        }
    }
    
}
