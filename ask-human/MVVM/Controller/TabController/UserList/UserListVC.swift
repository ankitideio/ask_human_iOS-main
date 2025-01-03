//
//  UserListVC.swift
//  ask-human
//
//  Created by meet sharma on 20/11/23.
//

import UIKit


class UserListVC: UIViewController,UIAdaptivePresentationControllerDelegate{
    
    //MARK: - OUTLET
    
    
    @IBOutlet var btnSentInvitationAndRefer: UIButton!
    @IBOutlet var btnClose: UIButton!
    @IBOutlet var imgSearchIcon: UIImageView!
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
    @IBOutlet weak var clsnVwUserList: UICollectionView!
    
    //MARK: -VARIABLES
    var isSelect = 0
    var search = ""
    var viewModel = NoteVM()
    var viewModelInvie = InvitationVM()
    var arrSearchUser = [Userrr]()
    var arrSearch = [Userrr]()
    var filterData = ""
    var genderr: Int?
    var gendertext:String?
    var selectedIndexPaths: [IndexPath] = []
    var userId = ""
    var longPressGesture: UILongPressGestureRecognizer!
    var arrSelectedUserIds = [""]
    var notificationId = ""
    var messageId = ""
    var notesId = ""
    
    //MARK: - LIFE CYCLE METHOD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardWhileClick))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    @objc func dismissKeyboardWhileClick() {
        view.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        willAppear()
    }
    func willAppear(){
        if Store.isRefer == true{
            btnSentInvitationAndRefer.setTitle("Send Refer", for: .normal)
        }else{
            btnSentInvitationAndRefer.setTitle("Send Invitation", for: .normal)
        }
        darkMode()
        uiSet()
        if Store.isRefer == true{
            searchUser(searchName: search, loader: false,isRefer: true,userId: Store.userIdRefer ?? "")
            
        }else{
            searchUser(searchName: search, loader: false,isRefer: false,userId:"")
            
        }
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            darkMode()
            clsnVwUserList.reloadData()
        }
    }
    
    func darkMode(){
        
        if traitCollection.userInterfaceStyle == .dark {
            lblNOData.textColor = .white
            let placeholderColor =  UIColor(hex: "#E1E1E1")
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: placeholderColor
            ]
            txtFldSearch.attributedPlaceholder = NSAttributedString(string: "Search...", attributes: attributes)
            txtFldSearch.textColor = .white
            btnBack.setImage(UIImage(named: "keyboard-backspace25"), for: .normal)
            btnFilter.setImage(UIImage(named: "filterWhite"), for: .normal)
            btnCross.setImage(UIImage(named: "crosswhite"), for: .normal)
            lblFilterBy.textColor = .white
            lblScreenTitle.textColor = .white
            lblIemSelectedCount.textColor = .white
            viewSearch.backgroundColor = UIColor(hex: "#161616")
            viewSearch.borderWid = 0
            viewSearch.borderCol = .clear
            imgSearchIcon.image = UIImage(named: "Icon - Search25")
            btnClose.backgroundColor =  UIColor(hex: "#272727")
        }else{
            lblNOData.textColor = UIColor(hex: "#6F7179")
            btnCross.setImage(UIImage(named: "crossBlack"), for: .normal)
            btnClose.backgroundColor =  UIColor(hex: "#272727")
            let placeholderColor =  UIColor.placeholder
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: placeholderColor
            ]
            txtFldSearch.attributedPlaceholder = NSAttributedString(string: "Search...", attributes: attributes)
            txtFldSearch.textColor = .black
            imgSearchIcon.image = UIImage(named: "search")
            
            viewSearch.borderWid = 1
            viewSearch.borderCol = UIColor(hex: "#EBEBEB")
            viewSearch.backgroundColor = .white
            btnBack.setImage(UIImage(named: "back"), for: .normal)
            btnFilter.setImage(UIImage(named: "filter"), for: .normal)
            lblFilterBy.textColor = UIColor(hex: "#898989")
            lblScreenTitle.textColor = .black
            lblIemSelectedCount.textColor = .black
            
            
        }
    }
    func uiSet(){
        
        print("isSelectuiload:-\(isSelect)")
        self.vwSearch.isHidden = false
        self.vwAllUserList.isHidden = false
        self.vwItemSelected.isHidden = true
        self.heightStackVwBelowBtns.constant = 0
        print("selectedIndexPaths load: --\(selectedIndexPaths)")
        txtFldSearch.text = search
        
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        longPressGesture.minimumPressDuration = 0.5
        longPressGesture.delegate = self
        clsnVwUserList.addGestureRecognizer(longPressGesture)
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("UserListApi"), object: nil)
    }
    @objc func methodOfReceivedNotification(notification: Notification) {
        
        if Store.isRefer == true{
            searchUser(searchName: search, loader: false,isRefer: true,userId: Store.userIdRefer ?? "")
            
        }else{
            searchUser(searchName: search, loader: false,isRefer: false,userId:"")
            
        }
        
    }
    
    
    func searchUser(searchName: String, loader: Bool, isRefer: Bool, userId: String) {
        arrSelectedUserIds.removeAll()
        selectedIndexPaths.removeAll()
        viewModel.searchUserApi(search: searchName, userId: userId, page: 1, limit: 20, loader: loader, isRefer: isRefer) { data in
            self.arrSearchUser.removeAll()
            self.arrSearch.removeAll()
            DispatchQueue.main.async {
                for i in data?.users ?? [] {
                    if let name = i.name, !name.isEmpty {
                        if self.search == "" {
                            self.arrSearch.append(i)
                        } else {
                            if name.lowercased().contains(self.search.lowercased()) {
                                self.arrSearch.append(i)
                            }
                        }
                    }
                }
                self.arrSearchUser = self.arrSearch
                self.lblNOData.isHidden = !self.arrSearchUser.isEmpty
                self.clsnVwUserList.reloadData()
            }
        }
    }

    //MARK: - ACTION
    @IBAction func actionClose(_ sender: UIButton) {
//        SceneDelegate().userListBackRoot()
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
    
    @IBAction func cancelAllItemSelected(_ sender: UIButton) {
//        SceneDelegate().userListBackRoot()
        SceneDelegate().userListRootneww()
    }
    
    
    
    @IBAction func actionFilter(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "UserFilterVC") as! UserFilterVC
        vc.callBackFilter = {
            if Store.isRefer == true{
                
                self.searchUser(searchName: self.search, loader: false,isRefer: true,userId: Store.userIdRefer ?? "")
                
            }else{
                
                self.searchUser(searchName: self.search, loader: false,isRefer: false,userId:"")
                
            }
            
            
        }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func applyFilters() {
        
        if Store.isRefer == true{
            
            searchUser(searchName: search, loader: false,isRefer: true,userId: Store.userIdRefer ?? "")
            
        }else{
            
            searchUser(searchName: search, loader: false,isRefer: false,userId:"")
            
        }
        
    }
    //MARK: - PRESENTSTYLE DELEGATE METHOD
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
}

//MARK: - COLLECTIONVIEW DELEGATE AND DATASOURCE
var isMultipleSelectionEnabled: Bool = false
extension UserListVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if arrSearchUser.count > 0{
            return arrSearchUser.count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserListCVC", for: indexPath) as! UserListCVC
        if traitCollection.userInterfaceStyle == .dark {
            cell.viewBack.borderWid = 0
            cell.viewBack.borderCol = .clear
            cell.lblName.textColor = .white
            cell.lblDescription.textColor = .white
            cell.viewBack.backgroundColor = UIColor(hex: "#161616")
        }else{
            cell.viewBack.borderWid = 1
            cell.viewBack.borderCol = UIColor(hex: "#E2E2E2")
            cell.lblName.textColor = UIColor(hex: "#434243")
            cell.lblDescription.textColor = UIColor(hex: "#656565")
            cell.viewBack.backgroundColor = .white
            
        }
        if arrSearchUser.count > 0{
            if arrSearchUser[indexPath.row].profileImage == "" || arrSearchUser[indexPath.row].profileImage == nil{
                cell.imgVwUser.image = UIImage(named: "user")
                
            }else{
                cell.imgVwUser.imageLoad(imageUrl: arrSearchUser[indexPath.row].profileImage ?? "")
            }
        
        
            if arrSearchUser[indexPath.row].name == "" || arrSearchUser[indexPath.row].name == nil{
                cell.lblName.text = "No Name"
                
            }else{
                cell.lblName.text = arrSearchUser[indexPath.row].name ?? ""
            }
        
       
            if arrSearchUser[indexPath.row].videoVerify == 1{
                cell.imgVwBlueTick.isHidden = false
            }else{
                cell.imgVwBlueTick.isHidden = true
            }
        
        
            if arrSearchUser[indexPath.row].about == "" || arrSearchUser[indexPath.row].about == nil{
                cell.lblDescription.text = "No About"
                
            }else{
                cell.lblDescription.text = arrSearchUser[indexPath.row].about ?? ""
            }
            let selectedUserId = arrSearchUser[indexPath.row].id ?? ""
            cell.btnMultipleSelect.isSelected = arrSelectedUserIds.contains(selectedUserId)
        }
        
        
        
        
        if isSelect == 0 {
            cell.btnMultipleSelect.isHidden = arrSelectedUserIds.isEmpty
        } else {
            cell.btnMultipleSelect.isHidden = !arrSelectedUserIds.isEmpty
        }
        return cell
    }
    
    @objc func actionMultipleSelect(sender:UIButton){
        sender.isSelected = !sender.isSelected
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if arrSelectedUserIds.count > 0{
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            clsnVwUserList.addGestureRecognizer(tapGesture)
            toggleSelection(at: indexPath)
            
        }else{
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailVC") as! UserDetailVC
            if arrSearchUser.count > 0{
                vc.userId = arrSearchUser[indexPath.row].id ?? ""
                vc.isRefer = Store.isRefer ?? false
                self.navigationController?.pushViewController(vc, animated:true)
            }
            
        }
        
    }
    
    func updateSelectionUI() {
        NotificationCenter.default.post(name: Notification.Name("hideTabBar"), object: nil)
        
        self.vwAllUserList.isHidden = true
        self.stackVwBelowBtns.isHidden = false
        self.heightStackVwBelowBtns.constant = 50
        self.vwSearch.isHidden = true
        self.vwItemSelected.isHidden = false
        
        clsnVwUserList.reloadData()
    }
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        if gesture.state == .ended {
            let point = gesture.location(in: clsnVwUserList)
            
            var indexPath: IndexPath?
            
            if let _indexPath = clsnVwUserList.indexPathForItem(at: point) {
                indexPath = _indexPath
            }
            
            if let indexPath = indexPath {
                print("isSelectsingle:-\(isSelect)")
                toggleSelection(at: indexPath)
                
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
                
                
                //                lblIemSelectedCount.text = "Items Selected(\(arrSelectedUserIds.count))"
            }else{
                showSwiftyAlert("", "You can only select up to 17 users.", false)
                
            }
        }
        
        updateSelectionUI()
        clsnVwUserList.reloadData()
        print("Selected User IDs: \(arrSelectedUserIds)")
        lblIemSelectedCount.text = "\(arrSelectedUserIds.count) Items Selected"
    }
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        
        if gesture.state == .began {
            let point = gesture.location(in: clsnVwUserList)
            if let indexPath = clsnVwUserList.indexPathForItem(at: point) {
                let selectedUserId = arrSearchUser[indexPath.row].id ?? ""
                print("isSelectlong:-\(isSelect)")
                if !arrSelectedUserIds.contains(selectedUserId) {
                    arrSelectedUserIds.append(selectedUserId)
                    //                    lblIemSelectedCount.text = "Items Selected(\(arrSelectedUserIds.count))"
                    updateSelectionUI()
                    lblIemSelectedCount.text = "\(arrSelectedUserIds.count) Items Selected"
                    print("Selected User IDs: \(arrSelectedUserIds)")
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath:
                        
                        IndexPath) -> CGSize {
        return CGSize(width: clsnVwUserList.frame.width/2-8, height: 215)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
extension UserListVC:UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
        search = newString
        if Store.isRefer == true {
            
            searchUser(searchName: newString, loader: false, isRefer: true, userId: Store.userIdRefer ?? "")
            
            
        } else {
            
            searchUser(searchName: newString, loader: false, isRefer: false, userId: "")
            
        }
        
        return true
    }
}
extension UserListVC: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
