//
//  UserListVC.swift
//  ask-human
//
//  Created by meet sharma on 20/11/23.
//

import UIKit
import AlignedCollectionViewFlowLayout


class UserListVC: UIViewController,UIAdaptivePresentationControllerDelegate{
    
    //MARK: - OUTLET
    
    @IBOutlet var scrollVw: UIScrollView!
    @IBOutlet var heightTxtVw: NSLayoutConstraint!
    @IBOutlet var txtVwQuestion: UITextView!
    @IBOutlet var lblFoundUsercount: UILabel!
    @IBOutlet var heightTblVwUserList: NSLayoutConstraint!
    @IBOutlet var tblVwUserList: UITableView!
    @IBOutlet var btnClearAll: UIButton!
    @IBOutlet var viewAppliedHahstag: UIView!
    @IBOutlet var collVwHashtag: UICollectionView!
    @IBOutlet var heightCollvw: NSLayoutConstraint!
    @IBOutlet var btnSentInvitationAndRefer: UIButton!
    @IBOutlet var btnClose: UIButton!
    @IBOutlet var btnCross: UIButton!
    @IBOutlet var viewSearch: UIView!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var lblFilterBy: UILabel!
    @IBOutlet var btnFilter: UIButton!
    @IBOutlet var lblScreenTitle: UILabel!
    @IBOutlet var lblNOData: UILabel!
    @IBOutlet var heightStackVwBelowBtns: NSLayoutConstraint!
    @IBOutlet var stackVwBelowBtns: UIStackView!
    @IBOutlet var lblIemSelectedCount: UILabel!
    @IBOutlet var vwSearch: UIView!
    @IBOutlet var vwItemSelected: UIView!
    @IBOutlet var vwAllUserList: UIView!
    @IBOutlet weak var txtFldSearch: UITextField!
    
    //MARK: -VARIABLES
    
    var arrHashtags = [Hashtaggs]()
    var search = ""
    var viewModel = NoteVM()
    var viewModelInvie = InvitationVM()
    var arrSearchUser = [Userrr]()
    var genderr: Int?
    var gendertext:String?
    var selectedIndexPaths: [IndexPath] = []
    var userId = ""
    var arrSelectedUserIds = [""]
    var notificationId = ""
    var messageId = ""
    var notesId = ""
    var isClickCell = true
    private let maxHeight: CGFloat = 100
    var isLoading = false
    var offset = 1
    var limit = 10
    var totalPages = 0
    var arrMedia = [Any]()
    var isLongPress = false
    //MARK: - LIFE CYCLE METHOD
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSet()
        collVwAlignment()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        longPressGesture.minimumPressDuration = 0.5
        longPressGesture.delegate = self
        tblVwUserList.addGestureRecognizer(longPressGesture)
    }
    
    //MARK: - uiSet
    func uiSet(){
        scrollVw.delegate = self
        txtVwQuestion.delegate = self
        getTrendingHahstagApi()
        if Store.isRefer == true{
            txtVwQuestion.isUserInteractionEnabled = false
            btnSentInvitationAndRefer.setTitle("Send Refer", for: .normal)
        }else{
            txtVwQuestion.isUserInteractionEnabled = true
            let tapGestureTextview = UITapGestureRecognizer(target: self, action: #selector(handleTapOnTextView))
            txtVwQuestion.addGestureRecognizer(tapGestureTextview)
            btnSentInvitationAndRefer.setTitle("Send Invitation", for: .normal)
        }
        darkMode()
        vwSearch.isHidden = false
        vwAllUserList.isHidden = false
        vwItemSelected.isHidden = true
        heightStackVwBelowBtns.constant = 0
        txtFldSearch.text = search
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOnSearchView))
        viewSearch.addGestureRecognizer(tapGesture)
        
        let nib2 = UINib(nibName: "AddHashtagCVC", bundle: nil)
        collVwHashtag.register(nib2, forCellWithReuseIdentifier: "AddHashtagCVC")
        let nibTblVw = UINib(nibName: "NewUserListTVC", bundle: nil)
        tblVwUserList.register(nibTblVw, forCellReuseIdentifier: "NewUserListTVC")
        
        getUserListApi(isLoader: true)
    }
    //MARK: - adjustTextViewHeight
    private func adjustTextViewHeight() {
        let fittingSize = CGSize(width: txtVwQuestion.frame.width, height: CGFloat.greatestFiniteMagnitude)
        let newSize = txtVwQuestion.sizeThatFits(fittingSize)
        heightTxtVw.constant = newSize.height
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    //MARK: - collVwAlignment
    private func collVwAlignment(){
        let alignedFlowLayoutCollVwHashtag = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .top)
        collVwHashtag.collectionViewLayout = alignedFlowLayoutCollVwHashtag
        if let flowLayout = collVwHashtag.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 0, height: 22)
            flowLayout.itemSize = UICollectionViewFlowLayout.automaticSize
            flowLayout.invalidateLayout()
        }
        
        
    }
    //MARK: - handleTapOnTextView
    @objc func handleTapOnTextView(_ gesture: UITapGestureRecognizer) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditQuestionVC") as! EditQuestionVC
        vc.modalPresentationStyle = .overFullScreen
        vc.question = txtVwQuestion.text ?? ""
        vc.callBAck = {
            self.getUserListApi(isLoader: false)
        }
        self.navigationController?.present(vc, animated: true)
    }
    //MARK: - handleTapOnSearchView
    @objc func handleTapOnSearchView(_ gesture: UITapGestureRecognizer) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddHashtagVC") as! AddHashtagVC
        vc.modalPresentationStyle = .overFullScreen
        vc.isComing = true
        vc.arrNewHashtags = Store.searchHastag ?? []
        vc.callBack = { [weak self] hashtags, isSkip in
            guard let self = self else { return }
            offset = 1
            Store.searchHastag = hashtags
            self.getAppliedHashtags()
            DispatchQueue.main.async {
                self.uiSet()
            }
        }
        self.navigationController?.present(vc, animated: true)
    }
    //MARK: - getTrendingHahstagApi
    private func getTrendingHahstagApi(){
        viewModel.getTrendingHashtagApi { data in
            DispatchQueue.main.async {
                self.arrHashtags = data?.hashtags ?? []
            }
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            darkMode()
        }
    }
    
    //MARK: - update collectionview Height
    private func updateHeight(for collectionView: UICollectionView, constraint: NSLayoutConstraint) {
        collectionView.layoutIfNeeded()
        collectionView.collectionViewLayout.invalidateLayout()
        DispatchQueue.main.async {
            let contentHeight = collectionView.contentSize.height
            constraint.constant = contentHeight
            self.updateHeight(for: self.collVwHashtag, constraint: self.heightCollvw)
        }
    }
    //MARK: - darkMode
    private func darkMode(){
        let isDarkMode = traitCollection.userInterfaceStyle == .dark
        
        lblNOData.textColor = isDarkMode ? UIColor(hex: "#6F7179") : UIColor(hex: "#6F7179")
        lblFilterBy.textColor = isDarkMode ? .white : UIColor(hex: "#898989")
        lblScreenTitle.textColor = isDarkMode ? .white : .black
        lblIemSelectedCount.textColor = isDarkMode ? .white : .black
        
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.placeholder]
        txtFldSearch.attributedPlaceholder = NSAttributedString(string: "Choose hashtag", attributes: attributes)
        txtFldSearch.textColor = isDarkMode ? .white : .black
        
        btnBack.setImage(UIImage(named: isDarkMode ? "keyboard-backspace25" : "back"), for: .normal)
        btnFilter.setImage(UIImage(named: isDarkMode ? "filterWhite" : "filter"), for: .normal)
        btnCross.setImage(UIImage(named: isDarkMode ? "crosswhite" : "crossBlack"), for: .normal)
        
        
        viewSearch.borderWid = 1
        viewSearch.borderCol =  UIColor(hex: "#CCCCCC")
        viewSearch.backgroundColor = isDarkMode ? UIColor.black : .white
        
        btnClose.backgroundColor = isDarkMode ? UIColor.white : UIColor(hex: "#272727")
        btnClose.setTitleColor(isDarkMode ? UIColor.black : .white, for: .normal)
    }
    //MARK: - getUserListApi
    private func getUserListApi(isLoader:Bool){
        self.searchUser(searchName: self.search, loader: isLoader, userId: Store.userIdRefer ?? "", page: self.offset,
                        limit: self.limit,
                        gender:Store.filterGender?["Gender"] as? [Int] ?? [],
                        ethnicity: Store.filterDetail?["Ethnicity"] as? [String] ?? [],
                        zodiac: Store.filterDetail?["Zodiac"] as? [String] ?? [],
                        language: Store.filterDetail?["language"] as? [String] ?? [],
                        minPrice: Store.filterMinMaxValues?["minPrice"] as? String ?? "",
                        maxPrice:  Store.filterMinMaxValues?["maxPrice"] as? String ?? "",
                        hashtags:  Store.searchHastag ?? [],
                        minage:  Store.filterMinMaxValues?["minAge"] as? String ?? "",
                        maxage:  Store.filterMinMaxValues?["maxAge"] as? String ?? "",
                        rating:  Store.filterMinMaxValues?["rating"] as? String ?? "")
        
    }
    
    func searchUser(searchName: String, loader: Bool, userId: String, page: Int, limit: Int, gender: [Int],
                    ethnicity: [String], zodiac: [String], language: [String], minPrice: String, maxPrice: String,
                    hashtags: [String], minage: String, maxage: String, rating: String) {
        print("API responsesearchUser: \("searchUser")")
        if page == 1 {
            arrSelectedUserIds.removeAll()
            selectedIndexPaths.removeAll()
            arrSearchUser.removeAll()
        }
        isLoading = true
        viewModel.searchUserApi(search: searchName, userId: userId, page: page, limit: limit, gender: gender, ethnicity: ethnicity, zodiac: zodiac, language: language, minPrice: minPrice, maxPrice: maxPrice, hashtags: hashtags, minage: minage, maxage: maxage, rating: rating, loader: loader) { [weak self] data in
            guard let self = self else { return }
            self.totalPages = data?.totalPages ?? 0
            self.arrSearchUser.append(contentsOf: data?.users ?? [])
            self.isLoading = false
            
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont(name: "Poppins", size: 14),
                .foregroundColor: UIColor(hex: "#0E76C0"),
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .underlineColor: UIColor(hex: "#0E76C0")
            ]
            txtVwQuestion.attributedText = NSAttributedString(string: Store.question ?? "", attributes: attributes)
            adjustTextViewHeight()
            let isDarkMode = traitCollection.userInterfaceStyle == .dark
            if let totalCount = data?.totalCount, totalCount > 0 {
                let fullText = "\(totalCount) responders found for your question:"
                let attributedString = NSMutableAttributedString(string: fullText)
                let countRange = (fullText as NSString).range(of: "\(totalCount)")
                attributedString.addAttribute(.foregroundColor, value: UIColor.app, range: countRange)
                let textRange = (fullText as NSString).range(of: "responders found for your question:")
                attributedString.addAttribute(.foregroundColor, value:isDarkMode ? UIColor(hex: "#CCCCCC") : UIColor(hex: "#373737"), range: textRange)
                self.lblFoundUsercount.attributedText = attributedString
            } else {
                self.lblFoundUsercount.text = "No responders found for your question."
                self.lblFoundUsercount.textColor = UIColor(hex: "#373737")
            }
            // self.lblNOData.isHidden = !self.arrSearchUser.isEmpty
            self.heightTblVwUserList.constant = CGFloat(self.arrSearchUser.count * 120)
            self.tblVwUserList.reloadData()
            self.getAppliedHashtags()
            self.collVwHashtag.reloadData()
        }
    }
    func getAppliedHashtags(){
        viewAppliedHahstag.isHidden = Store.searchHastag?.isEmpty ?? true
        collVwHashtag.reloadData()
        heightCollvw.constant = collVwHashtag.contentSize.height
        updateHeight(for: collVwHashtag, constraint: heightCollvw)
    }
    
    //MARK: - ACTION
    @IBAction func actionClearAll(_ sender: UIButton) {
        Store.searchHastag = nil
        getAppliedHashtags()
        uiSet()
    }
    @IBAction func actionClose(_ sender: UIButton) {
        isLongPress = false
    SceneDelegate().userListRootneww()
    }
    @IBAction func actionBack(_ sender: UIButton) {
        if Store.isRefer == true{
            self.navigationController?.popViewController(animated: true)
        }else{
            SceneDelegate().notificationsRoot(selectTab: 1)
        }
    }
    @IBAction func actionSentInvitation(_ sender: UIButton) {
        if arrSelectedUserIds.isEmpty{
            showSwiftyAlert("", "No user selected", false)
        }else{
            if Store.isRefer == true{
                viewModelInvie.sendReferInvitation(notesId: Store.selectReferData?["notesId"] as? String ?? "", notificationId: Store.selectReferData?["notificationId"] as? String ?? "", referTo: arrSelectedUserIds, messageId: Store.selectReferData?["messageId"] as? String ?? "") { message in
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
                    vc.modalPresentationStyle = .overFullScreen
                    Store.selectReferData = nil
                    vc.message = message ?? ""
                    vc.callBack = {
                        SceneDelegate().tabBarHomeVCRoot()
                    }
                    self.navigationController?.present(vc, animated: false)
                }
                
            }else{
                viewModelInvie.sendMultipleInvitationsApi(inviteId: arrSelectedUserIds, notesId: Store.notesId ?? "") { message in
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
                    vc.modalPresentationStyle = .overFullScreen
                    vc.message = message
                    vc.callBack = {
                        SceneDelegate().tabBarHomeVCRoot()
                    }
                    self.navigationController?.present(vc, animated: false)
                }
            }
        }
    }
    
    @IBAction func cancelAllItemSelected(_ sender: UIButton) {
        isLongPress = false
        SceneDelegate().userListRootneww()
    }
    @IBAction func actionFilter(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FiltersVC") as! FiltersVC
        vc.modalPresentationStyle = .overFullScreen
        vc.arrTrendingHashtags = arrHashtags
        vc.callBack = {[weak self] in
            guard let self = self else { return }
            self.arrSearchUser.removeAll()
            offset = 1
            self.getAppliedHashtags()
            self.uiSet()
            self.tblVwUserList.reloadData()
        }
        self.navigationController?.present(vc, animated: true)
    }
    //MARK: - PRESENTSTYLE DELEGATE METHOD
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}

//MARK: - COLLECTIONVIEW DELEGATE AND DATASOURCE
extension UserListVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if Store.searchHastag?.count ?? 0 > 0{
            return Store.searchHastag?.count ?? 0
        }else{
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddHashtagCVC", for: indexPath) as! AddHashtagCVC
        cell.leadingLblHashtag.constant = 15
        cell.trailingLblHashtag.constant = 10
        cell.viewBack.borderWid = 0
        cell.viewBack.borderCol = .clear
        cell.viewBack.layer.cornerRadius = cell.viewBack.frame.height / 2
        cell.viewBtnDelete.isHidden = false
        cell.btnDelete.tag = indexPath.row
        cell.btnDelete.addTarget(self, action: #selector(actionDelete), for: .touchUpInside)
        cell.lblHashtag.text = Store.searchHastag?[indexPath.row]
        let isDarkMode = traitCollection.userInterfaceStyle == .dark
        cell.imgVwDeleteBtn.image = isDarkMode ? UIImage(named: "darkCros") : UIImage(named: "crossTag")
        cell.viewBack.backgroundColor = isDarkMode ? UIColor(hex: "#610D38") : UIColor(hex: "#EE0C81").withAlphaComponent(0.20)
        cell.lblHashtag.textColor = isDarkMode ? UIColor(hex: "#CCCCCC") : UIColor(hex: "#373737")
        
        return cell
    }
    func updateheightCollVwHashtags() {
        heightCollvw.constant = collVwHashtag.contentSize.height
    }
    @objc func actionDelete(sender:UIButton){
        view.endEditing(true)
        if Store.searchHastag?.count ?? 0 > 0{
            if !isLoading{
                Store.searchHastag?.remove(at: sender.tag)
                getAppliedHashtags()
                getUserListApi(isLoader: false)
            }
        }else{
            viewAppliedHahstag.isHidden = true
        }
        
    }
    @objc func actionMultipleSelect(sender:UIButton){
        sender.isSelected = !sender.isSelected
    }
    func updateSelectionUI() {
        DispatchQueue.main.async {
            self.viewAppliedHahstag.isHidden = true
            self.vwAllUserList.isHidden = true
            self.stackVwBelowBtns.isHidden = false
            self.heightStackVwBelowBtns.constant = 55
            self.vwSearch.isHidden = true
            self.vwItemSelected.isHidden = false
            self.txtVwQuestion.isHidden = true
            self.lblFoundUsercount.isHidden = true
            self.tblVwUserList.reloadData()
        }
        
    }
    func updateDeSelectionUI() {
        DispatchQueue.main.async {
            self.viewAppliedHahstag.isHidden = false
            self.vwAllUserList.isHidden = false
            self.stackVwBelowBtns.isHidden = true
            self.heightStackVwBelowBtns.constant = 0
            self.vwSearch.isHidden = false
            self.vwItemSelected.isHidden = true
            self.txtVwQuestion.isHidden = false
            self.lblFoundUsercount.isHidden = false
            self.tblVwUserList.reloadData()
        }
        
    }
    
}
//MARK: - UITextFieldDelegate
extension UserListVC:UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
        search = newString
        return true
    }
}
//MARK: - UIGestureRecognizerDelegate
extension UserListVC: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
//MARK: - UITableViewDelegate
extension UserListVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrSearchUser.count > 0{
            return arrSearchUser.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewUserListTVC", for: indexPath) as! NewUserListTVC
        if arrSearchUser.count > 0 {
            let isDarkMode = traitCollection.userInterfaceStyle == .dark
            cell.viewBAck.backgroundColor = isDarkMode ? UIColor(hex: "#161616") :  UIColor(hex: "#EE0C81").withAlphaComponent(0.07)
            cell.lblName.textColor = isDarkMode ? UIColor.white : .black
            cell.btnAsk.setImage(isDarkMode ? UIImage(named: "darkHalfask") : UIImage(named: "newAsk"), for: .normal)
            cell.lblTitlerating.textColor = isDarkMode ? UIColor(hex: "#CCCCCC") : UIColor(hex: "#363636")
            cell.lblTitleChat.textColor = isDarkMode ? UIColor(hex: "#CCCCCC") : UIColor(hex: "#363636")
            cell.lblTitlePrice.textColor = isDarkMode ? UIColor(hex: "#CCCCCC") : UIColor(hex: "#363636")
            
            let selectedUserId = arrSearchUser[indexPath.row].id ?? ""
            if arrSelectedUserIds.contains(selectedUserId) {
                cell.viewBAck.borderWid = 1
                cell.viewBAck.borderCol = .app
                cell.imgVwSelected.isHidden = false
            } else {
                cell.imgVwSelected.isHidden = true
                cell.viewBAck.borderWid = 0
                cell.viewBAck.borderCol = .clear
                
            }
            cell.viewOnline.borderWid = 2
            if arrSearchUser[indexPath.row].isOnline == true{
                cell.viewOnline.backgroundColor = UIColor(hex: "#3E9C35")
                cell.viewOnline.borderCol = UIColor(hex: "#FFFFFF")
            }else{
                cell.viewOnline.backgroundColor = UIColor(hex: "#A9A9A9")
                cell.viewOnline.borderCol = UIColor(hex: "#FFFFFF")
            }
            
            cell.imgVwUser.borderWid = 2
            if arrSearchUser[indexPath.row].badge == "Purple"{
                cell.imgVwUser.borderCol = UIColor(hex: "#800080")
            }else if arrSearchUser[indexPath.row].badge == "Gold"{
                cell.imgVwUser.borderCol = UIColor(hex: "#FFD700")
            }else if arrSearchUser[indexPath.row].badge == "Amber"{
                cell.imgVwUser.borderCol = UIColor(hex: "#FFA600")
            }else if arrSearchUser[indexPath.row].badge == "Neon"{
                cell.imgVwUser.borderCol = UIColor(hex: "#00FFFF")
            }else{
                cell.imgVwUser.borderCol = .gray
            }
            cell.ratingVw.rating = arrSearchUser[indexPath.row].rating ?? 0
            cell.lblPrice.text = "$\(arrSearchUser[indexPath.row].hoursPrice ?? 0)"
            cell.lblChatCount.text = "\(arrSearchUser[indexPath.row].chatCount ?? 0)"
            cell.btnAsk.tag = indexPath.row
            cell.btnAsk.addTarget(self, action: #selector(actionAsk), for: .touchUpInside)
            if arrSearchUser[indexPath.row].profileImage == "" || arrSearchUser[indexPath.row].profileImage == nil {
                cell.imgVwUser.image = UIImage(named: "user")
            } else {
                cell.imgVwUser.imageLoad(imageUrl: arrSearchUser[indexPath.row].profileImage ?? "")
            }
            if arrSearchUser[indexPath.row].name == "" || arrSearchUser[indexPath.row].name == nil {
                cell.lblName.text = "No Name"
            } else {
                cell.lblName.text = arrSearchUser[indexPath.row].name ?? ""
            }
            if let hashtags = arrSearchUser[indexPath.row].hashtags, !hashtags.isEmpty {
                let attributedString = NSMutableAttributedString()
                for (index, hashtag) in hashtags.enumerated() {
                    if let title = hashtag.title {
                        let color: UIColor = hashtag.isVerified == 1 ? .app : (isDarkMode ? .white : .black)
                        
                        let attributes: [NSAttributedString.Key: Any] = [
                            .foregroundColor: color
                        ]
                        let coloredHashtag = NSAttributedString(string: "#\(title)", attributes: attributes)
                        attributedString.append(coloredHashtag)
                        if index < hashtags.count - 1 {
                            attributedString.append(NSAttributedString(string: ", "))
                        }
                    }
                }
                cell.lblHashtags.attributedText = attributedString
            } else {
                cell.lblHashtags.text = "No hashtag"
                cell.lblHashtags.textColor = isDarkMode ? .white : .black
            }
            
            if arrSearchUser[indexPath.row].videoVerify == 1 {
                cell.imgVwBlueTick.isHidden = false
            } else {
                cell.imgVwBlueTick.isHidden = true
            }
        }
        
        return cell
    }
    
    @objc func actionAsk(sender:UIButton){
        if !isLongPress{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailVC") as! UserDetailVC
            vc.userId = arrSearchUser[sender.tag].id ?? ""
            vc.isRefer = Store.isRefer ?? false
            vc.callBack = { [weak self] in
                guard let self = self else { return }
                viewWillAppear(true)
                viewDidLoad()
                collVwAlignment()
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        
        if gesture.state == .ended {
            let point = gesture.location(in: tblVwUserList)
            if let indexPath = tblVwUserList.indexPathForRow(at: point) {
                toggleSelection(at: indexPath)
                if let cell = tblVwUserList.cellForRow(at: indexPath) as? NewUserListTVC {
                    let selectedUserId = arrSearchUser[indexPath.row].id ?? ""
                    if arrSelectedUserIds.contains(selectedUserId) {
                        cell.imgVwSelected.isHidden = false
                        cell.viewBAck.borderWid = 1
                        cell.viewBAck.borderCol = .app
                    } else {
                        cell.imgVwSelected.isHidden = true
                        cell.viewBAck.borderWid = 0
                        cell.viewBAck.borderCol = .clear
                    }
                    print("handleTaparrSelectedUserIds:-\(arrSelectedUserIds)")
                }
            }
        }
    }
    
    func toggleSelection(at indexPath: IndexPath) {
        let selectedUserId = arrSearchUser[indexPath.row].id ?? ""
        
        if arrSelectedUserIds.contains(selectedUserId) {
            arrSelectedUserIds.removeAll { $0 == selectedUserId }
        } else {
            if arrSelectedUserIds.count < 17 {
                arrSelectedUserIds.append(selectedUserId)
            }else{
                showSwiftyAlert("", "You can only select up to 17 users.", false)
                
            }
        }
        print("toggleSelectionarrSelectedUserIds:-\(arrSelectedUserIds)")
        updateSelectionUI()
        lblIemSelectedCount.text = "\(arrSelectedUserIds.count) Items Selected"
    }
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let point = gesture.location(in: tblVwUserList)
            if let indexPath = tblVwUserList.indexPathForRow(at: point) {
                isLongPress = true
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
                tapGesture.delegate = self
                tblVwUserList.addGestureRecognizer(tapGesture)
                
                let selectedUserId = arrSearchUser[indexPath.row].id ?? ""
                if let index = arrSelectedUserIds.firstIndex(of: selectedUserId) {
                    arrSelectedUserIds.remove(at: index)
                } else {
                    arrSelectedUserIds.append(selectedUserId)
                }
                updateSelectionUI()
                lblIemSelectedCount.text = "\(arrSelectedUserIds.count) Items Selected"
                tblVwUserList.reloadData()
                print("handleLongPressarrSelectedUserIds:-\(arrSelectedUserIds)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
//MARK: - UIScrollViewDelegate
extension UserListVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentHeight = scrollView.contentSize.height
        let scrollPosition = scrollView.contentOffset.y
        let tableHeight = scrollView.frame.size.height
        
        if contentHeight - scrollPosition <= tableHeight && !isLoading {
            if offset < totalPages {
                offset += 1
                getUserListApi(isLoader: false)
            }
        }
    }
}
//MARK: - UITextViewDelegate
extension UserListVC:UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            viewModel.addNoteApi(note: textView.text ?? "", media: arrMedia, status: "1"){ data,message in
                Store.question = data?.createNotes?.note ?? ""
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.getUserListApi(isLoader: true)
                }
            }
            return false
        }
        return true
    }
    func textViewDidChange(_ textView: UITextView) {
        adjustTextViewHeight()
    }
}
//            if Store.isRefer == true{
//                self.searchUser(searchName: self.search, loader: true,isRefer: true,userId: Store.userIdRefer ?? "",page: pages,limit: limit)
//            }else{
//                self.searchUser(searchName: self.search, loader: true,isRefer: false,userId:"",page: pages,limit: limit)
//            }
