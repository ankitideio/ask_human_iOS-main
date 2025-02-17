//
//  NewUserListVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 13/01/25.
//

import UIKit
import AlignedCollectionViewFlowLayout

class NewUserListVC: UIViewController {
    @IBOutlet var tblVwUserList: UITableView!
    @IBOutlet var collVwHashtag: UICollectionView!
    @IBOutlet var heightCollvw: NSLayoutConstraint!
    
    //MARK: -VARIABLES
    var arrHashtags = [Hashtaggs]()
    var isSelect = 0
    var search = ""
    var viewModel = NoteVM()
    var viewModelInvie = InvitationVM()
    var arrSearchUser = [Userrr]()
    var arrSearch = [Userrr]()
    var arrSelectedUserIds = [""]
    var notificationId = ""
    var messageId = ""
    var notesId = ""
    var selectedIndexPaths: [IndexPath] = []
    private let maxHeight: CGFloat = 100
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSet()
    }
    func uiSet(){
        let nibTblVw = UINib(nibName: "NewUserListTVC", bundle: nil)
        tblVwUserList.register(nibTblVw, forCellReuseIdentifier: "NewUserListTVC")

        let nib2 = UINib(nibName: "AddHashtagCVC", bundle: nil)
        collVwHashtag.register(nib2, forCellWithReuseIdentifier: "AddHashtagCVC")
            let alignedFlowLayoutCollVwHashtag = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .top)
            collVwHashtag.collectionViewLayout = alignedFlowLayoutCollVwHashtag
        if let flowLayout = collVwHashtag.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 0, height: 22)
            flowLayout.itemSize = UICollectionViewFlowLayout.automaticSize
            flowLayout.invalidateLayout()
        }
//            if Store.isRefer == true{
//                self.searchUser(searchName: self.search, loader: false,isRefer: true,userId: Store.userIdRefer ?? "")
//            }else{
//                self.searchUser(searchName: self.search, loader: false,isRefer: false,userId:"")
//            }
        self.collVwHashtag.reloadData()
        self.heightCollvw.constant = self.collVwHashtag.contentSize.height
        self.updateCollectionViewHeight()

    }
    private func updateCollectionViewHeight() {
        updateHeight(for: collVwHashtag, constraint: heightCollvw)
        }
        
    private func updateHeight(for collectionView: UICollectionView, constraint: NSLayoutConstraint) {
        collectionView.layoutIfNeeded()
        collectionView.collectionViewLayout.invalidateLayout()
        
        // Ensure collection view has been fully laid out before getting content size
        DispatchQueue.main.async {
            let contentHeight = collectionView.contentSize.height
                    constraint.constant = min(contentHeight, self.maxHeight)
        }
    }
//    func searchUser(searchName: String, loader: Bool, isRefer: Bool, userId: String) {
//        print("API responsesearchUser: \("searchUser")")
//        arrSelectedUserIds.removeAll()
//        selectedIndexPaths.removeAll()
//        viewModel.searchUserApi(search: searchName, userId: userId, page: 1, limit: 20, loader: loader, isRefer: isRefer) { data in
//            self.arrSearchUser.removeAll()
//            self.arrSearch.removeAll()
//                Store.userHashtags = data
//                for i in data?.users ?? [] {
//                    if let name = i.name, !name.isEmpty {
//                        if self.search == "" {
//                            self.arrSearch.append(i)
//                        } else {
//                            if name.lowercased().contains(self.search.lowercased()) {
//                                self.arrSearch.append(i)
//                            }
//                        }
//                    }
//                }
//                self.arrSearchUser = self.arrSearch
////                self.lblNOData.isHidden = !self.arrSearchUser.isEmpty
//                //self.clsnVwUserList.reloadData()
//                
////                if Store.searchHastag?.count ?? 0 > 0{
////                    self.viewAppliedHahstag.isHidden = false
////                    self.viewBtnAddOnly.isHidden = true
////                }else{
////                    self.viewBtnAddOnly.isHidden = false
////                    self.viewAppliedHahstag.isHidden = true
////                }
//            
//        }
//    }
}
//MARK: - UITableViewDelegate
extension NewUserListVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSearch.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewUserListTVC", for: indexPath) as! NewUserListTVC
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
