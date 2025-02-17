//
//  UserDetailVC.swift
//  ask-human
//
//  Created by meet sharma on 17/11/23.
//

import UIKit
import AlignedCollectionViewFlowLayout
import FloatRatingView

class UserDetailVC: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet var scrollVw: UIScrollView!
    @IBOutlet var lblGender: UILabel!
    @IBOutlet var lblChatCount: UILabel!
    @IBOutlet var heightCollVwUserDetail: NSLayoutConstraint!
    @IBOutlet var lblTitleHashtag: UILabel!
    @IBOutlet var lblNoReview: UILabel!
    @IBOutlet var heightCollVwLanguage: NSLayoutConstraint!
    @IBOutlet var heightCollVwHshtag: NSLayoutConstraint!
    @IBOutlet var collVwLanagugae: UICollectionView!
    @IBOutlet var lblTitleReview: UILabel!
    @IBOutlet var lblNoHashtag: UILabel!
    @IBOutlet var viewHashtag: UIView!
    @IBOutlet var lblNoLanguage: UILabel!
    @IBOutlet var viewLanguage: UIView!
    @IBOutlet var lblTitleLanguage: UILabel!
    @IBOutlet var viewChat: UIView!
    @IBOutlet var viewrating: UIView!
    @IBOutlet var viewPrice: UIView!
    @IBOutlet var lblTitleChat: UILabel!
    @IBOutlet var ratingView: FloatRatingView!
    @IBOutlet var lblTitleRating: UILabel!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var lblTitlePrice: UILabel!
    @IBOutlet var collVwUserDetail: UICollectionView!
    @IBOutlet var btnSendInvitation: GradientButton!
    @IBOutlet var viewImgBack: UIView!
    @IBOutlet var viewOnline: UIView!
    @IBOutlet var collVwhastag: UICollectionView!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var lblScreenTitle: UILabel!
    @IBOutlet weak var imgVwProfile: UIImageView!
    @IBOutlet var imgVwBlueTick: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var heightTblVw: NSLayoutConstraint!
    @IBOutlet weak var tblVwReview: UITableView!
    
    //MARK: - variables
    var gender:String?
    var arrUserDetails = [UserDetailz]()
    var arrLanguages = [Languages]()
    var indexx = 0
    var viewModel = InvitationVM()
    var userId = ""
    var viewModelNote = NoteVM()
    var isSelect = 0
    var arrReview = [Review]()
    var isRefer = false
    var arrHashtags = [Hashtagz]()
    
    //MARK: - LIFE CYCLE METHOD
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSet()
    }
    override func viewWillAppear(_ animated: Bool) {
        darkMode()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateTableViewHeight()
        let height = collVwLanagugae.collectionViewLayout.collectionViewContentSize.height
        if arrLanguages.count > 0{
            heightCollVwLanguage.constant = height
        }else{
            heightCollVwLanguage.constant = 70
        }
        self.view.layoutIfNeeded()
    }
    //MARK: - FUNCTION
    private func uiSet(){
        registedNibs()
        tblVwReview.estimatedRowHeight = 70
        tblVwReview.rowHeight = UITableView.automaticDimension
        if isRefer == true{
            btnSendInvitation.setTitle("Send Refer", for: .normal)
        }else{
            btnSendInvitation.setTitle("Send Invitation", for: .normal)
        }
        getUserDetail()
    }
    private func registedNibs(){
        let nib = UINib(nibName: "ReviewTVC", bundle: nil)
        tblVwReview.register(nib, forCellReuseIdentifier: "ReviewTVC")

        let nibHahstag = UINib(nibName: "UserDetailCVC", bundle: nil)
        collVwhastag.register(nibHahstag, forCellWithReuseIdentifier: "UserDetailCVC")
        
        let nibUserDetail = UINib(nibName: "LanguagesCVC", bundle: nil)
        collVwLanagugae.register(nibUserDetail, forCellWithReuseIdentifier: "LanguagesCVC")
        
        let nibLanguage = UINib(nibName: "UserDetailCVC", bundle: nil)
        collVwUserDetail.register(nibLanguage, forCellWithReuseIdentifier: "UserDetailCVC")
         
        setCollVwLayout()
    }
    private func setCollVwLayout(){
        let alignedFlowLayoutCollVwHashtag = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .top)
        collVwhastag.collectionViewLayout = alignedFlowLayoutCollVwHashtag
        
        if let flowLayout = collVwhastag.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 0, height: 30)
            flowLayout.itemSize = UICollectionViewFlowLayout.automaticSize
            flowLayout.invalidateLayout()
        }
//        if let flowLayout = collVwUserDetail.collectionViewLayout as? UICollectionViewFlowLayout {
//            flowLayout.estimatedItemSize = CGSize(width: 0, height: 30)
//            flowLayout.itemSize = UICollectionViewFlowLayout.automaticSize
//            flowLayout.invalidateLayout()
//        }
        
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            darkMode()
        }
    }
    private func updateTableViewHeight() {
        if arrReview.count > 0{
            self.heightTblVw.constant = self.tblVwReview.contentSize.height
        }else{
            self.heightTblVw.constant = 70
        }
        tblVwReview.layoutIfNeeded()
        self.view.layoutIfNeeded()
    }
    private func updateHeight(for collectionView: UICollectionView, constraint: NSLayoutConstraint) {
        collectionView.layoutIfNeeded()
        DispatchQueue.main.async {
            if self.arrHashtags.count > 0{
                constraint.constant = collectionView.contentSize.height
            }else{
                constraint.constant = 70
            }
        }
    }
    
    private func darkMode() {
        let isDarkMode = traitCollection.userInterfaceStyle == .dark
        let titleTextColor: UIColor = isDarkMode ? .white : UIColor(hex: "#373737")
        let backImageName = isDarkMode ? "keyboard-backspace25" : "back"
        let viewColor: UIColor = isDarkMode ? UIColor(hex: "#161616") : UIColor(hex: "#F5F4F5")
        
        lblTitleChat.textColor = isDarkMode ? UIColor(hex: "#D9D9D9") : UIColor(hex: "#373737")
        lblTitleRating.textColor = isDarkMode ? UIColor(hex: "#D9D9D9") : UIColor(hex: "#373737")
        lblTitlePrice.textColor = isDarkMode ? UIColor(hex: "#D9D9D9") : UIColor(hex: "#373737")
        lblGender.textColor = isDarkMode ? UIColor(hex: "#D9D9D9") : UIColor(hex: "#373737")
        let labels = [lblScreenTitle, lblName, lblTitleLanguage, lblTitleReview, lblTitleHashtag]
        let views = [viewHashtag, viewLanguage, viewChat, viewrating, viewPrice]
        
        for label in labels {
            label?.textColor = titleTextColor
        }
        
        for view in views {
            view?.backgroundColor = viewColor
        }
        
        btnBack.setImage(UIImage(named: backImageName), for: .normal)
    }
    
    
    
    private func getUserDetail(){
        let isDarkMode = self.traitCollection.userInterfaceStyle == .dark
        arrUserDetails.removeAll()
        arrLanguages.removeAll()
        
        viewModelNote.getUserDetailApi(userId: userId) { [self] data in
            self.arrHashtags = data?.user?.hashtags ?? []
            self.arrLanguages = data?.user?.languages ?? []
            self.arrReview = data?.user?.reviews ?? []
            
            if data?.user?.profileImage == "" || data?.user?.profileImage == nil{
                self.imgVwProfile.image = UIImage(named: "user")
            }else{
                self.imgVwProfile.imageLoad(imageUrl: data?.user?.profileImage ?? "")
            }
            
            self.viewOnline.borderWid = 2
            self.viewOnline.backgroundColor = UIColor(hex: data?.user?.isOnline == true ? "#3E9C35" : "#A9A9A9")
            self.viewOnline.borderCol = UIColor(hex: "#FFFFFF")
            
            self.imgVwProfile.borderWid = 2
            switch data?.user?.badge {
            case "Purple":
                self.imgVwProfile.borderCol = UIColor(hex: "#800080")
            case "Gold":
                self.imgVwProfile.borderCol = UIColor(hex: "#FFD700")
            case "Amber":
                self.imgVwProfile.borderCol = UIColor(hex: "#FFA600")
            case "Neon":
                self.imgVwProfile.borderCol = UIColor(hex: "#00FFFF")
            default:
                self.imgVwProfile.borderCol = .gray
            }
            
            self.lblName.text = data?.user?.name ?? ""
            if data?.user?.videoVerify == 1{
                self.imgVwBlueTick.isHidden = false
            }else{
                self.imgVwBlueTick.isHidden = true
            }
            if data?.user?.gender == 0{
                lblGender.text = "Male"
            }else if data?.user?.gender == 1{
                lblGender.text = "Female"
            }else{
                lblGender.text = "Others"
            }
            self.lblPrice.text = "$\(data?.user?.hoursPrice ?? 0)"
            self.ratingView.rating = Double(data?.user?.rating ?? 0)
            self.lblChatCount.text = "\(data?.user?.chatCount ?? 0)"
           // self.arrUserDetails.append(UserDetailz(title: self.gender, image: isDarkMode ? "genderDark" : "gender"))
            self.arrUserDetails.append(UserDetailz(title: "\(data?.user?.age ?? 0) Years", image: isDarkMode ? "ageDark" : "age"))
            if data?.user?.zodiac ?? "" != ""{
                self.arrUserDetails.append(UserDetailz(title: data?.user?.zodiac ?? "", image: isDarkMode ? "zodiacDark" : "zodiac"))
            }else{
                self.arrUserDetails.append(UserDetailz(title: "N/A", image: isDarkMode ? "zodiacDark" : "zodiac"))
            }
            if data?.user?.ethnicity ?? "" != ""{
                self.arrUserDetails.append(UserDetailz(title: data?.user?.ethnicity ?? "", image: isDarkMode ? "ethnicDark" : "ethnicLight"))
            }else{
                self.arrUserDetails.append(UserDetailz(title: "N/A", image: isDarkMode ? "ethnicDark" : "ethnicLight"))

            }
            
            if self.arrLanguages.count > 0{
                self.lblNoLanguage.isHidden = true
            } else {
                self.lblNoLanguage.isHidden = false
            }
            if data?.user?.reviews?.count ?? 0 > 0{
                self.lblNoReview.isHidden = true
                self.tblVwReview.reloadData()
                self.updateTableViewHeight()
            }else{
                self.lblNoReview.isHidden = false
                self.heightTblVw.constant = 70
            }
            if self.arrHashtags.count > 0{
                self.lblNoHashtag.isHidden = true
            }else{
                self.heightCollVwHshtag.constant = 70
                self.lblNoHashtag.isHidden = false
            }

            self.collVwLanagugae.reloadData()
            self.collVwUserDetail.reloadData()
            self.collVwhastag.reloadData()
            self.updateHeight(for: self.collVwhastag, constraint: self.heightCollVwHshtag)
            collVwhastag.collectionViewLayout.invalidateLayout()
        }
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionAddReview(_ sender: UIButton) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddReviewVC") as! AddReviewVC
//        vc.messageId = self.messageId
//        vc.userId = self.receiverId
//        vc.modalPresentationStyle = .overFullScreen
//        self.navigationController?.present(vc, animated: true)

    }
    
    @IBAction func actionSentInvitation(_ sender: GradientButton) {
        if isRefer == true{
            viewModel.sendReferInvitation(notesId: Store.selectReferData?["notesId"] as? String ?? "", notificationId: Store.selectReferData?["notificationId"] as? String ?? "", referTo: ["\(userId)"], messageId: Store.selectReferData?["messageId"] as? String ?? "") { message in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
                Store.selectReferData = nil
                vc.message = message ?? ""
                vc.callBack = {
                    SceneDelegate().tabBarHomeVCRoot()
                }
                vc.modalPresentationStyle = .overFullScreen
                self.navigationController?.present(vc, animated: false)
            }
            
        }else{
            viewModel.sendInvitationApi(inviteId: userId) { message in
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
                vc.message = message ?? ""
                vc.callBack = {
                    SceneDelegate().tabBarHomeVCRoot()
                }
                vc.modalPresentationStyle = .overFullScreen
                self.navigationController?.present(vc, animated: false)
                
            }
        }
    }
}

//MARK: - TABLEVIEW DELEGATE AND DATASOURCE

extension UserDetailVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrReview.count > 0{
            return arrReview.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTVC", for: indexPath) as! ReviewTVC
        if arrReview.count > 0{
            let isDarkMode = traitCollection.userInterfaceStyle == .dark
            cell.lblReviw.textColor = isDarkMode ? .white : UIColor(hex: "#494949")
            if arrReview[indexPath.row].reviewerProfileImage == "" || arrReview[indexPath.row].reviewerProfileImage == nil{
                cell.imgVwuser.image = UIImage(named: "user")
            }else{
                cell.imgVwuser.imageLoad(imageUrl: arrReview[indexPath.row].reviewerProfileImage ?? "")
            }
            cell.ratingView.rating = Double(arrReview[indexPath.row].starCount ?? 0)
            cell.lblReviw.font = UIFont(name: "Poppins-Regular", size: 12)
            cell.lblReviw.text = arrReview[indexPath.row].comment ?? ""
            if let createdAtDate = dateFromString(arrReview[indexPath.row].createdAt ?? "") {
                cell.lblTime.text = createdAtDate.timeAgoDisplay()
            }

        }
        return cell
    }
    private func dateFromString(_ dateString: String) -> Date? {
        let dateFormatter = ISO8601DateFormatter()
        if let date = dateFormatter.date(from: dateString) {
            return date
        } else {
            let alternativeFormatter = DateFormatter()
            alternativeFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            return alternativeFormatter.date(from: dateString)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        heightTblVw.constant = tblVwReview.contentSize.height+5
    }
    
}
//MARK: - COLLECTIONVIEW DELEGATE AND DATASOURCE
extension UserDetailVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case collVwUserDetail:
            return arrUserDetails.count
        case collVwLanagugae:
            return arrLanguages.count
        default:
            return arrHashtags.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let isDarkMode = traitCollection.userInterfaceStyle == .dark
        if collectionView == collVwUserDetail{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserDetailCVC", for: indexPath) as! UserDetailCVC
            cell.viewBAck.layer.cornerRadius = 15
            cell.viewBAck.borderWid = 1
            cell.viewBAck.borderCol = isDarkMode ? UIColor(hex: "#373737") : UIColor(hex: "#373737")
            cell.lblTitle.textColor = isDarkMode ? UIColor(hex: "#D9D9D9") : UIColor(hex: "#373737")
            cell.lblTitle.text = arrUserDetails[indexPath.row].title ?? "N/A"
            cell.imgVwTitle.image = UIImage(named: arrUserDetails[indexPath.row].image ?? "")
            return cell
        }else if collectionView == collVwhastag{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserDetailCVC", for: indexPath) as! UserDetailCVC
            cell.widthImgVwTitle.constant = 0
            if arrHashtags[indexPath.row].isVerified == 1{
                cell.lblTitle.textColor = .app
            }else{
                cell.lblTitle.textColor = isDarkMode ? UIColor(hex: "#D9D9D9") : UIColor(hex: "#373737")
            }
            cell.lblTitle.font =  cell.lblTitle.font.withSize(12)
            cell.lblTitle.text = "#\(arrHashtags[indexPath.row].title ?? "")"
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LanguagesCVC", for: indexPath) as! LanguagesCVC
            cell.lblTitle.textColor = isDarkMode ? UIColor(hex: "#D9D9D9") : UIColor(hex: "#373737")
            let dot = "\u{2022}"
            cell.lblTitle.text = "\(dot) \(arrLanguages[indexPath.row].name ?? "")"
            return cell
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collVwLanagugae{
            let collectionWidth = collectionView.frame.width
            let itemWidth = (collectionWidth / 2) - 6
            let itemHeight: CGFloat = 30
            return CGSize(width: itemWidth, height: itemHeight)
        }else  if collectionView == collVwUserDetail{
            return CGSize(width:collectionView.frame.size.width / 3 - 10, height: 30)
        }else{
            return CGSize(width:0, height: 30)
        }
        
    }
}
